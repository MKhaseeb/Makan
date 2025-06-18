package com.makan.project.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.makan.project.models.Booking;
import com.makan.project.models.Venue;
import com.makan.project.repositories.BookingRepository;
import com.makan.project.repositories.VenueRepository;

@Service
public class VenueService {
    private final VenueRepository venueRepositories;
    private final BookingRepository bookingRepository;

    public VenueService(VenueRepository venueRepositories, BookingRepository bookingRepository) {
        this.venueRepositories = venueRepositories;
        this.bookingRepository = bookingRepository;
    }

    public void addVenue(Venue venue) {
        venueRepositories.save(venue);
    }

    public Venue getVenueById(Long id) {
        return venueRepositories.findById(id).orElse(null);
    }

    public List<Venue> allVenue() {
        return venueRepositories.findAll();
    }

    public List<Venue> searchByKeyword(String keyword) {
        return venueRepositories.findByNameContainingIgnoreCaseOrCityContainingIgnoreCase(keyword, keyword);
    }

    public List<Venue> searchByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return venueRepositories.findAll();
        }
        return venueRepositories.findByNameContainingIgnoreCase(name.trim());
    }

    public List<Venue> findVenuesByOwnerId(Long ownerId) {
        return venueRepositories.findByOwnerId(ownerId);
    }

    public List<Booking> findBookingsByOwnerId(Long ownerId) {
        return bookingRepository.findAllByVenueOwnerId(ownerId);
    }
}
