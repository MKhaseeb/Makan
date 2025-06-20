package com.makan.project.models;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.util.Date;
import java.time.ZoneId;


@Entity
@Table(name = "message") // تأكد أن اسم الجدول صحيح في قاعدة البيانات
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

    private LocalDateTime sentAt;

    // الكونستركتور الافتراضي (بدون تعيين sentAt تلقائي)
    public Message() {
    }

    // كونستركتور مع الحقول الرئيسية (يمكنك إضافته عند الحاجة)
    public Message(String name, String email, String phone, String message) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.message = message;
        this.isRead = false; // الحالة الافتراضية: غير مقروء
    }

    // --- getters and setters ---

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
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

    public LocalDateTime getSentAt() {
        return sentAt;
    }

    public void setSentAt(LocalDateTime sentAt) {
        this.sentAt = sentAt;
    }
    public Date getSentAtAsDate() {
        if (sentAt == null) return null;
        return Date.from(sentAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
