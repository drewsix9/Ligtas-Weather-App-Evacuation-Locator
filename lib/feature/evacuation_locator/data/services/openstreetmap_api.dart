import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

class OpenStreetMapApiProvider extends ChangeNotifier {
  List<latlng.LatLng> _points = [];
  List<Marker> _markers = [];
  LatLngBounds? _bounds;

  final MapController mapController = MapController();

  List<latlng.LatLng> get points => _points;
  List<Marker> get markers => _markers;
  LatLngBounds? get bounds => _bounds;

  set points(List<latlng.LatLng> value) {
    _points = value;
    notifyListeners();
  }

  set markers(List<Marker> value) {
    _markers = value;
    notifyListeners();
  }

  set bounds(LatLngBounds? value) {
    _bounds = value;
    notifyListeners();
  }

  void resetOpenStreetMap() {
    _points = [];
    _markers = [];
    _bounds = null;
    notifyListeners();
  }
}
