package com.makan.project.controllers;

import com.makan.project.models.Rating;
import com.makan.project.services.RatingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/api/ratings")
public class RatingController {

    @Autowired
    private RatingService ratingService;
    
    
    public static class RatingRequest {
        public Long venueId;
        public Long userId;
        public Long bookingId;
        public int score;
        public String comment;
    }

    // إضافة تقييم جديد (POST)
    @PostMapping("/add")
    public ResponseEntity<?> addRating(@RequestBody RatingRequest request) {
        if (request.score < 1 || request.score > 5) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("error", "القيمة يجب أن تكون بين 1 و 5"));
        }
        try {
            Rating rating = ratingService.addRating(request.venueId, request.userId, request.bookingId, request.score, request.comment);
            return ResponseEntity.ok(Collections.singletonMap("message", "تم حفظ التقييم بنجاح"));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("error", e.getMessage()));
        }
    }




    // جلب متوسط التقييم لقاعة معينة (GET)
    @GetMapping("/average/{venueId}")
    public ResponseEntity<Double> getAverageRating(@PathVariable Long venueId) {
        Double avg = ratingService.getAverageRating(venueId);
        return ResponseEntity.ok(avg);
    }

    // جلب كل التقييمات لقاعة معينة (GET)
    @GetMapping("/venue/{venueId}")
    public ResponseEntity<List<Rating>> getRatingsForVenue(@PathVariable Long venueId) {
        List<Rating> ratings = ratingService.getRatingsForVenue(venueId);
        return ResponseEntity.ok(ratings);
    }
    


} 
