import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http show get;
import 'package:latlong2/latlong.dart' as latlng;
import 'package:pretty_print_json/pretty_print_json.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/data/models/evacuation_center_model.dart';

import '../../data/datasources/evacuation_centers.dart';
import '../../data/models/route_response_model.dart';
import '../../data/services/openrouteservice_api.dart';
import '../../domain/usecases/haversine_distance_calculation.dart';

class EvacuationLocatorProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _isMapControllerReady = false;
  double _latitude = 0.0;
  double _longitude = 0.0;
  List<latlng.LatLng> _points = [];
  List<Marker> _markers = [];
  LatLngBounds? _bounds;
  RouteResponseModel? _routeResponseModel;
  final MapController mapController = MapController();
  Marker? _userLocationMarker;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set setLattitude(double lattitude) {
    _latitude = lattitude;
    _updateUserLocationMarker();
    notifyListeners();
  }

  set setLongitude(double longitude) {
    _longitude = longitude;
    _updateUserLocationMarker();
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
  double get lattitude => _latitude;
  double get longitude => _longitude;
  List<latlng.LatLng> get points => _points;
  List<Marker> get markers => _markers;

  LatLngBounds? get bounds => _bounds;
  RouteResponseModel? get routeResponseModel => _routeResponseModel;

  List<Marker> getMarkers() {
    return List<Marker>.from(
      EvacuationCenters.allCenters.map(
        (e) => Marker(
          width: 80.0,
          height: 80.0,
          point: latlng.LatLng(e.latitude, e.longitude),
          child: Transform.translate(
            offset: const Offset(
              0,
              -8,
            ), // Reduced offset for more precise placement
            child: const Icon(
              Icons.location_on,
              color: Colors.redAccent,
              size: 30.0,
            ),
          ),
          // alignment: Alignment.topCenter, // Align to top center of marker space
        ),
      ),
    );
  }

  void _updateUserLocationMarker() {
    if (_latitude != 0.0 && _longitude != 0.0) {
      _userLocationMarker = Marker(
        width: 80.0,
        height: 80.0,
        point: latlng.LatLng(_latitude, _longitude),
        child: Transform.translate(
          offset:
              const Offset(0, -8), // Reduced offset for more precise placement
          child: const Icon(
            Icons.location_on,
            color: Colors.blueAccent,
            size: 30.0,
          ),
        ),
        // alignment: Alignment.topCenter, // Align to top center of marker space
      );
      notifyListeners();
    }
  }

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
    try {
      EvacuationCenterModel nearestEvac =
          HaversineDistanceCalculation.nearestEvac(
        latlng.LatLng(_latitude, _longitude),
      );

      var response = await http
          .get(
            OpenRouteServiceApi.getRouteUrl(
              '$_longitude,$_latitude',
              '${nearestEvac.longitude},${nearestEvac.latitude}',
            ),
          )
          .timeout(const Duration(seconds: 15)); // Add timeout

      if (response.statusCode == 200) {
        setRouteResponseModel = response.body;
        prettyPrintJson(response.body);
        updatePointsAndBounds(_routeResponseModel!);
        updateMarkers();
      } else {
        Fluttertoast.showToast(
          msg: 'Server error: ${response.statusCode}',
          backgroundColor: const Color(0xFFFFCDD2),
          textColor: const Color(0xFFB71C1C),
        );
        print('API Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Network error. Please check your internet connection.',
        backgroundColor: const Color(0xFFFFCDD2),
        textColor: const Color(0xFFB71C1C),
      );
      print('Network Error: $e');
      _points = [];
      _bounds = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateMarkers() {
    _markers.clear();
    _markers = getMarkers();
    _markers.add(_userLocationMarker!);
    notifyListeners();
  }

  void updatePointsAndBounds(
    RouteResponseModel routeResponseApiModelProvider,
  ) {
    if (_routeResponseModel != null &&
        _routeResponseModel!.features.isNotEmpty &&
        _routeResponseModel!.features[0].geometry.coordinates.isNotEmpty) {
      _points = _routeResponseModel!.features[0].geometry.coordinates
          .map((e) => latlng.LatLng(e[1].toDouble(), e[0].toDouble()))
          .toList();

      // Only set bounds if we have at least one point
      if (_points.isNotEmpty) {
        try {
          _bounds = _routeResponseModel!.toLatLngBounds();
        } catch (e) {
          print('Error creating bounds: $e');
          _bounds = null;
        }
      } else {
        _bounds = null;
        print('No points available to create bounds');
      }
    } else {
      _points = [];
      _bounds = null;
      print('Invalid route response model or empty coordinates');
    }
    updateBounds();
  }

  void updateBounds() {
    if (_isMapControllerReady && _bounds != null && _points.isNotEmpty) {
      isLoading = false;
      mapController.fitCamera(
        CameraFit.bounds(
          bounds: _bounds!,
          padding: EdgeInsets.fromLTRB(50, 100, 50, 250),
        ),
      );
    } else {
      // Handle the case where the map controller is not ready or bounds is null
      isLoading = false;
      print('MapController is not ready yet or bounds is invalid.');
    }
  }
}
