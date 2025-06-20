package com.makan.project.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.makan.project.models.Booking;
import com.makan.project.models.Venue;

import jakarta.transaction.Transactional;

public interface BookingRepository extends CrudRepository<Booking, Long> {
    List<Booking> findByVenueId(Long venueId);
    List<Booking> findByUserId(Long userId);
    List<Booking> findAllByVenueOwnerId(Long ownerId);
    List<Booking> findByVenueIn(List<Venue> venues);
    @Transactional
    @Modifying
    @Query("DELETE FROM Booking b WHERE b.venue.id = :venueId")
    void deleteByVenueId(@Param("venueId") Long venueId);

    

}
