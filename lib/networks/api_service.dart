import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ApiService {
  // Get current location and convert to address
  static Future<String> fetchLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied, we cannot request permissions.');
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Convert coordinates to address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        
        // Format address
        String address = '';
        if (place.street != null && place.street!.isNotEmpty) {
          address += '${place.street}, ';
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          address += '${place.locality}';
        }
        if (place.postalCode != null && place.postalCode!.isNotEmpty) {
          address += ' ${place.postalCode}';
        }
        if (place.country != null && place.country!.isNotEmpty) {
          address += ', ${place.country}';
        }

        return address.isNotEmpty ? address : 'Location found but address unavailable';
      } else {
        return 'Address not found';
      }
    } catch (e) {
      // Return error message or fallback location
      return 'Unable to fetch location: ${e.toString()}';
    }
  }
}