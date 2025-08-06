# Alarmo - Smart Sunset Alarm App
A modern, location-based alarm application built with Flutter that syncs your alarms based on your geographic location.
## ✨ Features
## 🌅 Location-Based Alarms

Real-time Location Detection: Uses GPS coordinates with the geolocator package to detect your current position
Address Resolution: Converts GPS coordinates to human-readable addresses using the geocoding package
Smart Permission Handling: Gracefully handles location permissions with fallback options
Location Display: Shows your current location in a clean, readable format on the home screen
Automatic location detection with manual override option
Real-time location updates for accurate sunset calculations

## 🕐 Modern Alarm Management

Intuitive alarm creation with date and time pickers
Toggle alarms on/off with visual switches
Delete unwanted alarms with a simple tap
Chronological sorting of alarms
Real-time alarm state management with reactive UI

## 🎨 Beautiful UI/UX

Dark theme with modern Material Design
Smooth onboarding experience with engaging animations
Real-time clock display in the header
Responsive design for all screen sizes
Custom buttons and interactive elements
Loading states and error handling with user-friendly messages

## 📱 Smart Features

Real-time date and time formatting
High contrast date/time pickers for accessibility
Smooth page transitions and animations
Location-based error handling with informative messages

## 🔧 Technical Implementation
Location Services
The app implements a robust location system using:

GPS Coordinates: Geolocator.getCurrentPosition() to fetch precise latitude/longitude
Address Conversion: placemarkFromCoordinates() to convert coordinates into readable addresses
Error Handling: Comprehensive error handling for location services disabled, permissions denied, or network issues
Loading States: Visual feedback during location fetching with circular progress indicators

API Architecture
dart// Real-time location fetching
static Future<String> fetchLocation() async {
  Position position = await Geolocator.getCurrentPosition();
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude, 
    position.longitude
  );
  // Format and return human-readable address
}
## 📁 Folder Structure
lib/
├── common_widgets/
│   └── custom_button.dart          # Reusable button components
├── constants/
│   └── app_constants.dart          # App-wide constants
├── features/
│   ├── home/
│   │   ├── home_page.dart          # Main dashboard with alarms
│   │   └── home_view_model.dart    # Alarm state management
│   ├── location/
│   │   └── location_page.dart      # Location permission & detection
│   └── onboarding/
│       └── onboarding_page.dart    # App introduction screens
├── helpers/
│   └── date_formatter.dart         # Date/time formatting utilities
├── services/
│   └── api_service.dart           # Location API service
└── main.dart                      # App entry point
## 🚀 Getting Started
Prerequisites

Flutter SDK (latest stable version)
Android Studio / VS Code
Android device or emulator with location services

Dependencies
yamldependencies:
  flutter:
    sdk: flutter
  geolocator: ^10.1.0      # GPS location services
  geocoding: ^3.0.0        # Address resolution
  permission_handler: ^11.3.1  # Permission management
Installation

Clone the repository
Run flutter pub get to install dependencies
Add location permissions to your platform files:

Android (android/app/src/main/AndroidManifest.xml):
xml<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
iOS (ios/Runner/Info.plist):
xml<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to set location-based alarms.</string>

Run flutter run to launch the app

## 📱 User Flow
Onboarding Experience

Page 1: Sync with Nature's Rhythm - Experience peaceful morning transitions

Page 2: Effortless & Automatic - Smart sunset time calculations

Page 3: Relax & Unwind - Pursue your dreams with confidence

Location Setup

Permission Request: App requests location permissions gracefully
GPS Detection: Real-time coordinate fetching with loading indicator
Address Display: Shows formatted address (street, city, country)
Error Handling: Clear error messages for various failure scenarios

## Main Features

Location Display: Current location shown prominently on home screen
Alarm Management: Create, toggle, and delete alarms with modern UI
Time Pickers: Dark-themed, accessible date and time selection
Real-time Updates: Live clock and reactive alarm states

## 🔧 Key Features Implementation
Location Detection Flow

User taps "Use Current Location"
App shows loading spinner
Request and handle location permissions
Fetch GPS coordinates using Geolocator
Convert coordinates to address using Geocoding
Navigate to home page with location data
Display location in home screen interface

## Error Handling

Location Services Disabled: Clear message with guidance
Permissions Denied: Helpful error with fallback options
Network Issues: Graceful degradation with error notifications
GPS Timeout: Appropriate timeout handling with user feedback

## 🎨 Design Philosophy
The app follows modern Material Design principles with:

Dark Theme: Easy on the eyes for early morning use
High Contrast: Excellent readability in all lighting conditions
Smooth Animations: Delightful micro-interactions throughout
Responsive Layout: Works seamlessly across different screen sizes
Accessibility First: High contrast pickers and clear visual hierarchy


Built with ❤️ using Flutter
