package com.makan.project.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.makan.project.models.Message;

import jakarta.transaction.Transactional;

@Repository
public interface MessageRepository extends CrudRepository<Message, Long> {

    @Query("SELECT COUNT(m) FROM Message m WHERE m.isRead = false")
    long countUnreadMessages();
    @Override
    List<Message> findAll();

    List<Message> findAllByOrderBySentAtDesc();
    
    int countByIsReadFalse();

    @Modifying
    @Transactional
    @Query("UPDATE Message m SET m.isRead = true WHERE m.isRead = false")
    void markAllAsRead();


}
