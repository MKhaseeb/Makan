package com.makan.project.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.makan.project.models.Message;
import com.makan.project.services.MessageService;

@Controller
public class MessageController {

    private final MessageService messageService;

    public MessageController(MessageService messageService) {
        this.messageService = messageService;
    }

    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        boolean hasUnread = messageService.hasUnreadMessages();
        model.addAttribute("hasUnreadMessages", hasUnread);
        return "Home.jsp";
    }

    @PostMapping("/message/send")
    public String sendMessage(@RequestParam String name,
                              @RequestParam String email,
                              @RequestParam(required = false) String phone,
                              @RequestParam("message") String message) {

        Message newMessage = new Message(name, email, phone, message);
        messageService.saveMessage(newMessage);

        return "redirect:/homes";
    }

    @GetMapping("/message")
    public String viewMessages(Model model) {
        List<Message> messages = messageService.getAllMessages();
        model.addAttribute("messages", messages);
        return "messages.jsp";
    }

    @PostMapping("/deleteMessage")
    public ResponseEntity<Map<String, Object>> deleteMessage(@RequestParam Long id) {
        Map<String, Object> response = new HashMap<>();
        if (messageService.deleteMessage(id)) {
            response.put("success", true);
        } else {
            response.put("success", false);
            response.put("error", "الرسالة غير موجودة");
        }
        return ResponseEntity.ok(response);
    }

}
