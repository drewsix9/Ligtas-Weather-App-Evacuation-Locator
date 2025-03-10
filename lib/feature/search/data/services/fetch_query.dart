import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pretty_print_json/pretty_print_json.dart';

import '../../../../core/utils/env_config.dart';
import '../model/suggestion_response/suggestion_response.dart';

class FetchQueryApi {
  static const String apiKey = EnvConfig.weatherApiKey;

  SuggestionResponse? suggestionResponse;

  static String apiUrl(String query) =>
      'http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=$apiKey';

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
