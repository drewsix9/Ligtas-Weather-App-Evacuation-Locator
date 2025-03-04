import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../../data/datasources/evacuation_centers.dart';

List<Marker> getMarkers() {
  return List<Marker>.from(
    EvacuationCenters.allCenters.map(
      (e) => Marker(
        width: 80.0,
        height: 80.0,
        point: latlng.LatLng(e.latitude, e.longitude),
        child: Icon(
          Icons.location_on,
          color: Colors.redAccent,
          size: 30.0,
        ),
      ),
    ),
  );
}
