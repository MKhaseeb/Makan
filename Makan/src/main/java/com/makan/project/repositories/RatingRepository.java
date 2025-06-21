package com.makan.project.repositories;

import com.makan.project.models.Rating;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RatingRepository extends JpaRepository<Rating, Long> {

    // جلب كل التقييمات لقاعة معينة
    List<Rating> findByVenueId(Long venueId);

    // حساب المتوسط لقاعة معينة
    @Query("SELECT AVG(r.score) FROM Rating r WHERE r.venue.id = :venueId")
    Double findAverageRatingByVenueId(@Param("venueId") Long venueId);

}
