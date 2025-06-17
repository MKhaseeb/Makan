package com.makan.project.services;

import org.springframework.beans.factory.annotation.Autowired;

import com.makan.project.models.Rating;
import com.makan.project.repositories.RatingRepository;

public class RatingService {
	
	@Autowired
	RatingRepository ratingRepository;
	
    public void addRating(Rating rating) {
    	ratingRepository.save(rating);
    }
    public Rating getBookingById(Long id) {
        return ratingRepository.findById(id).orElse(null);
    }

}
