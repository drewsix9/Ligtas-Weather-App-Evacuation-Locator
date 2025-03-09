import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weather_response/weather_response.dart';

class FetchWeatherApi {
  static const String apiKey = String.fromEnvironment('OPENWEATHER_API_KEY');

  WeatherResponse? weatherResponse;

  String apiUrl(var lat, var lon) =>
      'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&exclude=minutely&units=metric';

  Future<WeatherResponse?> processData(lat, lon) async {
    if (apiKey.isEmpty) {
      throw Exception('API key is not set');
    }
    var response = await http.get(Uri.parse(apiUrl(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherResponse = WeatherResponse.fromJson(jsonString);
    return weatherResponse;
  }
}
