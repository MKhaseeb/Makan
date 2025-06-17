package com.makan.project.models;



import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.*; // or use javax.persistence.* depending on your setup
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

@Entity
@Table(name = "ratings")
public class Rating {
	

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_name")
    private String userName;

    @Column(nullable = false)
    @Min(1)
    @Max(5)
    private int score;

    private String comment;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "venue_id", nullable =  false)
    private Venue venue;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Venue getVenue() {
        return venue;
    }

    public void setVenue(Venue venue) {
        this.venue = venue;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    @ManyToOne
    @JoinColumn(name = "booking_id", nullable = false)
    private Booking booking;
    // Constructors
    public Rating() {}

    public Rating(Long id, int venueId, String userName, int score, String comment) {
        this.id = id;
        this.userName = userName;
        this.score = score;
        this.comment = comment;
    }

    // Getters & Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Override
    public String toString() {
        return "Rating{" +
                "id=" + id +
                ", userName='" + userName + '\'' +
                ", score=" + score +
                ", comment='" + comment + '\'' +
                '}';
    }
}
