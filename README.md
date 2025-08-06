# Alarmo - Smart Sunset Alarm App

A modern, location-based alarm application built with Flutter that syncs your alarms based on your geographic location.

## ✨ Features

### 🌅 Location-Based Alarms
- Real-time Location Detection: Uses GPS coordinates with the geolocator package to detect your current position
- Address Resolution: Converts GPS coordinates to human-readable addresses using the geocoding package
- Smart Permission Handling: Gracefully handles location permissions with fallback options
- Location Display: Shows your current location in a clean, readable format on the home screen
- Automatic location detection with manual override option
- Real-time location updates for accurate sunset calculations

### 🕐 Modern Alarm Management
- Intuitive alarm creation with date and time pickers
- Toggle alarms on/off with visual switches
- Delete unwanted alarms with a simple tap
- Chronological sorting of alarms
- Real-time alarm state management with reactive UI

### 🎨 Beautiful UI/UX
- Dark theme with modern Material Design
- Smooth onboarding experience with engaging animations
- Real-time clock display in the header
- Responsive design for all screen sizes
- Custom buttons and interactive elements
- Loading states and error handling with user-friendly messages

### 📱 Smart Features
- Real-time date and time formatting
- High contrast date/time pickers for accessibility
- Smooth page transitions and animations
- Location-based error handling with informative messages

## 🔧 Technical Implementation

### Location Services
The app implements a robust location system using:

- GPS Coordinates: `Geolocator.getCurrentPosition()` to fetch precise latitude/longitude
- Address Conversion: `placemarkFromCoordinates()` to convert coordinates into readable addresses
- Error Handling: Comprehensive error handling for location services disabled, permissions denied, or network issues
- Loading States: Visual feedback during location fetching with circular progress indicators

### API Architecture
```dart
// Real-time location fetching
static Future<String> fetchLocation() async {
  Position position = await Geolocator.getCurrentPosition();
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude, 
    position.longitude
  );
  // Format and return human-readable address
}
```

## 📁 Folder Structure
```
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
│   └── api_service.dart            # Location API service
└── main.dart                      # App entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Android Studio / VS Code
- Android device or emulator with location services

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  geolocator: ^10.1.0      # GPS location services
  geocoding: ^3.0.0        # Address resolution
  permission_handler: ^11.3.1  # Permission management
```

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Add location permissions to your platform files:

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to set location-based alarms.</string>
```

4. Run `flutter run` to launch the app

## 📱 User Flow

### Onboarding Experience
1. **Sync with Nature's Rhythm**  
   Experience peaceful morning transitions  
   <img src="https://github.com/user-attachments/assets/e0062db6-78e7-43d5-b1b0-fca3de214928" alt="Onboarding Screen 2" width="200">
   
2. **Effortless & Automatic**  
   Smart sunset time calculations  
   
   <img src="https://github.com/user-attachments/assets/4620060a-5efb-416c-974c-c354cfb0d262" alt="Onboarding Screen 1" width="200">
3. **Relax & Unwind**  
   Pursue your dreams with confidence  

   <img src="https://github.com/user-attachments/assets/798f9510-eaf1-4123-a4e0-badf2665e87a" alt="Add Alarm Dialog" width="200">
### Location Setup & Main Features
| Feature | Description | Screenshot |
|---------|-------------|------------|
| **The front page** |  |<img src="https://github.com/user-attachments/assets/4057ddb3-6ddb-422e-9768-82a7f834fd57" alt="Home Screen" width="200">|
| **Google maps permission** |  Permission request popup and processing | <img src="https://github.com/user-attachments/assets/0774de96-639c-4cbe-b269-6ab44f780e6d" alt="Location Screen" width="200"> |
| **Add Alarm** | Current location and alarm list |   <img src="https://github.com/user-attachments/assets/8e2633ab-99c0-469d-8c5b-3b1dd8d20de0" alt="Onboarding Screen 3" width="200"> |

### Key Features
- **Permission Request**: App requests location permissions gracefully
- **GPS Detection**: Real-time coordinate fetching with loading indicator
- **Address Display**: Shows formatted address (street, city, country)
- **Alarm Management**: Create, toggle, and delete alarms with modern UI
- **Time Pickers**: Dark-themed date/time selection
- **Real-time Updates**: Live clock and reactive alarm states

## 🔧 Key Features Implementation

### Location Detection Flow
1. User taps "Use Current Location"
2. App shows loading spinner
3. Request and handle location permissions
4. Fetch GPS coordinates using Geolocator
5. Convert coordinates to address using Geocoding
6. Navigate to home page with location data
7. Display location in home screen interface

### Error Handling
- **Location Services Disabled**: Clear message with guidance
- **Permissions Denied**: Helpful error with fallback options
- **Network Issues**: Graceful degradation with error notifications
- **GPS Timeout**: Appropriate timeout handling with user feedback

## 🎨 Design Philosophy
The app follows modern Material Design principles with:
- **Dark Theme**: Easy on the eyes for early morning use
- **High Contrast**: Excellent readability in all lighting conditions
- **Smooth Animations**: Delightful micro-interactions throughout
- **Responsive Layout**: Works seamlessly across different screen sizes
- **Accessibility First**: High contrast pickers and clear visual hierarchy

---

Built with ❤️ using Flutter
