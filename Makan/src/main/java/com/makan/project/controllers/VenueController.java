package com.makan.project.controllers;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.makan.project.models.Venue;
import com.makan.project.services.LogRegService;
import com.makan.project.services.VenueService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class VenueController {
	
	@Autowired
	VenueService venueService;
	@Autowired
	LogRegService logRegService;
	
	
	@GetMapping("/venue")
	public String createVenue(@Valid @ModelAttribute("newVenue") Venue venue, BindingResult result, HttpSession session, Model model) {
		return"createVenue.jsp";
	}
	
	@PostMapping("/venue/new")
	public String newVenue(@Valid @ModelAttribute("newVenue") Venue venue, BindingResult result, HttpSession session, Model model) {
        if (result.hasErrors()) {
            return "createVenue.jsp";
        }
        
        return"redirect:/venue";
	}
	

	
	 @GetMapping("/about")
	    public String aboutPage() {
	        return "Aboutus.jsp";
	    }
	 
	 
	 @GetMapping("/terms")
	 public String index() {
	     return "terms.jsp";
	 }

	 @GetMapping("/contactus")
	 public String contant() {
	     return "contact.jsp";
	 }
	 

	 
	 @GetMapping("/homes")
	 public String Home(HttpSession session) {
	    Long userId = (Long) session.getAttribute("userId");

		 if (userId == null) {
	            return "redirect:/";
	            }
	     return "Home.jsp";
	 }
	 
	 @GetMapping("/")
	 public String main() {
		 return"index.jsp";
	 }
	 
	 

}
