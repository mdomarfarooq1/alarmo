// Dummy Service for now
class ApiService {
  static Future<String> fetchLocation() async {
    await Future.delayed(Duration(seconds: 1));
    return '79 Regent\'s Park Rd, London NW1 8UY, United Kingdom';
  }
}
