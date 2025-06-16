package com.makan.project.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.makan.project.models.Booking;
import com.makan.project.models.Servicee;

public interface BookingRepository extends CrudRepository<Booking, Long>{
    List<Booking> findByServiceId(Long serviceId);
    List<Booking> findByUserId(Long userId);
    

}
