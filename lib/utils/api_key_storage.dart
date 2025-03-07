import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyStorage {
  static const String _apiKeyPrefix = 'api_key_';
  static final _secureStorage = FlutterSecureStorage();

  // Store API key securely
  static Future<void> storeApiKey(String keyName, String keyValue) async {
    await _secureStorage.write(key: _apiKeyPrefix + keyName, value: keyValue);

    // Also store a flag in shared preferences to indicate the key exists
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_apiKeyPrefix${keyName}_exists', true);
  }

  // Retrieve API key
  static Future<String?> getApiKey(String keyName) async {
    return await _secureStorage.read(key: _apiKeyPrefix + keyName);
  }

  // Check if API key exists
  static Future<bool> hasApiKey(String keyName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_apiKeyPrefix${keyName}_exists') ?? false;
  }

  // Initialize API keys on first run
  static Future<void> initializeDefaultApiKeys() async {
    // Add any default API keys from your assets or constants
    final hasWeatherKey = await hasApiKey('weather');
    if (!hasWeatherKey) {
      // Read from bundled config
      await storeApiKey('weather', DefaultApiKeys.weatherApiKey);
    }

    // Initialize OpenRouteService API key if not already set
    final hasOpenRouteServiceKey = await hasApiKey('openrouteservice');
    if (!hasOpenRouteServiceKey) {
      await storeApiKey(
        'openrouteservice',
        DefaultApiKeys.openRouteServiceApiKey,
      );
    }

    // Add other API keys as needed
  }
}

// Store default keys that will be bundled with the app
class DefaultApiKeys {
  static const String weatherApiKey = '9dda8703a160d6dfb09adb012c9e1c00';
  static const String openRouteServiceApiKey =
      '5b3ce3597851110001cf62480cc8ac95b6ed4aa1a36da4adb41196ca'; // Add your actual key here
  // Add other API keys as needed
}
