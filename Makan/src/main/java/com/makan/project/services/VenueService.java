package com.makan.project.services;

import org.springframework.stereotype.Service;

import com.makan.project.models.Venue;
import com.makan.project.repositories.VenueRepositories;

@Service
public class VenueService {
    private final VenueRepositories venueRepositories;
    public VenueService(VenueRepositories venueRepositories) {
        this.venueRepositories = venueRepositories;
    }
    public void addVenue(Venue venue) {
        venueRepositories.save(venue);
    }
    public Venue getVenueById(Long id) {
        return venueRepositories.findById(id).orElse(null);
    }
    
}
