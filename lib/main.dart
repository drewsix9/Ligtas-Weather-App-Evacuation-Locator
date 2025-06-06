import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'feature/evacuation_locator/presentation/providers/evacuation_locator_provider.dart';
import 'feature/navigation/screens/main_screen.dart';
import 'feature/search/presentation/providers/suggestion_provider.dart';
import 'feature/single_weather/presentation/providers/location_provider.dart';
import 'feature/single_weather/presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      title: 'WeVacuate',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: MainScreen(),
    );
  }
}
