package com.makan.project.services;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.makan.project.models.LoginUser;
import com.makan.project.models.User;
import com.makan.project.repositories.LogRegRepository;
import com.makan.project.repositories.VenueRepository;

@Service
public class LogRegService {

    @Autowired
    private LogRegRepository logRegRepository;
    @Autowired
    private VenueRepository venueRepositories;

    public User register(User newUser, BindingResult result) {        
        Optional<User> potentialUser = logRegRepository.findByEmail(newUser.getEmail());
        if (potentialUser.isPresent())
            result.rejectValue("email", "taken", "The Email is already taken");

        if (!newUser.getPassword().equals(newUser.getConfirm())) {
            result.rejectValue("confirm", "Matches", "The Confirm Password must match Password!");
        }

        if (result.hasErrors()) {
            return null;
        }

        String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
        newUser.setPassword(hashed);

        return logRegRepository.save(newUser);
    }

    public User login(LoginUser newLoginObject, BindingResult result) {
        Optional<User> potentialUser = logRegRepository.findByEmail(newLoginObject.getEmail());

        if (!potentialUser.isPresent()) {
            result.rejectValue("email", "null", "Email is not found");
            return null;
        }

        User user = potentialUser.get();
        if (!BCrypt.checkpw(newLoginObject.getPassword(), user.getPassword())) {
            result.rejectValue("password", "Matches", "Invalid Password!");
        }

        if (result.hasErrors()) {
            return null;
        }

        return user;
    }
    
    public List<User> findUnassignedOwners() {
        List<User> allOwners = logRegRepository.findByRole("owner");
        return allOwners.stream()
            .filter(owner -> venueRepositories.findByOwner(owner).isEmpty()) 
            .collect(Collectors.toList());
    }


    public User findUserById(Long id) {
        Optional<User> user = logRegRepository.findById(id);
        return user.orElse(null);
    }

    public List<User> findUsersByRole(String role) {
        return logRegRepository.findByRole(role);
    }

    public void deleteUserById(Long id) {
        logRegRepository.deleteById(id);
    }
    
    

}
