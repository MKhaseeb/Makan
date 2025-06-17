package com.makan.project.controllers;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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

    // صفحة إنشاء القاعة
    @GetMapping("/venue")
    public String createVenue(@ModelAttribute("newVenue") Venue venue, HttpSession session, Model model) {
        return "createVenue.jsp";
    }

    // معالجة حفظ القاعة الجديدة مع الصورة
    @PostMapping("/venue/new")
    public String newVenue(@Valid @ModelAttribute("newVenue") Venue venue,
                           BindingResult result,
                           @RequestParam("file") MultipartFile file,
                           HttpSession session,
                           Model model) {
        if (result.hasErrors()) {
            return "createVenue.jsp";
        }

        try {
            if (!file.isEmpty()) {
                String fileName = file.getOriginalFilename();
                String uploadDir = "src/main/resources/static/uploads/";
                Path filePath = Paths.get(uploadDir + fileName);
                Files.write(filePath, file.getBytes());
                venue.setImageUrl("/uploads/" + fileName);
            } else {
                result.rejectValue("imageUrl", "error.venue", "يجب رفع صورة للقاعه");
                return "createVenue.jsp";
            }
        } catch (IOException e) {
            result.rejectValue("imageUrl", "error.venue", "فشل رفع الصورة");
            return "createVenue.jsp";
        }

        venueService.addVenue(venue);
        return "redirect:/homes";
    }


    // صفحة من نحن
    @GetMapping("/about")
    public String aboutPage() {
        return "Aboutus.jsp";
    }

    // صفحة الشروط
    @GetMapping("/terms")
    public String index() {
        return "terms.jsp";
    }

    // صفحة اتصل بنا
    @GetMapping("/contactus")
    public String contact() {
        return "contact.jsp";
    }

    // الصفحة الرئيسية بعد تسجيل الدخول
    @GetMapping("/homes")
    public String home(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }

        List<Venue> venues = venueService.allVenue();
        model.addAttribute("venues", venues);
        return "Home.jsp";
    }

    // الصفحة الرئيسية العامة
    @GetMapping("/")
    public String main() {
        return "index.jsp";
    }

    // تسجيل الخروج
    @PostMapping("/venue/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    
    
}
