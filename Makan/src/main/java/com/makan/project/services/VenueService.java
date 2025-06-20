package com.makan.project.services;
import java.util.stream.Collectors;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.makan.project.models.Booking;
import com.makan.project.models.User;
import com.makan.project.models.Venue;
import com.makan.project.repositories.BookingRepository;
import com.makan.project.repositories.LogRegRepository;
import com.makan.project.repositories.RatingRepository;
import com.makan.project.repositories.VenueRepository;

import jakarta.transaction.Transactional;

@Service
public class VenueService {
    private final VenueRepository venueRepositories;
    private final BookingRepository bookingRepository;
    @Autowired
    private LogRegRepository logRegRepository;
    @Autowired
    private RatingRepository ratingRepository;
    


    public VenueService(VenueRepository venueRepositories, BookingRepository bookingRepository) {
        this.venueRepositories = venueRepositories;
        this.bookingRepository = bookingRepository;
        this.ratingRepository = ratingRepository;
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

    public List<Venue> searchByKeyword(String keyword) {
        return venueRepositories.findByNameContainingIgnoreCaseOrCityContainingIgnoreCase(keyword, keyword);
    }

    public List<Venue> searchByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return venueRepositories.findAll();
        }
        return venueRepositories.findByNameContainingIgnoreCase(name.trim());
    }
    public List<Venue> findVenuesByOwnerId(Long ownerId) {
        return venueRepositories.findByOwnerId(ownerId);
    }

    public List<Booking> findBookingsByOwnerId(Long ownerId) {
        return bookingRepository.findAllByVenueOwnerId(ownerId);
    }

    
    public List<Venue> searchByNameStartsWith(String name) {
        if (name == null || name.trim().isEmpty()) {
            return venueRepositories.findAll();
        }
        return venueRepositories.findByNameStartingWithIgnoreCase(name.trim());
    }
    

    
    public List<Venue> filterVenues(String city, String village, Integer maxPrice, Integer minCapacity) {
        return venueRepositories.findAll().stream()
            .filter(v -> city == null || city.isEmpty() || v.getCity().equalsIgnoreCase(city))
            .filter(v -> village == null || village.isEmpty() || 
            (v.getVillage() != null && v.getVillage().equalsIgnoreCase(village)))

            .filter(v -> maxPrice == null || v.getPricePerDay() <= maxPrice)
            .filter(v -> minCapacity == null || v.getCapacity() >= minCapacity)
            .collect(Collectors.toList()); // ✅ هذا هو الصح
    }

    @Transactional
    public List<Venue> deleteVenue(Long venueId) {
        bookingRepository.deleteByVenueId(venueId);
        venueRepositories.deleteById(venueId);
        return venueRepositories.findAll();
    }

    public boolean deleteVenueWithRelations(Long id) {
        Venue venue = venueRepositories.findById(id).orElse(null);
        if (venue == null) {
            System.out.println("المعرف غير موجود");
            return false;
        }
    
        // حذف الحجوزات المرتبطة
        if (venue.getBookings() != null) {
            bookingRepository.deleteAll(venue.getBookings());
        }
    
        // حذف التقييمات المرتبطة
        if (venue.getRatings() != null) {
            ratingRepository.deleteAll(venue.getRatings());
        }
    
        // حذف الربط بالخدمات
        if (venue.getServicees() != null) {
            venue.getServicees().clear();
            venueRepositories.save(venue); // لازم نحفظ التغيير قبل الحذف النهائي
        }
    
        // حذف القاعة
        venueRepositories.delete(venue);
    
        System.out.println("تم حذف القاعة بكل ملحقاتها");
        return true;
    }

    public boolean deleteVenue(Long id) {
        if (venueRepositories.existsById(id)) {
            venueRepositories.deleteById(id);
            return true;
        }
        return false;
    }
    
        
}
