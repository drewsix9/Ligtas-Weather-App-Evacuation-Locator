import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http show get;
import 'package:latlong2/latlong.dart' as latlng;
import 'package:pretty_print_json/pretty_print_json.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/data/models/evacuation_center_model.dart';

import '../../data/models/route_response_model.dart';
import '../../data/services/openrouteservice_api.dart';
import '../../domain/usecases/haversine_distance_calculation.dart';

class EvacuationLocatorProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _isMapControllerReady = false;
  double _lattitude = 0.0;
  double _longitude = 0.0;
  List<latlng.LatLng> _points = [];
  final List<Marker> _markers = [];
  LatLngBounds? _bounds;
  RouteResponseModel? _routeResponseModel;
  final MapController mapController = MapController();

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

  set setRouteResponseModel(String body) {
    _routeResponseModel = RouteResponseModel.fromJson(json.decode(body));
    notifyListeners();
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool get loading => _isLoading;
  double get lattitude => _lattitude;
  double get longitude => _longitude;
  List<latlng.LatLng> get points => _points;
  List<Marker> get markers => _markers;
  LatLngBounds? get bounds => _bounds;
  RouteResponseModel? get routeResponseModel => _routeResponseModel;

  void setMapControllerReady() {
    _isMapControllerReady = true;
    notifyListeners();
  }

  Future<void> fetchUserCoordinates() async {
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
    }).then((_) {
      route();
    });
  }

  Future<void> route() async {
    EvacuationCenterModel nearestEvac =
        HaversineDistanceCalculation.nearestEvac(
      latlng.LatLng(_lattitude, _longitude),
    );
    var response = await http.get(
      OpenRouteServiceApi.getRouteUrl(
        '$_longitude,$_lattitude',
        '${nearestEvac.longitude},${nearestEvac.latitude}',
      ),
    );
    if (response.statusCode == 200) {
      setRouteResponseModel = response.body;
      prettyPrintJson(response.body);
      updatePointsAndBounds(_routeResponseModel!);
    } else {
      throw Exception('Failed to load coordinates: ${response.statusCode}');
    }
    isLoading = false;
  }

  void updatePointsAndBounds(
    RouteResponseModel routeResponseApiModelProvider,
  ) {
    _points = _routeResponseModel!.features[0].geometry.coordinates
        .map((e) => latlng.LatLng(e[1].toDouble(), e[0].toDouble()))
        .toList();
    _bounds = _routeResponseModel!.toLatLngBounds();
    updateBounds();
  }

  void updateBounds() {
    if (_isMapControllerReady) {
      isLoading = false;
      mapController.fitCamera(
        CameraFit.bounds(
          bounds: bounds!,
          padding: EdgeInsets.fromLTRB(50, 100, 50, 250),
        ),
      );
    } else {
      // Handle the case where the map controller is not ready
      print('MapController is not ready yet.');
    }
  }
}
