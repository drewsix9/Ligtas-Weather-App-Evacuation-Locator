import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/presentation/providers/evacuation_locator_provider.dart';
import 'package:weather_app_evac_locator/feature/navigation/screens/main_screen.dart';
import 'package:weather_app_evac_locator/feature/search/presentation/providers/suggestion_provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/location_provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: "assets/.env");
    print('Environment variables loaded successfully');
  } catch (e) {
    print('Error loading .env file: $e');
  }

  // Set immersive sticky mode - hides system bars but they can be revealed with a swipe
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => SuggestionProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => EvacuationLocatorProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'weather_app_evac_locator',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: MainScreen(),
    );
  }
}
