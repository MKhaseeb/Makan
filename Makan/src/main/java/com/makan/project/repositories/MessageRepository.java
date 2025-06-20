package com.makan.project.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.makan.project.models.Message;

@Repository
public interface MessageRepository extends CrudRepository<Message, Long> {

    @Query("SELECT COUNT(m) FROM Message m WHERE m.isRead = false")
    long countUnreadMessages();
    @Override
    List<Message> findAll();

}
