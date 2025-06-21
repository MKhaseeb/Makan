package com.makan.project.controllers;

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
	@GetMapping("/login")
	public String index(Model model) {
	    model.addAttribute("newUser", new User());
	    model.addAttribute("newLogin", new LoginUser());
	        return "login.jsp";
	    }
	    
//	@PostMapping("/register")
//	public String register(@Valid @ModelAttribute("newUser") User newUser, 
//	        BindingResult result, Model model, HttpSession session) {
//	    
//	    //  تعيين الدور
//	    newUser.setRole("user"); // أو "owner" أو "admin" لاحقًا حسب المستخدم
//	    User reg = logRegService.register(newUser, result);
//
//	    if(result.hasErrors()) {
//	        model.addAttribute("newLogin", new LoginUser());
//	        return "login.jsp";
//	    }
//
//	    session.setAttribute("userId", reg.getId());
//	    session.setAttribute("userRole", reg.getRole());    
//
//	    return "redirect:/homes";
//	}
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, 
	        BindingResult result, Model model, HttpSession session) {

	    if(result.hasErrors()) {
	        model.addAttribute("newLogin", new LoginUser());
	        return "login.jsp";
	    }

	    User reg = logRegService.register(newUser, result);

	    // تحقق من فشل التسجيل (بسبب خطأ داخل service)
	    if (reg == null || result.hasErrors()) {
	        model.addAttribute("newLogin", new LoginUser());
	        model.addAttribute("registerError", "حدث خطأ أثناء التسجيل. تأكد من صحة البيانات.");
	        return "login.jsp";
	    }

	    session.setAttribute("userId", reg.getId());
	    session.setAttribute("userRole", reg.getRole());
	    session.setAttribute("user", reg); 

	    switch (reg.getRole()) {
	        case "admin":
	            return "redirect:/homes";
	        case "owner":
	            return "redirect:/owner/dashboard";
	        case "user":
	        default:
	            return "redirect:/user/home";
	    }
	}



	@PostMapping("/loginUser")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, 
	        BindingResult result, Model model, HttpSession session) {
	    
	    User user = logRegService.login(newLogin, result);

	    if(result.hasErrors()) {
	        model.addAttribute("newUser", new User());
	        return "login.jsp";
	    }

	    session.setAttribute("userName", user.getFirstname());
	    session.setAttribute("userId", user.getId());
	    session.setAttribute("userRole", user.getRole()); //  تخزين الدور في الجلسة
	    session.setAttribute("user", user);
	    
	    switch (user.getRole()) {
        case "admin":
    	    return "redirect:/homes";  // صفحة المشرف
        case "owner":
            return "redirect:/owner/dashboard";       // صفحة مالك القاعة
        case "user":
        default:
            return "redirect:/user/home";        // صفحة المستخدم العادي
    }
	}

	    
	    @GetMapping("/home")
	    public String success(HttpSession session,Model model) {
	        Long userId = (Long) session.getAttribute("userId");
	        
	        if (userId == null) {
	            return "redirect:/homes";
	            }
	        User loguser = logRegService.findUserById(userId);
	        model.addAttribute("user", loguser);
	    	return"login.jsp";
	    }
	    
	    @GetMapping("/logout")
	    public String logout(HttpSession session) {
	        session.invalidate();
	        return "redirect:/";  
	    }

}
