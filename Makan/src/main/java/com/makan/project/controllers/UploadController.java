
package com.makan.project.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;
import java.util.UUID;

@RestController
public class UploadController {

    private static final String UPLOAD_DIR = "uploads/";

    @PostMapping("/upload")
    public ResponseEntity<String> uploadImage(@RequestParam("file") MultipartFile files) {
        try {
            Files.createDirectories(Paths.get(UPLOAD_DIR));
            String filename = UUID.randomUUID() + "_" + files.getOriginalFilename();
            Path path = Paths.get(UPLOAD_DIR, filename);
            Files.copy(files.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

            // Return the relative path (to be stored as imageUrl)
            return ResponseEntity.ok("/uploads/" + filename);
        } catch (IOException e) {
            return ResponseEntity.status(500).body("Upload failed");
        }
    }
}