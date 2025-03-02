import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_print_json/pretty_print_json.dart';
import 'package:weather_app_evac_locator/feature/search/data/model/suggestion_response/suggestion_response.dart';

class FetchQueryApi {
  static final String apiKey = dotenv.env['API_KEY'] ?? '';

  SuggestionResponse? suggestionResponse;

  static String apiUrl(String query) =>
      'http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=$apiKey';

  Future<SuggestionResponse?> processData(String query) async {
    if (apiKey.isEmpty) {
      throw Exception('API key is not set');
    }
    var response = await http.get(Uri.parse(apiUrl(query)));
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      suggestionResponse = SuggestionResponse.fromJson(jsonString);
      return suggestionResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>?> fetchQuery(String query) async {
    if (apiKey.isEmpty) {
      throw Exception('API key is not set');
    }
    var response = await http.get(Uri.parse(apiUrl(query)));
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      prettyPrintJson(jsonString);
      return jsonString;
    }
    return null;
  }
}
