package com.makan.project.services;

import java.util.List;
import java.util.Optional;

import com.makan.project.models.Message;
import com.makan.project.repositories.MessageRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MessageService {

    private final MessageRepository messageRepository;

    @Autowired
    public MessageService(MessageRepository messageRepository) {
        this.messageRepository = messageRepository;
    }

    // ✅ حفظ رسالة جديدة
    public void saveMessage(Message message) {
        messageRepository.save(message);
    }

    // ✅ إرجاع كل الرسائل مرتبة تنازليًا حسب وقت الإرسال
    public List<Message> getAllMessages() {
        return messageRepository.findAllByOrderBySentAtDesc();
    }

    // ✅ تعليم كل الرسائل كمقروءة
    @Transactional
    public void markAllAsRead() {
        messageRepository.markAllAsRead();
    }

    // ✅ عدد الرسائل غير المقروءة
    public int countUnreadMessages() {
        return messageRepository.countByIsReadFalse();
    }

    // ✅ هل يوجد رسائل غير مقروءة؟
    public boolean hasUnreadMessages() {
        return countUnreadMessages() > 0;
    }

    // ✅ حذف رسالة بناءً على ID
    public boolean deleteMessage(Long id) {
        Optional<Message> messageOptional = messageRepository.findById(id);
        if (messageOptional.isPresent()) {
            messageRepository.deleteById(id);
            return true;
        }
        return false;
    }
}
