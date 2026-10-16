import 'package:geolocator/geolocator.dart';

class Permission {
  static Future<bool> hasLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  static Future<void> requestPermission() async {
    if (!await hasLocationPermission()) {
      await Geolocator.requestPermission();
    }
  }

  static Future<Position?> getPosition() async {
    if (await hasLocationPermission()) {
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: .high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      return position;
    }
    return null;
  }
}
