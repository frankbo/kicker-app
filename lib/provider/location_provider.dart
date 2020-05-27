import 'package:geolocator/geolocator.dart';

class LocationProvider {
  static Future<Position> getCurrentLocation() =>
      Geolocator().getCurrentPosition();
}
