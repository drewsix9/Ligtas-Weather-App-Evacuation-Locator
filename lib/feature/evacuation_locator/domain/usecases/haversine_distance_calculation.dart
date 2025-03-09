import 'package:latlong2/latlong.dart' as latlng;
import 'package:latlong2/latlong.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/data/models/evacuation_center_model.dart';

class HaversineDistanceCalculation {
  static double calcDistance(LatLng start, LatLng end) {
    return Distance().as(LengthUnit.Meter, start, end);
  }

  static EvacuationCenterModel? findNearestEvacuationCenter(
    latlng.LatLng userLocation,
    List<EvacuationCenterModel> allCenters,
  ) {
    if (allCenters.isEmpty) {
      return null;
    }

    EvacuationCenterModel? nearestCenter;
    double? shortestDistance;

    // Calculate distance to each center
    for (final center in allCenters) {
      final centerLocation = latlng.LatLng(center.latitude, center.longitude);

      // Calculate distance using the provided method
      final distance = Distance().as(
        LengthUnit.Meter,
        userLocation,
        centerLocation,
      );

      // Update nearest center if this one is closer
      if (shortestDistance == null || distance < shortestDistance) {
        shortestDistance = distance;
        nearestCenter = center;
      }
    }

    return nearestCenter;
  }

  /// Find the top N nearest evacuation centers based on haversine distance
  static List<EvacuationCenterModel> findTopNNearestCenters(
    latlng.LatLng userLocation,
    List<EvacuationCenterModel> allCenters, {
    int n = 3,
  }) {
    if (allCenters.isEmpty) {
      return [];
    }

    // Create a list of centers with their distances
    final centersWithDistances = allCenters.map((center) {
      final centerLocation = latlng.LatLng(center.latitude, center.longitude);
      final distance = Distance().as(
        LengthUnit.Meter,
        userLocation,
        centerLocation,
      );
      return {'center': center, 'distance': distance};
    }).toList();

    // Sort by distance
    centersWithDistances.sort(
      (a, b) => (a['distance'] as double).compareTo(b['distance'] as double),
    );

    // Take the top N centers (or fewer if there aren't enough)
    final actualN =
        n > centersWithDistances.length ? centersWithDistances.length : n;

    return centersWithDistances
        .sublist(0, actualN)
        .map((item) => item['center'] as EvacuationCenterModel)
        .toList();
  }
}
