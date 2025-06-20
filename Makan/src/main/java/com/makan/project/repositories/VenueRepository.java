package com.makan.project.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.makan.project.models.User;
import com.makan.project.models.Venue;
@Repository
public interface VenueRepository extends JpaRepository<Venue, Long> {
    List<Venue> findByNameContainingIgnoreCase(String name);
	List<Venue> findAll();
	List<Venue> findByNameContainingIgnoreCaseOrCityContainingIgnoreCase(String name, String city);

	List<Venue> findByOwnerId(Long ownerId);
	Venue findByOwner(User owner);
    List<Venue> findByNameStartingWithIgnoreCase(String name);


}
