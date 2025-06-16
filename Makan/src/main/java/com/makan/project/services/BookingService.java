package com.makan.project.services;

import org.springframework.beans.factory.annotation.Autowired;

import com.makan.project.models.Booking;
import com.makan.project.repositories.BookingRepository;

public class BookingService {
	@Autowired
	BookingRepository bookingRepository;
	
    public void addBooking(Booking booking) {
    	bookingRepository.save(booking);
    }
    public Booking getBookingById(Long id) {
        return bookingRepository.findById(id).orElse(null);
    }

}
