package com.makan.project.controllers;

import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.makan.project.models.LoginUser;
import com.makan.project.models.User;
import com.makan.project.services.LogRegService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class LoginController {
	
	
	 @Autowired
	 LogRegService logRegService;
	 
	    @GetMapping("/")
	    public String index(Model model) {
	        model.addAttribute("newUser", new User());
	        model.addAttribute("newLogin", new LoginUser());
	        return "index.jsp";
	    }
	    
	    @PostMapping("/register")
	    public String register(@Valid @ModelAttribute("newUser") User newUser, 
	            BindingResult result, Model model, HttpSession session) {;
	        User reg = logRegService.register(newUser, result);
	        
	        if(result.hasErrors()) {
	            model.addAttribute("newLogin", new LoginUser());
	            return "index.jsp";
	        }
	        
	        session.setAttribute("userId", reg.getId());
	    
	        return "redirect:/";
	    }
	    
	    @PostMapping("/login")
	    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, 
	            BindingResult result, Model model, HttpSession session) {
	        
	         User user = logRegService.login(newLogin, result);
	    
	        if(result.hasErrors()) {
	            model.addAttribute("newUser", new User());
	            return "index.jsp";
	        }
	    
	        session.setAttribute("userName", user.getFirstname());
	        session.setAttribute("userId", user.getId());

	    
	        return "redirect:/home";
	    }
	    
	    @GetMapping("/home")
	    public String success(HttpSession session,Model model) {
	        Long userId = (Long) session.getAttribute("userId");
	        
	        if (userId == null) {
	            return "redirect:/";
	            }
	        User loguser = logRegService.findUserById(userId);
	        model.addAttribute("user", loguser);
	    	return"home.jsp";
	    }
	    
	    @GetMapping("/logout")
	    public String logout(HttpSession session) {
	        session.invalidate();
	        return "redirect:/";  
	    }

}
