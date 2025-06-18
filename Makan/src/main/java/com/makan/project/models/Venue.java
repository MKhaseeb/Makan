package com.makan.project.models;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "venues")
public class Venue {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private String name;
    @NotNull
    @Size(min = 2, max = 50, message = "city must be between 2 and 50 characters")
    private String city;
    @NotNull
    @Min(value = 1, message = "Price per day must be at least 1")
    private double pricePerDay;
    @NotNull
    @Min(value = 1, message = "Capacity must be at least 1")
    private int capacity;
    
    @Column(nullable = false)
    private String imageUrl;
    @NotNull
    @Size(min = 2, max = 500, message = "Description must be between 2 and 500 characters")
    private String description;

    @Column(updatable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createdAt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updatedAt;


    public List<Servicee> getServicees() {
        return servicees;
    }
    public void setServicees(List<Servicee> servicees) {
        this.servicees = servicees;
    }
    public List<Rating> getRatings() {
        return ratings;
    }
    public void setRatings(List<Rating> ratings) {
        this.ratings = ratings;
    }
    @OneToMany(mappedBy = "venue")
    private List<Booking> bookings;

    @ManyToMany
    @JoinTable(
        name = "venue_servicees",
        joinColumns = @JoinColumn(name = "venue_id"),
        inverseJoinColumns = @JoinColumn(name = "servicee_id")
    )
    private List<Servicee> servicees;

    @OneToMany(mappedBy = "venue", cascade = CascadeType.ALL)
    private List<Rating> ratings;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "owner_id")
    private User owner;


    public Venue() {
    }
    public Venue(String name, String city, double pricePerDay, int capacity, String imageUrl, String description) {
        this.name = name;
        this.city = city;
        this.pricePerDay = pricePerDay;
        this.capacity = capacity;
        this.imageUrl = imageUrl;
        this.description = description;
    }

    public Date getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    public Date getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    public List<Booking> getBookings() {
        return bookings;
    }
    public void setBookings(List<Booking> bookings) {
        this.bookings = bookings;
    }
    public List<Servicee> getServices() {
        return servicees;
    }
    public void setServices(List<Servicee> services) {
        this.servicees = services;
    }
    @PrePersist
    protected void onCreate() {
        this.createdAt = new Date();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = new Date();
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }
    public double getPricePerDay() {
        return pricePerDay;
    }
    public void setPricePerDay(double pricePerDay) {
        this.pricePerDay = pricePerDay;
    }
    public int getCapacity() {
        return capacity;
    }
    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }
    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    

}
