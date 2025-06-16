package com.makan.project.repositories;

import java.util.List;
import org.springframework.data.repository.CrudRepository;
import com.makan.project.models.Rating;

public interface RatingRepositories extends CrudRepository<Rating, Integer> {
    List<Rating> findByVenueId(int venueId);
    List<Rating> findByUserName(String userName);
}
