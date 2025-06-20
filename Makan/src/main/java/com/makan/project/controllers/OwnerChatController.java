package com.makan.project.controllers;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.makan.project.models.ChatMessage;
import com.makan.project.models.User;
import com.makan.project.repositories.ChatMessageRepository;
import com.makan.project.services.LogRegService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/owner/chat")
public class OwnerChatController {

    @Autowired
    private ChatMessageRepository chatMessageRepository;

    @Autowired
    private LogRegService logRegService;

    @GetMapping("/{chatId}")
    public String showChat(@PathVariable String chatId, HttpSession session, Model model) {
        Long ownerId = (Long) session.getAttribute("userId");
        User owner = (User) session.getAttribute("user");

        if (ownerId == null || owner == null || !owner.getRole().equals("owner")) {
            return "redirect:/login";
        }

        List<ChatMessage> messages = chatMessageRepository.findByChatIdOrderByTimestampAsc(chatId);

        // لتحميل أسماء المرسلين - يجب تهيئة senderName لكل رسالة
        for (ChatMessage msg : messages) {
            User sender = logRegService.findUserById(msg.getSenderId());
            msg.setSenderName(sender != null ? sender.getFirstname() : "مستخدم مجهول");
        }

        model.addAttribute("messages", messages);
        model.addAttribute("chatId", chatId);
        model.addAttribute("ownerId", ownerId);

        return "chatRoom.jsp";
    }

    @PostMapping("/{chatId}/send")
    public String sendMessage(@PathVariable String chatId,
                              @RequestParam("content") String content,
                              HttpSession session) {
        Long ownerId = (Long) session.getAttribute("userId");
        User owner = (User) session.getAttribute("user");

        if (ownerId == null || owner == null || !owner.getRole().equals("owner")) {
            return "redirect:/login";
        }

        // استخرج الطرف الآخر من chatId
        // لو chatId هو ownerId-userId مثلا "3-7"
        String[] parts = chatId.split("-");
        Long receiverId = null;
        if (parts.length == 2) {
            Long part1 = Long.parseLong(parts[0]);
            Long part2 = Long.parseLong(parts[1]);
            receiverId = (part1.equals(ownerId)) ? part2 : part1;
        }

        ChatMessage message = new ChatMessage();
        message.setChatId(chatId);
        message.setSenderId(ownerId);
        message.setReceiverId(receiverId);
        message.setContent(content);
        message.setTimestamp(LocalDateTime.now());

        chatMessageRepository.save(message);

        return "redirect:/owner/chat/" + chatId;
    }
}
