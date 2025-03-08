import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/theme_provider.dart';

import '../../evacuation_locator/presentation/screens/evacuation_locator_screen.dart';
import '../../single_weather/presentation/screens/single_weather_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const SingleWeatherScreen(),
    const EvacuationLocatorScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isToggled;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Evacuation',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: isDarkMode
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary,
        unselectedItemColor: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        backgroundColor: isDarkMode ? Color(0xFF1A1A1A) : Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
