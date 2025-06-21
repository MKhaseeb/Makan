package com.makan.project.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.makan.project.models.ChatMessage;
import com.makan.project.models.ChatSummary;
import com.makan.project.repositories.ChatMessageRepository;
import com.makan.project.models.User;  // استبدل بموديل المستخدم لديك
import com.makan.project.services.LogRegService;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ChatMessageService {

    @Autowired
    private ChatMessageRepository chatMessageRepository;

    @Autowired
    private LogRegService logRegService;  // خدمة المستخدمين (لجلب اسم المرسل)

    // جلب جميع الرسائل في محادثة معينة مع تعبئة senderName
    public List<ChatMessage> getMessagesByChatId(String chatId) {
        List<ChatMessage> messages = chatMessageRepository.findByChatIdOrderByTimestampAsc(chatId);
        for (ChatMessage msg : messages) {
            User sender = logRegService.findUserById(msg.getSenderId());
            if (sender != null) {
                msg.setSenderName(sender.getFirstname() + " " + sender.getLastname());
            }
        }
        return messages;
    }

    // حفظ رسالة مع تعبئة اسم المرسل
    public ChatMessage saveMessage(ChatMessage chatMessage) {
        User sender = logRegService.findUserById(chatMessage.getSenderId());
        if (sender != null) {
            chatMessage.setSenderName(sender.getFirstname() + " " + sender.getLastname());
        }
        return chatMessageRepository.save(chatMessage);
    }


    // جلب ملخصات المحادثات للمالك - تحتاج لتعديل حسب متطلباتك
    public List<ChatMessage> getChatsForOwner(Long ownerId) {
        // هنا استدعي الريبو المناسب أو اكتب استعلام مخصص لجلب ملخصات الدردشة
        return chatMessageRepository.findChatsByOwnerId(ownerId);
    }
    
    public List<ChatSummary> getChatSummariesForOwner(Long ownerId) {
        List<ChatMessage> messages = chatMessageRepository.findChatsByOwnerId(ownerId);

        // استخدام LinkedHashMap للحفاظ على ترتيب الإدخال
        Map<String, ChatMessage> lastMessagesMap = new LinkedHashMap<>();

        for (ChatMessage msg : messages) {
            // إذا المحادثة غير موجودة في الخريطة، أضفها (بما أن القائمة مرتبة تنازلياً بالوقت، هذا آخر رسالة)
            if (!lastMessagesMap.containsKey(msg.getChatId())) {
                lastMessagesMap.put(msg.getChatId(), msg);
            }
        }

        // تحويل إلى ChatSummary مع تعبئة اسم المرسل
        List<ChatSummary> summaries = lastMessagesMap.values().stream().map(msg -> {
            String senderName = "";
            if (msg.getSenderId() != null) {
                var user = logRegService.findUserById(msg.getSenderId());
                if (user != null) {
                    senderName = user.getFirstname() + " " + user.getLastname();
                }
            }
            return new ChatSummary(
                    msg.getChatId(),
                    senderName,
                    msg.getContent(),
                    msg.getTimestamp()
            );
        }).collect(Collectors.toList());

        return summaries;
    }
}
