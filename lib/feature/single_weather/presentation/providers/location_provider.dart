import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pretty_print_json/pretty_print_json.dart';
import 'package:weather_app_evac_locator/feature/single_weather/domain/usecases/fetch_weather.dart';

import '../../data/model/weather_response/weather_response.dart';

class LocationProvider with ChangeNotifier {
  bool _isLoading = true;
  double _lattitude = 0.0;
  double _longitude = 0.0;
  int _currentIndex = 0;

  WeatherResponse? weatherResponse;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set setLattitude(double lattitude) {
    _lattitude = lattitude;
    notifyListeners();
  }

  set setLongitude(double longitude) {
    _longitude = longitude;
    notifyListeners();
  }

  set setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool get checkLoading => _isLoading; // TODO: Change into getter
  double get getLattitude => _lattitude;
  double get getLongitude => _longitude;
  int get getCurrentIndex => _currentIndex;

  fetchCurrentLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isLoading = true;

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
      setLattitude = value.latitude;
      setLongitude = value.longitude;
      return FetchWeatherApi()
          .processData(value.latitude, value.longitude)
          .then((value) {
        prettyPrintJson(value?.toJson() as Object);
        weatherResponse = value;
        isLoading = false;
      });
    });
  }

  fetchLatLngLocation(lat, lng) async {
    return await FetchWeatherApi().processData(lat, lng).then((value) {
      setLattitude = lat;
      setLongitude = lng;
      prettyPrintJson(value?.toJson() as Object);
      weatherResponse = value;
      isLoading = false;
    });
  }
}
