package com.makan.project.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.makan.project.models.Booking;
<<<<<<< HEAD:Makan/src/main/java/com/makan/project/repositories/BookingRepositories.java

public interface BookingRepositories extends CrudRepository<Booking, Long> {
    List<Booking> findByVenueId(Long venueId);
    List<Booking> findByUserId(Long userId);
=======
import com.makan.project.models.Servicee;

public interface BookingRepository extends CrudRepository<Booking, Long>{
    List<Booking> findByServiceId(Long serviceId);
    List<Booking> findByUserId(Long userId);
    

>>>>>>> bbfa58a6efc72e01280868bbdaf02c89186e7796:Makan/src/main/java/com/makan/project/repositories/BookingRepository.java
}
