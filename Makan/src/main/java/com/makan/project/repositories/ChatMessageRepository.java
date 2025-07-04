package com.makan.project.repositories;

import com.makan.project.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.makan.project.models.ChatMessage;

import java.util.List;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
	List<ChatMessage> findByChatIdOrderByTimestampAsc(String chatId);
    List<ChatMessage> findByReceiverIdOrderByTimestampAsc(Long receiverId);
    @Query("SELECT c FROM ChatMessage c WHERE c.senderId = :ownerId OR c.receiverId = :ownerId ORDER BY c.timestamp DESC")
    List<ChatMessage> findChatsByOwnerId(@Param("ownerId") Long ownerId);
    public interface UserRepository extends JpaRepository<User, Long> {}

}