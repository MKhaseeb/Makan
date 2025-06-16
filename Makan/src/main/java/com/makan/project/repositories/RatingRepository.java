package com.makan.project.repositories;

import java.util.List;
import org.springframework.data.repository.CrudRepository;
import com.makan.project.models.Rating;

<<<<<<< HEAD:Makan/src/main/java/com/makan/project/repositories/RatingRepositories.java
public interface RatingRepositories extends CrudRepository<Rating, Integer> {
    List<Rating> findByVenueId(int venueId);
    List<Rating> findByUserName(String userName);
=======
public interface RatingRepository extends CrudRepository<Rating, Long>{
    List<Rating> findByVenueId(Long venueId);
    List<Rating> findByUserId(Long userId);
>>>>>>> bbfa58a6efc72e01280868bbdaf02c89186e7796:Makan/src/main/java/com/makan/project/repositories/RatingRepository.java
}
