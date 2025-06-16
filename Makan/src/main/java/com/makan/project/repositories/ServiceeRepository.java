package com.makan.project.repositories;

import java.util.List;


import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.makan.project.models.Servicee;

@Repository
public interface ServiceeRepository extends CrudRepository<Servicee, Long> {
    List<Servicee> findByNameContainingIgnoreCase(String name);

    // Additional query methods can be defined here if needed

}
