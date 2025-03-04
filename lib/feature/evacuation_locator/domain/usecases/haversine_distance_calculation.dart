import 'package:latlong2/latlong.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/data/datasources/evacuation_centers.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/data/models/evacuation_center_model.dart';

class HaversineDistanceCalculation {
  static double calcDistance(LatLng start, LatLng end) {
    return Distance().as(LengthUnit.Kilometer, start, end);
  }

  static EvacuationCenterModel nearestEvac(LatLng point) {
    double minDistance = double.infinity;
    EvacuationCenterModel nearestEvac = EvacuationCenters.allCenters[0];
    List<EvacuationCenterModel> evacuationCenters =
        EvacuationCenters.allCenters;
    for (var evac in evacuationCenters) {
      double distance =
          calcDistance(point, LatLng(evac.latitude, evac.longitude));
      minDistance = distance < minDistance ? distance : minDistance;
      nearestEvac = distance < minDistance ? evac : nearestEvac;
    }
    return nearestEvac;
  }
}
