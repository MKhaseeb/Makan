package com.makan.project.controllers;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.makan.project.models.Booking;

import com.makan.project.models.User;

import com.makan.project.models.Venue;
import com.makan.project.services.BookingService;
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
    
    @Autowired
     BookingService bookingService;

    // صفحة إنشاء القاعة
    @GetMapping("/venue")
    public String createVenue(@ModelAttribute("newVenue") Venue venue, HttpSession session, Model model) {
        return "createVenue.jsp";
    }

    // معالجة حفظ القاعة الجديدة مع الصورة
    @PostMapping("/venue/new")
    public String newVenue(@Valid @ModelAttribute("newVenue") Venue venue,
                           BindingResult result,
                           @RequestParam("files") MultipartFile[] files,
                           HttpSession session,
                           Model model) {
        if (result.hasErrors()) {
            return "createVenue.jsp";
        }

        List<String> imageUrls = new ArrayList<>();

        try {
            String uploadDir = "src/main/resources/static/uploads/";

            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                    Path filePath = Paths.get(uploadDir + fileName);
                    Files.write(filePath, file.getBytes());
                    imageUrls.add("/uploads/" + fileName);
                }
            }

            if (imageUrls.isEmpty()) {
                result.rejectValue("imageUrl", "error.venue", "يجب رفع صورة واحدة على الأقل");
                return "createVenue.jsp";
            }

            // Join URLs into one string or adjust logic if you add List<String> imageUrls to Venue model
            venue.setImageUrl(imageUrls.get(0)); // Just set the first image for now

        } catch (IOException e) {
            result.rejectValue("imageUrl", "error.venue", "فشل رفع الصور");
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
    
    @GetMapping("/halls/{id}")
    public String VenueDetails(@PathVariable Long id, Model model) {
        Venue venue = venueService.getVenueById(id); 
        List<LocalDate> bookedDates = bookingService.getBookedDatesForVenue(id); 

        model.addAttribute("venue", venue);
        model.addAttribute("bookedDates", bookedDates);

        return "hallDetails.jsp";
    }

    
    @GetMapping("/book")
    public String showBookingForm(
        @RequestParam(value="venueId", required=false) Long venueId,
        @ModelAttribute("newBooking") Booking booking,
        HttpSession session, Model model) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return "redirect:/";

        if (venueId != null) {
            Venue venue = venueService.getVenueById(venueId);
            booking.setVenue(venue);  // Set the selected venue
            model.addAttribute("selectedVenue", venue);
            
            List<LocalDate> bookedDates = bookingService.getBookedDatesForVenue(venueId);
            model.addAttribute("bookedDates", bookedDates);
        }else {
        	model.addAttribute("bookedDates", new ArrayList<LocalDate>());
        }

        
        model.addAttribute("venues", venueService.allVenue());
        model.addAttribute("user", logRegService.findUserById(userId));
        return "bookVenue.jsp";
    }

    
    @PostMapping("/book")
    public String saveBooking(
        @Valid @ModelAttribute("newBooking") Booking booking,
        BindingResult result,
        HttpSession session,
        Model model,
        @RequestParam("venueId") Long venueId) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }

        // If there are validation errors, re-render the form
        if (result.hasErrors()) {
            model.addAttribute("venues", venueService.allVenue());
            model.addAttribute("user", logRegService.findUserById(userId));
            model.addAttribute("selectedVenue", booking.getVenue()); // re-show selected venue
            return "bookVenue.jsp";
        }

        // Set user and venue (in case venue only came via hidden input)
        booking.setUser(logRegService.findUserById(userId));
        booking.setVenue(venueService.getVenueById(venueId));

        // Save the booking
        bookingService.addBooking(booking);

        // Redirect to confirmation or homepage
        return "redirect:/homes";
        
    }

    
  



    @GetMapping("/owner/dashboard")
    public String ownerDashboard(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }

        // استدعاء القاعات التي يملكها هذا المستخدم
        List<Venue> myVenues = venueService.findVenuesByOwnerId(userId);
        model.addAttribute("myVenues", myVenues);

        // استدعاء الحجوزات المرتبطة بقاعات هذا المستخدم
        List<Booking> bookings = venueService.findBookingsByOwnerId(userId);
        model.addAttribute("myBookings", bookings);

        return "ownerDashboard.jsp";
    }

    
    @GetMapping("user/home")
    public String homeuser(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/";
        }

        List<Venue> venues = venueService.allVenue();
        model.addAttribute("venues", venues);
        return "Homeuser.jsp";
    }

    @GetMapping("/admin/owners")
    public String showAdminPage(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("owners", logRegService.findUsersByRole("owner"));
        model.addAttribute("admins", logRegService.findUsersByRole("admin"));
        return "adminManage.jsp";
    }

    @PostMapping("/admin/owners")
    public String processAddUser(@Valid @ModelAttribute("newUser") User newUser,
                                 BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("owners", logRegService.findUsersByRole("owner"));
            model.addAttribute("admins", logRegService.findUsersByRole("admin"));
            return "adminManage.jsp";
        }
        logRegService.register(newUser, result);
        return "redirect:/admin/owners";
    }

    @PostMapping("/admin/delete/{id}")
    @ResponseBody
    public String deleteUser(@PathVariable("id") Long id) {
        try {
            logRegService.deleteUserById(id);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }







    

    
}
