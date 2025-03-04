import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenRouteServiceApi {
  static final String openrouteserviceApiKey =
      dotenv.env['OPENROUTESERVICE_API_KEY'] ?? '';
  static const String routeBaseUrl =
      'https://api.openrouteservice.org/v2/directions/driving-car';

  static const String autoCompleteBaseUrl =
      'https://api.openrouteservice.org/geocode/autocomplete';

  static getRouteUrl(String startPoint, String endPoint) {
    return Uri.parse(
      '$routeBaseUrl?api_key=$openrouteserviceApiKey&start=$startPoint&end=$endPoint',
    );
  }

  static getAutoCompleteUrl(String query) {
    return Uri.parse(
      '$autoCompleteBaseUrl?api_key=$openrouteserviceApiKey&text=$query&focus.point.lon=123.8730&focus.point.lat=9.6729&boundary.rect.min_lon=123.84306489882289&boundary.rect.min_lat=9.62486500652239&boundary.rect.max_lon=123.91320487214959&boundary.rect.max_lat=9.701754266358614&boundary.country=PH&layers=address,venue,neighbourhood,locality',
    );
  }
}
