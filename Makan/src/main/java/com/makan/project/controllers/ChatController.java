package com.makan.project.controllers;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.*;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.makan.project.models.ChatMessage;
import com.makan.project.repositories.ChatMessageRepository;

import jakarta.servlet.http.HttpSession;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.List;

@RestController
public class ChatController {

    @Autowired
    private ChatMessageRepository chatMessageRepository;

    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

    @GetMapping("/api/chat/{chatId}/messages")
    public List<ChatMessage> getMessages(@PathVariable String chatId) {
        return chatMessageRepository.findByChatIdOrderByTimestampAsc(chatId);
    }

    @MessageMapping("/chat/{chatId}/send")
    public void sendMessage(@DestinationVariable String chatId, ChatMessage message) {
        message.setTimestamp(LocalDateTime.now());
        message.setChatId(chatId);
        chatMessageRepository.save(message);
        simpMessagingTemplate.convertAndSend("/topic/chat/" + chatId, message);
    }


    @GetMapping("/api/owner/{ownerId}/chats")
    public List<ChatMessage> getChatsForOwner(@PathVariable Long ownerId) {
        return chatMessageRepository.findByReceiverIdOrderByTimestampAsc(ownerId);
    }
    
    @GetMapping("/chatRoom")
    public String openChatRoom(@RequestParam String chatId, Model model, HttpSession session) {
        // Optional: Add current user or chat info to model
        model.addAttribute("chatId", chatId);
        model.addAttribute("user", session.getAttribute("user"));
        return "chatRoom."; // Must match chatRoom.jsp inside /WEB-INF/
    }
    
    
}

