import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feature/single_weather/presentation/providers/state_provider.dart';
import 'feature/single_weather/presentation/screens/single_weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => StateProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const SingleWeatherScreen(),
      ),
    );
  }
}
