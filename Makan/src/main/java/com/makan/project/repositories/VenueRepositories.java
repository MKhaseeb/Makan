package com.makan.project.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.makan.project.models.Venue;

public interface VenueRepositories extends CrudRepository<Venue, Long> {
    List<Venue> findByNameContainingIgnoreCase(String name);

}
