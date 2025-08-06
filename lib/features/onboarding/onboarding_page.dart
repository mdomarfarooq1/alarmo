import 'package:flutter/material.dart';
import 'package:alarmo/constants/app_constants.dart';
import 'package:alarmo/common_widgets/custom_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // Controller to manage page transitions
  final PageController _pageController = PageController();
  // Track current page index
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // Set black background to match design
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main PageView for swiping between onboarding screens
          PageView(
            controller: _pageController,
            // Update current page when user swipes
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            // Generate 3 onboarding pages
            children: List.generate(3, (index) => _buildPageContent(index, screenHeight, screenWidth)),
          ),
          // Skip button positioned at top right
          Positioned(
            top: 50, // Distance from top of screen
            right: 20, // Distance from right edge
            child: TextButton(
              // Navigate to location page when skip is pressed
              onPressed: () => Navigator.pushReplacementNamed(context, '/location'),
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white70, // Semi-transparent white
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Bottom content area with text and controls
          Positioned(
            bottom: 0, // Stick to bottom of screen
            left: 0, // Full width
            right: 0,
            child: Container(
              height: screenHeight * 0.35, // 35% of screen height
              // Padding for content spacing
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Colors.black, // Black background
              ),
              child: Column(
                // Align text to start (left)
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main title text
                  Text(
                    AppConstants.onboardingTitles[_currentPage], // Dynamic title based on current page
                    style: const TextStyle(
                      fontSize: 28, // Large title size
                      fontWeight: FontWeight.bold, // Bold text
                      color: Colors.white, // White text color
                      height: 1.2, // Line height for better spacing
                    ),
                    textAlign: TextAlign.left, // Left align text
                  ),
                  const SizedBox(height: 12), // Space between title and description
                  // Description text
                  Text(
                    AppConstants.onboardingDescriptions[_currentPage], // Dynamic description
                    style: const TextStyle(
                      fontSize: 16, // Medium text size
                      color: Colors.white70, // Semi-transparent white
                      height: 1.4, // Line height for readability
                    ),
                    textAlign: TextAlign.left, // Left align text
                  ),
                  const Spacer(), // Push bottom controls to bottom
                  // Page indicators centered above button
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the indicators
                      children: List.generate(3, (index) => _buildIndicator(index)), // Generate 3 indicator dots
                    ),
                  ),
                  const SizedBox(height: 24), // Space between indicators and button
                  // Next/Get Started button centered and wider
                  Center(
                    child: CustomButton(
                      text: _currentPage == 2 ? 'Get Started' : 'Next', // Dynamic button text
                      onPressed: () {
                        // If not on last page, go to next page
                        if (_currentPage < 2) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300), // Animation duration
                            curve: Curves.easeIn, // Animation curve
                          );
                        } else {
                          // On last page, navigate to location screen
                          Navigator.pushReplacementNamed(context, '/location');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build content for each onboarding page
  Widget _buildPageContent(int index, double screenHeight, double screenWidth) {
    return Column(
      children: [
        // Image container with curved bottom edges
        Container(
          height: screenHeight * 0.65, // 65% of screen height for image
          width: screenWidth, // Full screen width
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30), // Curved bottom left corner
              bottomRight: Radius.circular(30), // Curved bottom right corner
            ),
          ),
          child: ClipRRect(
            // Clip image to match container's rounded corners
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Image.asset(
              'images/pic${index + 1}.gif', // Dynamic image path
              // Use fitWidth for pic2.gif (index 1), cover for others
              fit: index == 1 ? BoxFit.fitWidth : BoxFit.cover,
              width: double.infinity, // Take full available width
              height: double.infinity, // Take full available height
            ),
          ),
        ),
      ],
    );
  }

  // Build individual page indicator dot
  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Animation duration for indicator changes
      height: 8, // Fixed height for all indicators
      // Width changes based on active state - active indicator is wider
      width: _currentPage == index ? 24 : 8,
      margin: const EdgeInsets.symmetric(horizontal: 4), // Space between indicators
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4), // Rounded indicator shape
        // Color changes based on active state
        color: _currentPage == index 
            ? const Color(0xFF6366F1) // Purple for active indicator
            : Colors.white30, // Semi-transparent white for inactive
      ),
    );
  }
}