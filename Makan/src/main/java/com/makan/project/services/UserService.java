package com.makan.project.services;

import org.springframework.stereotype.Service;

import com.makan.project.models.User;
import com.makan.project.repositories.UserRepositories;

@Service
public class UserService {
    private final UserRepositories userRepositories;

    public UserService(UserRepositories userRepositories) {
        this.userRepositories = userRepositories;
    }

    public void addUser(User user) {
        userRepositories.save(user);
    }
    public User getUserById(Long id) {
        return userRepositories.findById(id).orElse(null);
    }
}
