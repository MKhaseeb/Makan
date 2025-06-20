package com.makan.project.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

import com.makan.project.models.User;
import com.makan.project.repositories.UserRepository;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;

    public void addUser(User user) {
        userRepository.save(user);
    }

    public User getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    public boolean deleteUserById(Long id) {
        Optional<User> optionalUser = userRepository.findById(id);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            if ("admin".equalsIgnoreCase(user.getRole()) || "owner".equalsIgnoreCase(user.getRole())) {
                userRepository.deleteById(id);
                return true;
            }
        }
        return false;
    }
}
