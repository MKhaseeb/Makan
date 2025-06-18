package com.makan.project.repositories;

import java.util.List;


import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.makan.project.models.Venue;
@Repository
public interface VenueRepository extends CrudRepository<Venue, Long> {
    List<Venue> findByNameContainingIgnoreCase(String name);
	List<Venue> findAll();
	List<Venue> findByNameContainingIgnoreCaseOrCityContainingIgnoreCase(String name, String city);

	List<Venue> findByOwnerId(Long ownerId);

    List<Venue> findByNameStartingWithIgnoreCase(String name);


}
