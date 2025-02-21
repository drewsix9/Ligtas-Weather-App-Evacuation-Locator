import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

class StateProvider with ChangeNotifier {
  final bool _isLoading = true;
  double _lattitude = 0.0;
  double _longitude = 0.0;

  void setLattitude(double lattitude) {
    _lattitude = lattitude;
  }

  void setLongitude(double longitude) {
    _longitude = longitude;
  }

  bool checkLoading() => _isLoading;
  double getLattitude() => _lattitude;
  double getLongitude() => _longitude;

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error('Location services are disabled.');
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
        "Location permission are denied forever, we cannot request permissions.",
      );
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((value) {
      setLattitude(value.latitude);
      setLongitude(value.longitude);
      notifyListeners();
    });
  }
}
