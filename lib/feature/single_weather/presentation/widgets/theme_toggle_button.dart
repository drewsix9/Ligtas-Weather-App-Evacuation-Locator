import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  final bool showLabel;

  const ThemeToggleButton({
    super.key,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLabel)
              Text(
                themeProvider.isToggled ? 'Dark Mode' : 'Light Mode',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                themeProvider.isToggled ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
              tooltip: themeProvider.isToggled
                  ? 'Switch to Light Mode'
                  : 'Switch to Dark Mode',
            ),
          ],
        );
      },
    );
  }
}
