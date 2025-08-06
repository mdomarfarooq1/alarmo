import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text; // Button text to display
  final VoidCallback onPressed; // Function to call when button is pressed
  final double? width; // Optional custom width
  final double? height; // Optional custom height
  final Color? backgroundColor; // Optional custom background color
  final Color? textColor; // Optional custom text color
  final double? fontSize; // Optional custom font size
  final IconData? icon; // Optional icon to display
  final bool isGrayStyle; // Flag for gray button style
  
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.icon,
    this.isGrayStyle = false,
  });

  // Factory constructor for gray style buttons
  const CustomButton.gray({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize,
    this.icon,
  }) : backgroundColor = null,
       textColor = null,
       isGrayStyle = true;

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    
    return SizedBox(
      // Use custom width or default to 80% of screen width for wider button
      width: width ?? screenWidth * 0.8,
      // Use custom height or default to 56 pixels
      height: height ?? 56,
      child: ElevatedButton(
        onPressed: onPressed, // Button press handler
        style: ElevatedButton.styleFrom(
          // Use gray colors for gray style, otherwise use custom or default colors
          backgroundColor: isGrayStyle 
              ? Colors.grey[800] 
              : (backgroundColor ?? const Color(0xFF6366F1)),
          // Use white text for gray style, otherwise use custom or default colors
          foregroundColor: isGrayStyle 
              ? Colors.white 
              : (textColor ?? Colors.white),
          // Rounded corners with 28px radius for pill shape
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          // Remove button shadow
          elevation: 0,
          // Remove default padding to use container sizing
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center content horizontally
          children: [
            // Display icon if provided
            if (icon != null) ...[
              Icon(
                icon,
                size: 20, // Icon size
                color: isGrayStyle ? Colors.white : (textColor ?? Colors.white),
              ),
              const SizedBox(width: 8), // Space between icon and text
            ],
            // Display button text
            Text(
              text,
              style: TextStyle(
                // Use custom font size or default to 18
                fontSize: fontSize ?? 18,
                fontWeight: FontWeight.w600, // Semi-bold text
              ),
            ),
          ],
        ),
      ),
    );
  }
}