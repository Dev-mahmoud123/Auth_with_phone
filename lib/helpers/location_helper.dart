import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position> getPosition() async {
    /// Returns a bool value indicating whether location services are enabled on the device.
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      /// Request permission to access the location of the device
      await Geolocator.requestPermission();
    }
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
