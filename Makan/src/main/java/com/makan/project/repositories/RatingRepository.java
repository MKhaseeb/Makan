package com.makan.project.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.makan.project.models.Rating;

public interface RatingRepository extends CrudRepository<Rating, Long>{
    List<Rating> findByVenueId(Long venueId);
    List<Rating> findByUserId(Long userId);
}
