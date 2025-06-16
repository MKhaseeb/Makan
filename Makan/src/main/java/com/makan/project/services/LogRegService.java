package com.makan.project.services;

import java.util.Optional;


import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.makan.project.models.LoginUser;
import com.makan.project.models.User;

import com.makan.project.repositories.LogRegRepository;

@Service
public class LogRegService {

	@Autowired
	LogRegRepository logRegRepository;
		
    public User register(User newUser, BindingResult result) {        
    	Optional<User> potentialUser = logRegRepository.findByEmail(newUser.getEmail());
    		if (potentialUser.isPresent())
    			 result.rejectValue("email", "taken", "The Email is already taken");
    	if(!newUser.getPassword().equals(newUser.getConfirm())) {
    	    result.rejectValue("confirm", "Matches", "The Confirm Password must match Password!");
    	}
    	if(result.hasErrors()) {
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
		if(!BCrypt.checkpw(newLoginObject.getPassword(), user.getPassword())) {
		    result.rejectValue("password", "Matches", "Invalid Password!");
		}

    	if(result.hasErrors()) {
    	    return null;
    	}
    	return user;
}
	public User findUserById(Long id) {
	    Optional<User> user = logRegRepository.findById(id);
	    return user.orElse(null);
	}

}
