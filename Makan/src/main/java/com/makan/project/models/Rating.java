package com.makan.project.models;



import jakarta.persistence.*; // or use javax.persistence.* depending on your setup

@Entity
@Table(name = "ratings")
public class Rating {
	

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "venue_id")
    private int venueId;

    @Column(name = "user_name")
    private String userName;

    private int score;

    private String comment;

    // Constructors
    public Rating() {}

    public Rating(int id, int venueId, String userName, int score, String comment) {
        this.id = id;
        this.venueId = venueId;
        this.userName = userName;
        this.score = score;
        this.comment = comment;
    }

    // Getters & Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVenueId() {
        return venueId;
    }

    public void setVenueId(int venueId) {
        this.venueId = venueId;
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
                ", venueId=" + venueId +
                ", userName='" + userName + '\'' +
                ", score=" + score +
                ", comment='" + comment + '\'' +
                '}';
    }
}
