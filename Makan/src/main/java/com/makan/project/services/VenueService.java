package com.makan.project.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.makan.project.models.Venue;
import com.makan.project.repositories.VenueRepository;



@Service
public class VenueService {
    private final VenueRepository venueRepositories;
    public VenueService(VenueRepository venueRepositories) {
        this.venueRepositories = venueRepositories;
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
    
    public List<Venue> filterVenues(String city, String search, Integer maxPrice, Integer minCapacity) {
        return venueRepositories.filterVenues(city, search, maxPrice, minCapacity);
    }

    

    
}
