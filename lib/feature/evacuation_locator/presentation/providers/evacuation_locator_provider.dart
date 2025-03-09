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
  bool _showInitialPrompt = true;
  double _latitude = 0.0;
  double _longitude = 0.0;
  List<latlng.LatLng> _points = [];
  List<Marker> _markers = [];
  LatLngBounds? _bounds;
  RouteResponseModel? _routeResponseModel;
  final MapController _mapController = MapController();
  Marker? _userLocationMarker;
  EvacuationCenterModel? _nearestEvacuationCenter;

  // Add properties to track route-finding process
  final int _topCentersCount = 3;
  List<EvacuationCenterModel> _topNearestCenters = [];
  bool _isProcessingRoutes = false;
  double _processProgress = 0.0;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set setLatitude(double latitude) {
    _latitude = latitude;
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

  set setNearestEvacuationCenter(EvacuationCenterModel evac) {
    _nearestEvacuationCenter = evac;
    notifyListeners();
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void hideInitialPrompt() {
    _showInitialPrompt = false;
    notifyListeners();
  }

  bool get loading => _isLoading;
  bool get showInitialPrompt => _showInitialPrompt;
  double get latitude => _latitude;
  double get longitude => _longitude;
  List<latlng.LatLng> get points => _points;
  List<Marker> get markers => _markers;
  LatLngBounds? get bounds => _bounds;
  RouteResponseModel? get routeResponseModel => _routeResponseModel;
  EvacuationCenterModel? get nearestEvacuationCenter =>
      _nearestEvacuationCenter;
  MapController get mapController => _mapController;

  bool get isProcessingRoutes => _isProcessingRoutes;
  double get processProgress => _processProgress;
  List<EvacuationCenterModel> get topNearestCenters => _topNearestCenters;

  List<Marker> getMarkers() {
    return _generateMarkers();
  }

  void _updateUserLocationMarker() {
    if (_latitude != 0.0 && _longitude != 0.0) {
      _userLocationMarker = _createUserLocationMarker();
      notifyListeners();
    }
  }

  Marker _createUserLocationMarker() {
    return Marker(
      width: 150.0,
      height: 100.0,
      point: latlng.LatLng(_latitude, _longitude),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(230),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.blue, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'YOUR LOCATION',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer blue circle for pulse effect
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
              // Inner blue circle
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              ),
              // Center dot
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Marker> _generateMarkers() {
    return List<Marker>.from(
      EvacuationCenters.allCenters.map(
        (e) {
          bool isNearestCenter = _nearestEvacuationCenter != null &&
              e.latitude == _nearestEvacuationCenter!.latitude &&
              e.longitude == _nearestEvacuationCenter!.longitude;
          return Marker(
            width: 150.0,
            height: 100.0,
            point: latlng.LatLng(e.latitude, e.longitude),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isNearestCenter)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.redAccent, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'EVACUATE HERE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                const SizedBox(height: 4),
                isNearestCenter
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer red circle for pulse effect
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                          ),
                          // Inner red circle
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                          ),
                          // Center dot
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      )
                    : const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 30.0,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  void setMapControllerReady() {
    _isMapControllerReady = true;
    notifyListeners();
  }

  Future<void> fetchUserCoordinates() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isLoading = true;
    _isProcessingRoutes = true;
    hideInitialPrompt();

    clearRouteData();

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
      setLatitude = value.latitude;
      setLongitude = value.longitude;
    }).then((_) {
      route();
    });
  }

  Future<void> route() async {
    try {
      // Step 1: Find the top N nearest centers based on haversine distance
      _topNearestCenters = HaversineDistanceCalculation.findTopNNearestCenters(
        latlng.LatLng(_latitude, _longitude),
        EvacuationCenters.allCenters,
        n: _topCentersCount,
      );

      if (_topNearestCenters.isEmpty) {
        Fluttertoast.showToast(
          msg: 'No evacuation centers found',
          backgroundColor: const Color(0xFFFFCDD2),
          textColor: const Color(0xFFB71C1C),
        );
        isLoading = false;
        return;
      }

      _processProgress = 0.0;
      notifyListeners();

      // Step 2: Request routes to each of the top centers and find the one with shortest route
      RouteResponseModel? shortestRouteResponse;
      EvacuationCenterModel? centerWithShortestRoute;
      double? shortestRouteDistance;

      // Process each center
      for (int i = 0; i < _topNearestCenters.length; i++) {
        final center = _topNearestCenters[i];

        try {
          // Update progress
          _processProgress = i / _topNearestCenters.length;
          notifyListeners();

          final response = await http
              .get(
                OpenRouteServiceApi.getRouteUrl(
                  '$_longitude,$_latitude',
                  '${center.longitude},${center.latitude}',
                ),
              )
              .timeout(const Duration(seconds: 15));

          if (response.statusCode == 200) {
            final routeModel =
                RouteResponseModel.fromJson(json.decode(response.body));

            // Check if this route is valid
            if (routeModel.features.isNotEmpty) {
              final distance =
                  routeModel.features[0].properties.summary.distance;

              // Print center name and distance for debugging
              print(
                'Center: ${center.name}, Distance: ${distance.toStringAsFixed(2)} meters',
              );

              // If this is the first valid route or it's shorter than the current shortest
              if (shortestRouteDistance == null ||
                  distance < shortestRouteDistance) {
                shortestRouteDistance = distance;
                shortestRouteResponse = routeModel;
                centerWithShortestRoute = center;
              }
            }
          }
        } catch (e) {
          print('Error requesting route to center ${center.name}: $e');
          // Continue to the next center
        }
      }

      print("Center with shortest route: ${centerWithShortestRoute?.name}");

      // Step 3: Use the center with the shortest route
      if (centerWithShortestRoute != null && shortestRouteResponse != null) {
        setNearestEvacuationCenter = centerWithShortestRoute;
        _routeResponseModel = shortestRouteResponse;
        prettyPrintJson(json.encode(_routeResponseModel!.toJson()));
        updatePointsAndBounds(_routeResponseModel!);
        updateMarkers();
      } else {
        // Fallback to the physically nearest center if route calculation failed
        EvacuationCenterModel? nearestEvac =
            _topNearestCenters.isNotEmpty ? _topNearestCenters[0] : null;

        if (nearestEvac != null) {
          setNearestEvacuationCenter = nearestEvac;

          final response = await http
              .get(
                OpenRouteServiceApi.getRouteUrl(
                  '$_longitude,$_latitude',
                  '${nearestEvac.longitude},${nearestEvac.latitude}',
                ),
              )
              .timeout(const Duration(seconds: 15));

          if (response.statusCode == 200) {
            setRouteResponseModel = response.body;
            prettyPrintJson(response.body);
            updatePointsAndBounds(_routeResponseModel!);
            updateMarkers();
          } else {
            throw Exception('Server error: ${response.statusCode}');
          }
        } else {
          throw Exception('No evacuation centers available');
        }
      }
      _isProcessingRoutes = false;
      _processProgress = 1.0;
      notifyListeners();
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
      _isProcessingRoutes = false;
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
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: _bounds!,
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 120),
        ),
      );
    } else {
      // Handle the case where the map controller is not ready or bounds is null
      isLoading = false;
      print('MapController is not ready yet or bounds is invalid.');
    }
  }

  // Clear resources when done
  @override
  void dispose() {
    _mapController.dispose();
    // Clear any other resources that need cleanup
    super.dispose();
  }

  // Clear route points to free memory
  void clearRouteData() {
    _points = [];
    _routeResponseModel = null;
    notifyListeners();
  }
}
