package com.makan.project.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.makan.project.models.Venue;

public interface VenueRepository extends CrudRepository<Venue, Long> {
    List<Venue> findByNameContainingIgnoreCase(String name);
	List<Venue> findAll();

    @Query("SELECT v FROM Venue v " +
        "WHERE (:city IS NULL OR v.city = :city) " +
        "AND (:search IS NULL OR LOWER(v.name) LIKE LOWER(CONCAT('%', :search, '%')) " +
        "     OR LOWER(v.description) LIKE LOWER(CONCAT('%', :search, '%'))) " +
        "AND (:maxPrice IS NULL OR v.pricePerDay <= :maxPrice) " +
        "AND (:minCapacity IS NULL OR v.capacity >= :minCapacity)")
    List<Venue> filterVenues(
        @Param("city") String city,
        @Param("search") String search,
        @Param("maxPrice") Integer maxPrice,
        @Param("minCapacity") Integer minCapacity);


}
