package com.makan.project.controllers;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.makan.project.models.Booking;
import com.makan.project.models.ChatMessage;
import com.makan.project.models.User;

import com.makan.project.models.Venue;
import com.makan.project.repositories.BookingRepository;
import com.makan.project.repositories.ChatMessageRepository;
import com.makan.project.repositories.VenueRepository;
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
    VenueRepository venueRepository;
    
    @Autowired
    BookingRepository bookingRepository;

    @Autowired
    LogRegService logRegService;
    
    @Autowired
     BookingService bookingService;
    
    @Autowired
    ChatMessageRepository chatMessageRepository;

    // صفحة إنشاء القاعة
    @GetMapping("/venue")
    public String createVenue(@ModelAttribute("newVenue") Venue venue, HttpSession session, Model model) {
    	  model.addAttribute("owners", logRegService.findUnassignedOwners());
    	  
        return "createVenue.jsp";
    }

    // معالجة حفظ القاعة الجديدة مع الصورة
    @PostMapping("/venue/new")
    public String newVenue(@Valid @ModelAttribute("newVenue") Venue venue,
                           BindingResult result,
                           @RequestParam("files") MultipartFile[] files,
                           @RequestParam("latitude") Double latitude,
                           @RequestParam("longitude") Double longitude,
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

            venue.setImageUrl(imageUrls);

        } catch (IOException e) {
            result.rejectValue("imageUrl", "error.venue", "فشل رفع الصور");
            return "createVenue.jsp";
        }

        // 🟢 تخزين الإحداثيات
        venue.setLatitude(latitude);
        venue.setLongitude(longitude);

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
    @GetMapping("/halls")
    public String showAllVenues(Model model) {
        List<Venue> allVenues = venueService.getAllVenues(); // ميثود بسيطة ترجع كل القاعات
        model.addAttribute("venues", allVenues);
        return "Homeuser.jsp";
    }
    
    @GetMapping("/halls/view/{id}")
    public String VenueDetails(@PathVariable Long id, Model model) {
        Venue venue = venueService.getVenueById(id); 
        List<LocalDate> bookedDates = bookingService.getBookedDatesForVenue(id); 

        model.addAttribute("venue", venue);
        model.addAttribute("bookedDates", bookedDates);

        return "hallDetails.jsp";
    }

    @GetMapping("/halls/filter")
    public String filterVenues(
        @RequestParam(required = false) String city,
        @RequestParam(required = false) String village,
        @RequestParam(required = false) Integer maxPrice,
        @RequestParam(required = false) Integer minCapacity,
        Model model
    ) {
        List<Venue> filteredVenues = venueService.filterVenues(city, village, maxPrice, minCapacity);
        model.addAttribute("venues", filteredVenues);
        return "Homeuser.jsp"; // أو أي اسم صفحة نتائج البحث عندك
    }

    
    @GetMapping("/book")
    public String showBookingForm(
        @RequestParam(value="venueId", required=false) Long venueId,
        @RequestParam(value="success", required=false) Boolean success,
        @ModelAttribute("newBooking") Booking booking,
        HttpSession session, Model model) {
    
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return "redirect:/";
    
        if (venueId != null) {
            Venue venue = venueService.getVenueById(venueId);
            booking.setVenue(venue);
            model.addAttribute("selectedVenue", venue);
            
            List<LocalDate> bookedDates = bookingService.getBookedDatesForVenue(venueId);
            model.addAttribute("bookedDates", bookedDates);
        } else {
            model.addAttribute("bookedDates", new ArrayList<LocalDate>());
        }
    
        model.addAttribute("venues", venueService.allVenue());
        model.addAttribute("user", logRegService.findUserById(userId));
        model.addAttribute("success", success);
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
		return "redirect:/book?success=true";
        
    }

    
  



    @GetMapping("/owner/dashboard")
    public String ownerDashboard(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        User owner = (User) session.getAttribute("user");

        if (userId == null || owner == null || !owner.getRole().equals("owner")) {
            return "redirect:/login";
        }

        // القاعات المملوكة
        List<Venue> ownedVenues = venueRepository.findByOwner(owner);
        model.addAttribute("venues", ownedVenues);

        // الحجوزات على هذه القاعات
        List<Booking> ownerBookings = bookingRepository.findByVenueIn(ownedVenues);
        model.addAttribute("bookings", ownerBookings);

        // تحميل ملخصات الدردشة (آخر رسالة لكل محادثة)
        List<ChatMessage> chats = chatMessageRepository.findChatsByOwnerId(owner.getId());
        // قم بتحويلها إلى ملخصات مناسبة للعرض (يمكنك عمل DTO أو Map)
        List<Map<String, Object>> chatSummaries = new ArrayList<>();

        for (ChatMessage chat : chats) {
            Map<String, Object> summary = new HashMap<>();
            summary.put("chatId", chat.getChatId());
            summary.put("senderName", chat.getSenderName()); // تأكد من تعبئة هذا الحقل
            summary.put("lastMessage", chat.getContent());
            summary.put("lastTimestamp", chat.getTimestamp());
            chatSummaries.add(summary);
        }

        model.addAttribute("chatSummaries", chatSummaries);

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


    
    @PostMapping("/admin/deleteVenue/{id}")
    @ResponseBody
    public ResponseEntity<String> deleteVenue(@PathVariable Long id) {
        try {
            venueService.deleteVenue(id);
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
        }
    }
    


    @PostMapping("/halls/delete")
    public ResponseEntity<Map<String, Object>> deleteVenue(@RequestParam Long id) {
        Map<String, Object> response = new HashMap<>();
        boolean deleted = venueService.deleteVenue(id);
        response.put("success", deleted);
        return ResponseEntity.ok(response);
    
}
    }




    @PostMapping("/updateDetails")
    public ResponseEntity<Map<String, Object>> updateDetails(@RequestBody Map<String, Object> payload) {
        Map<String, Object> response = new HashMap<>();
        try {
            Long id = ((Number) payload.get("id")).longValue();
            String newName = (String) payload.get("name");
            String newDesc = (String) payload.get("description");
            String newFullAddress = (String) payload.get("fullAddress");

            Optional<Venue> venueOpt = venueRepository.findById(id);
            if (venueOpt.isPresent()) {
                Venue venue = venueOpt.get();

                // Check ownership if needed, to secure endpoint (not shown here)

                venue.setName(newName);
                venue.setDescription(newDesc);
                venue.setFullAddress(newFullAddress);

                venueRepository.save(venue);

                response.put("success", true);
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "Venue not found");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}


