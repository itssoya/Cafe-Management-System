package com.beanbrew.util;

import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

public class FileUploadUtil {
	
	private static final List<String> allowedFileType = List.of( "image/jpeg", "image/png", "image/webp");

    /**
     * Extracts the extension from a filename (e.g., "photo.jpg" -> ".jpg")
     */
    public static String getFileExtension(String fileName) {
        if (fileName == null || !fileName.contains(".")) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf("."));
    }
    

    /**
     * Validates if the uploaded part is actually an image based on MIME type
     */
    public static boolean isImage(Part part) {
        String contentType = part.getContentType(); // e.g., "image/jpeg"
        return contentType != null && contentType.startsWith("image/");
    }
    
    public static boolean isValidType (Part part) {
        String contentType = part.getContentType(); // e.g., "image/jpeg"
        if (contentType != null && !allowedFileType.contains(contentType.toLowerCase())) {
        	
        	throw new TypeMismatchException("Supported file format: JPEG, WEB, PNG");
        	
        }
        
        return true;
    }

    /**
     * Builds the final filename: uniqueID + extension
     */
    public static String buildFileName(String identifier, String extension) {
        return identifier + extension;
    }

    /**
     * Handles the physical saving of the file to the disk
     */
    public static void saveFile(Part part, String uploadDir, String fileName) throws IOException {
        // 1. Convert String path to Path object
        Path uploadPath = Paths.get(uploadDir);

        // 2. Requirement: Create directory if it doesn't exist
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // 3. Resolve the full path (root_path + filename)
        Path filePath = uploadPath.resolve(fileName);

        // 4. Save the file (Overwrite if it already exists)
        try (InputStream inputStream = part.getInputStream()) {
            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
        }
    }
}