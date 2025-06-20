package com.makan.project.models;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "message") // ✳️ تأكد من أن اسم الجدول هو "messages"

public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String email;
    private String phone;
    private String message;
    private boolean isRead;
    private String content;
    private LocalDateTime sentAt; // ✳️ أضف هذا السطر



    public Message(String name, String email, String phone, String message) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.message = message;
        this.isRead = false; // Default to unread
    }

    public Message() {
        this.sentAt = LocalDateTime.now(); // ✳️ عيّنه تلقائيًا
    }

    
    public Long getId() {
        return id;
    }


    public void setId(Long id) {
        this.id = id;
    }


    public LocalDateTime getSentAt() {
        return sentAt;
    }


    public void setSentAt(LocalDateTime sentAt) {
        this.sentAt = sentAt;
    }


    public boolean isRead() {
        return isRead;
    }
    public void setRead(boolean isRead) {
        this.isRead = isRead;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    // Getters
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getMessage() { return message; }
}
