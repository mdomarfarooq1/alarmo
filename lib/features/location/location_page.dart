import 'package:flutter/material.dart';
import 'package:alarmo/common_widgets/custom_button.dart';
import 'package:alarmo/networks/api_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      // Black background to match design
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          // Horizontal padding for content spacing
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            // Align content to start (left alignment)
            crossAxisAlignment: CrossAxisAlignment.start,
            // Center content vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main welcome title - left aligned and bigger
              const Text(
                'Welcome! Your\nPersonalized Alarm',
                style: TextStyle(
                  fontSize: 32, // Larger title font size
                  fontWeight: FontWeight.bold, // Bold text
                  color: Colors.white, // White text color
                  height: 1.3, // Line height for better spacing
                ),
                textAlign: TextAlign.left, // Left align text
              ),
              const SizedBox(height: 16), // Space between title and description
              // Description text - left aligned
              const Text(
                'Allow us to sync your sunset alarm\nbased on your location.',
                style: TextStyle(
                  fontSize: 16, // Medium font size
                  color: Colors.white70, // Semi-transparent white
                  height: 1.4, // Line height for readability
                ),
                textAlign: TextAlign.left, // Left align text
              ),
              
              // Space between text and image
              SizedBox(height: screenHeight * 0.06), // 6% of screen height
              
              // Center the image container
              Center(
                child: Container(
                  width: screenWidth * 0.8, // 80% of screen width (bigger)
                  height: screenWidth * 0.8, // Square aspect ratio (bigger)
                  child: Image.asset(
                    'images/pic4.png', // Mountain sunset PNG image
                    fit: BoxFit.contain, // Maintain aspect ratio and show full image
                    width: double.infinity, // Take full container width
                    height: double.infinity, // Take full container height
                  ),
                ),
              ),
              
              // Space between image and buttons
              SizedBox(height: screenHeight * 0.06), // 6% of screen height
              
              // Primary location button with location icon - gray style
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : CustomButton.gray(
                      text: 'Use Current Location', // Button text
                      icon: Icons.location_on, // Location icon
                      onPressed: _fetchLocationAndNavigate,
                    ),
              
              const SizedBox(height: 16), // Space between buttons
              
              // Secondary "Home" button - gray style
              if (!_isLoading)
                CustomButton.gray(
                  text: 'Home', // Button text
                  onPressed: () {
                    // Navigate to home without setting location
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Fetch location and navigate to home page
  Future<void> _fetchLocationAndNavigate() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch current location using ApiService
      String location = await ApiService.fetchLocation();
      
      // Navigate to home page with the fetched location
      if (mounted) {
        Navigator.pushReplacementNamed(
          context, 
          '/home',
          arguments: location, // Pass location as argument
        );
      }
    } catch (e) {
      // Show error message to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error fetching location: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}