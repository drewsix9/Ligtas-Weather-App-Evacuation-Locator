import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/api_key_storage.dart';

class ApiService {
  // Example of using the API key in a weather service
  static Future<Map<String, dynamic>> getWeatherData(
      double lat, double lon) async {
    final apiKey = await ApiKeyStorage.getApiKey('weather');

    if (apiKey == null) {
      throw Exception('Weather API key not found');
    }

    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Add other API methods as needed
}
