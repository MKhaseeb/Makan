package com.makan.project.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.makan.project.models.ChatMessage;

import java.util.List;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
	List<ChatMessage> findByChatIdOrderByTimestampAsc(String chatId);
    List<ChatMessage> findByReceiverIdOrderByTimestampAsc(Long receiverId);
    @Query("SELECT DISTINCT c FROM ChatMessage c WHERE c.receiverId = :ownerId ORDER BY c.timestamp DESC")
    List<ChatMessage> findChatsByOwnerId(@Param("ownerId") Long ownerId);
}