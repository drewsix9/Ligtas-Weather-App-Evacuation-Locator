import 'package:flutter/material.dart';

import '../../data/model/suggestion_response/suggestion_response.dart';

class SuggestionProvider extends ChangeNotifier {
  String _query = '';
  SuggestionResponse? suggestionResponse;
  TextEditingController queryController = TextEditingController();

  String get cityName => _query;

  set query(String cityName) {
    _query = cityName;
    notifyListeners();
  }
}
