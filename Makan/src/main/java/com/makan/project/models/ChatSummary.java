package com.makan.project.models;

import java.time.LocalDateTime;

public class ChatSummary {
    private String chatId;
    private String senderName;
    private String lastMessage;
    private LocalDateTime lastTimestamp;

    public ChatSummary() {}

    public ChatSummary(String chatId, String senderName, String lastMessage, LocalDateTime lastTimestamp) {
        this.chatId = chatId;
        this.senderName = senderName;
        this.lastMessage = lastMessage;
        this.lastTimestamp = lastTimestamp;
    }

    public String getChatId() {
        return chatId;
    }

    public void setChatId(String chatId) {
        this.chatId = chatId;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getLastMessage() {
        return lastMessage;
    }

    public void setLastMessage(String lastMessage) {
        this.lastMessage = lastMessage;
    }

    public LocalDateTime getLastTimestamp() {
        return lastTimestamp;
    }

    public void setLastTimestamp(LocalDateTime lastTimestamp) {
        this.lastTimestamp = lastTimestamp;
    }
}
