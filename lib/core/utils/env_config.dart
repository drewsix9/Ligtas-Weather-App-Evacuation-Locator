import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EnvConfig {
  static const String weatherApiKey =
      String.fromEnvironment('OPENWEATHER_API_KEY');
  static const String routeApiKey =
      String.fromEnvironment('OPENROUTESERVICE_API_KEY');

  static void validateEnvConfig() {
    if (weatherApiKey.isEmpty) {
      apiKeyErrorToast("Weather");
    }
    if (routeApiKey.isEmpty) {
      apiKeyErrorToast("Route");
    }
  }
}

Future<bool?> apiKeyErrorToast(String api) {
  return Fluttertoast.showToast(
    msg: '$api API key is not set',
    backgroundColor: const Color(0xFFFFCDD2),
    textColor: const Color(0xFFB71C1C),
  );
}
