package com.makan.project.services;
import java.util.Date;

import com.makan.project.models.Booking;
import com.makan.project.models.Rating;
import com.makan.project.models.User;
import com.makan.project.models.Venue;
import com.makan.project.repositories.BookingRepository;
import com.makan.project.repositories.RatingRepository;
import com.makan.project.repositories.UserRepository;
import com.makan.project.repositories.VenueRepository;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RatingService {
	@Autowired
	private BookingRepository bookingRepository;


    @Autowired
    private RatingRepository ratingRepository;

    @Autowired
    private VenueRepository venueRepository;

    @Autowired
    private UserRepository userRepository;

    public Rating addRating(Long venueId, Long userId, Long bookingId, int score, String comment) {
        Venue venue = venueRepository.findById(venueId)
            .orElseThrow(() -> new RuntimeException("القاعة غير موجودة"));

        User user = userRepository.findById(userId)
            .orElseThrow(() -> new RuntimeException("المستخدم غير موجود"));

        Booking booking = bookingRepository.findById(bookingId)
            .orElseThrow(() -> new RuntimeException("الحجز غير موجود"));

        Rating rating = new Rating();
        rating.setVenue(venue);
        rating.setUser(user);
        rating.setBooking(booking);
        rating.setScore(score);
        rating.setComment(comment);
        rating.setUserName(user.getFirstname() + " " + user.getLastname());

        return ratingRepository.save(rating);
    }

    public Double getAverageRating(Long venueId) {
        List<Rating> ratings = ratingRepository.findByVenueId(venueId);
        if (ratings.isEmpty()) return 0.0;

        double sum = ratings.stream().mapToInt(Rating::getScore).sum();
        return sum / ratings.size();
    }

    public List<Rating> getRatingsForVenue(Long venueId) {
        return ratingRepository.findByVenueId(venueId);
    }

}
