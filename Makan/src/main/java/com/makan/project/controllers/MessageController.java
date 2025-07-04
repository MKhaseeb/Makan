package com.makan.project.controllers;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.makan.project.models.ChatSummary;
import com.makan.project.models.Message;
import com.makan.project.models.User;
import com.makan.project.services.ChatMessageService;
import com.makan.project.services.MessageService;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
public class MessageController {

    private final MessageService messageService;

    public MessageController(MessageService messageService) {
        this.messageService = messageService;
    }

    @Autowired
    private ChatMessageService chatMessageService;
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
                              @RequestParam("message") String message,
                              @RequestParam("date") String date) {

        Message newMessage = new Message(name, email, phone, message);

        try {
            if (date != null && !date.isEmpty()) {
                newMessage.setSentAt(LocalDate.parse(date).atStartOfDay());
            } else {
                newMessage.setSentAt(LocalDateTime.now());
            }
        } catch (Exception e) {
            newMessage.setSentAt(LocalDateTime.now());
        }

        messageService.saveMessage(newMessage);

        return "redirect:/homes";
    }


    @GetMapping("/message")
    public String viewMessages(Model model) {
        List<Message> messages = messageService.getAllMessages();
        model.addAttribute("messages", messages);
        return "messages.jsp";
    }


    // حذف رسالة حسب id
    @PostMapping("/deleteMessage")
    public ResponseEntity<Map<String, Object>> deleteMessage(@RequestParam Long id) {
        boolean success = messageService.deleteMessage(id);
        Map<String, Object> response = new HashMap<>();
        response.put("success", success);

        if (success) {
            return ResponseEntity.ok(response); // 200 OK + {"success": true}
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response); // 404 + {"success": false}
        }
    }
    
    @GetMapping("/admin/messages")
    @Transactional
    public String showMessages(Model model) {
        messageService.markAllAsRead();
        List<Message> messages = messageService.getAllMessages(); // ← استخدم getAllMessages() بدل getAllMessagesSorted()
        model.addAttribute("messages", messages);
        return "admin/messages";
    }


    @GetMapping("/messages/unread-count")
    @ResponseBody
    public int getUnreadMessagesCount() {
        return messageService.countUnreadMessages(); // ✅ تم النقل
    }


    
//    
//    
//
//    @GetMapping("/owner/dashboard")
//    public String ownerDashboard(Model model, HttpSession session) {
//        User owner = (User) session.getAttribute("user");
//        if (owner == null) {
//            return "redirect:/login";
//        }
//
//        List<ChatSummary> chatSummaries = chatMessageService.getChatSummariesForOwner(owner.getId());
//        model.addAttribute("chatSummaries", chatSummaries);
//
//        return "ownerDashboard";  // صفحة JSP الخاصة بلوحة تحكم المالك
//    }


}
