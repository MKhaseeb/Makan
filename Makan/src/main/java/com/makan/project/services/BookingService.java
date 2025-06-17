package com.makan.project.services;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.makan.project.models.Booking;
import com.makan.project.repositories.BookingRepository;

@Service
public class BookingService {
	@Autowired
	BookingRepository bookingRepository;
	
    public void addBooking(Booking booking) {
    	bookingRepository.save(booking);
    }
    public Booking getBookingById(Long id) {
        return bookingRepository.findById(id).orElse(null);
    }
    
    
    public List<LocalDate> getBookedDatesForVenue(Long venueId) {
        List<Booking> bookings = bookingRepository.findByVenueId(venueId);
        List<LocalDate> dates = new ArrayList<>();
        for (Booking booking : bookings) {
            dates.add(booking.getEventDate()); 
        }
        return dates;
    }


}
