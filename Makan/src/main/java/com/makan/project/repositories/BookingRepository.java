package com.makan.project.repositories;

import java.util.List;


import org.springframework.data.repository.CrudRepository;

import com.makan.project.models.Booking;

public interface BookingRepository extends CrudRepository<Booking, Long> {
    List<Booking> findByVenueId(Long venueId);
    List<Booking> findByUserId(Long userId);

}
