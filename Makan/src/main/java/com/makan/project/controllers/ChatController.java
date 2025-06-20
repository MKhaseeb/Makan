package com.makan.project.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.*;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.makan.project.models.ChatMessage;
import com.makan.project.repositories.ChatMessageRepository;
import com.makan.project.services.LogRegService;

import jakarta.servlet.http.HttpSession;

import java.time.LocalDateTime;
import java.util.List;

@Controller  // changed from @RestController to support returning views
public class ChatController {

    @Autowired
    private ChatMessageRepository chatMessageRepository;

    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;
    
    @Autowired
    LogRegService logRegService;

    @GetMapping("/api/chat/{chatId}/messages")
    @ResponseBody  // return JSON list
    public List<ChatMessage> getMessages(@PathVariable String chatId) {
        return chatMessageRepository.findByChatIdOrderByTimestampAsc(chatId);
    }

    @MessageMapping("/chat/{chatId}/send")
    public void sendMessage(@DestinationVariable String chatId, @Payload ChatMessage chatMessage) {
        System.out.println("Received message for chatId: " + chatId);
        System.out.println("Message content: " + chatMessage.getContent());
        System.out.println("SenderId: " + chatMessage.getSenderId());
        System.out.println("ReceiverId: " + chatMessage.getReceiverId());

        chatMessage.setChatId(chatId);
        chatMessage.setTimestamp(LocalDateTime.now());

        try {
            ChatMessage saved = chatMessageRepository.save(chatMessage);
            System.out.println("Saved message with id: " + saved.getId());
            simpMessagingTemplate.convertAndSend("/topic/chat/" + chatId, saved);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @GetMapping("/api/owner/{ownerId}/chats")
    @ResponseBody
    public List<ChatMessage> getChatsForOwner(@PathVariable Long ownerId) {
        return chatMessageRepository.findByReceiverIdOrderByTimestampAsc(ownerId);
    }
    
    @GetMapping("/chatRoom")
    public String openChatRoom(@RequestParam String chatId, Model model, HttpSession session) {
        model.addAttribute("chatId", chatId);
        model.addAttribute("user", session.getAttribute("user"));
        return "chatRoom";  // match chatRoom.jsp filename without dot
    }
}
