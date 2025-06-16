package com.makan.project.repositories;

import java.util.List;


import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.makan.project.models.Rating;

@Repository
public interface RatingRepository extends CrudRepository<Rating, Long>{

}
