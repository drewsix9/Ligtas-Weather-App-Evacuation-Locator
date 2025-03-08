import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/theme_provider.dart';

import '../../data/model/weather_response/weather_response.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherResponse weatherResponse;
  const CurrentWeatherWidget({super.key, required this.weatherResponse});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        temperatureAreaWidget(context),
        SizedBox(height: 20),
        currentWeatherMoreDetailsWidget(context),
      ],
    );
  }

  Widget currentWeatherMoreDetailsWidget(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Tooltip(
              message: "Wind Speed",
              child: Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset("assets/icons/windspeed.png"),
              ),
            ),
            Tooltip(
              message: "Precipitation",
              child: Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset("assets/icons/clouds.png"),
              ),
            ),
            Tooltip(
              message: "Humidity",
              child: Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset("assets/icons/humidity.png"),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 70,
              child: Text(
                "${weatherResponse.current!.windSpeed} m/s",
                style: TextStyle(fontSize: 12, color: textColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 70,
              child: Text(
                "${weatherResponse.daily![0].rain} mm/H",
                style: TextStyle(fontSize: 12, color: textColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 70,
              child: Text(
                "${weatherResponse.current!.humidity} %",
                style: TextStyle(fontSize: 12, color: textColor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget temperatureAreaWidget(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final dividerColor = Theme.of(context).dividerColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final secondaryTextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather_icons/${weatherResponse.current!.weather![0].icon}.png",
          height: 80,
          width: 80,
        ),
        Container(height: 50, width: 1, color: dividerColor),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${weatherResponse.current!.temp!}°",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 68,
                  color: textColor,
                ),
              ),
              TextSpan(
                text: "${weatherResponse.current!.weather![0].description}",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
