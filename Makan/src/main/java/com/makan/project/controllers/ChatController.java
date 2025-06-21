package com.makan.project.controllers;
import com.makan.project.services.ChatMessageService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.*;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.makan.project.models.ChatMessage;
import com.makan.project.models.User;
import com.makan.project.repositories.ChatMessageRepository;
import com.makan.project.services.LogRegService;

import jakarta.servlet.http.HttpSession;

import java.time.LocalDateTime;
import java.util.List;

@Controller
public class ChatController {

    @Autowired
    private ChatMessageService chatMessageService;  // استخدم الخدمة بدلاً من الريبو

    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

    @Autowired
    LogRegService logRegService;

    @GetMapping("/api/chat/{chatId}/messages")
    @ResponseBody
    public List<ChatMessage> getMessages(@PathVariable String chatId) {
        return chatMessageService.getMessagesByChatId(chatId);
    }

    @MessageMapping("/chat/{chatId}/send")
    public void sendMessage(@DestinationVariable String chatId, @Payload ChatMessage chatMessage) {
        chatMessage.setChatId(chatId);
        chatMessage.setTimestamp(LocalDateTime.now());

        // ملئ senderName قبل الحفظ
        User user = logRegService.findUserById(chatMessage.getSenderId());
        if (user != null) {
            chatMessage.setSenderName(user.getFirstname() + " " + user.getLastname());
        }


        ChatMessage saved = chatMessageService.saveMessage(chatMessage);

        simpMessagingTemplate.convertAndSend("/topic/chat/" + chatId, saved);
    }

    // جلب ملخصات المحادثات للمالك (يجب تعديل الخدمة لتدعم هذا)
    @GetMapping("/api/owner/{ownerId}/chats")
    @ResponseBody
    public List<ChatMessage> getChatsForOwner(@PathVariable Long ownerId) {
        return chatMessageService.getChatsForOwner(ownerId);
    }

    @GetMapping("/chatRoom")
    public String openChatRoom(@RequestParam String chatId, Model model, HttpSession session) {
        model.addAttribute("chatId", chatId);
        model.addAttribute("user", session.getAttribute("user"));
        return "chatRoom";
    }
}
