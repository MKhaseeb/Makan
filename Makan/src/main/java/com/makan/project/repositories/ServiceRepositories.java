package com.makan.project.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.makan.project.models.Service;

@Repository
public interface ServiceRepositories extends CrudRepository<Service, Long> {
    List<Service> findByNameContainingIgnoreCase(String name);

    // Additional query methods can be defined here if needed

}
