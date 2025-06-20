package com.makan.project.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.makan.project.models.Message;
import com.makan.project.repositories.MessageRepository;

@Service
public class MessageService {

    private final MessageRepository messageRepository;

    @Autowired
    public MessageService(MessageRepository messageRepository) {
        this.messageRepository = messageRepository;
    }

    public void saveMessage(Message message) {
        messageRepository.save(message);
    }

    public List<Message> getAllMessages() {
        return messageRepository.findAllByOrderBySentAtDesc();
    }


    public boolean hasUnreadMessages() {
        // ممكن تضيف خاصية isRead للـ Message وتستخدمها هون
        return !messageRepository.findAll().isEmpty();
    }

    public boolean deleteMessage(Long id) {
        Optional<Message> messageOptional = messageRepository.findById(id);
        if (messageOptional.isPresent()) {
            messageRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public List<Message> findAll() {
    // Implementation to retrieve all messages
    return new ArrayList<>(); // Replace with actual logic to fetch messages
    }
    
}
