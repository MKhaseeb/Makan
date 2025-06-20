package com.makan.project.controllers;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

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

    @GetMapping("{chatId}")
    public String openChatRoom(@PathVariable String chatId, HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");

        // ✅ Check if the user is logged in
        if (userId == null) {
            return "redirect:/"; // or "redirect:/login"
        }

        // ✅ Get the current user from the session/database
        User currentUser = logRegService.findUserById(userId);

        // ✅ Fetch all messages for this chat
        List<ChatMessage> messages = chatMessageRepository.findByChatIdOrderByTimestampAsc(chatId);

        // ✅ Pass data to the JSP view
        model.addAttribute("chatId", chatId);
        model.addAttribute("messages", messages);
        model.addAttribute("user", currentUser); // in case you need it in the view
        session.setAttribute("user", currentUser); // make sure ${sessionScope.user} works

        return "chatRoom.jsp"; // This must match your JSP file name
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
    
    
    
    @GetMapping("/owner/inbox")
    public String showInbox(Model model, HttpSession session) {
        Long ownerId = (Long) session.getAttribute("userId");
        if (ownerId == null) return "redirect:/login";

        List<ChatMessage> allMessages = chatMessageRepository.findByReceiverIdOrderByTimestampAsc(ownerId);
        Set<String> chatIds = allMessages.stream()
                .map(ChatMessage::getChatId)
                .collect(Collectors.toSet());

        model.addAttribute("chatIds", chatIds);
        model.addAttribute("ownerId", ownerId);
        return "ownerInbox.jsp"; // Maps to /WEB-INF/ownerInbox.jsp
    }
}
