import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/model/weather_response/weather_response.dart';

class DailyForecastWidget extends StatelessWidget {
  final WeatherResponse? weatherResponse;
  const DailyForecastWidget({super.key, required this.weatherResponse});

  String getDay(final day) {
    var time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    return DateFormat("EEE").format(time);
  }

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).dividerColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Container(
      height: isSmallScreen ? 300 : 400,
      margin: EdgeInsets.all(isSmallScreen ? 15 : 20),
      padding: EdgeInsets.all(isSmallScreen ? 12 : 15),
      decoration: BoxDecoration(
        color: dividerColor.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(bottom: isSmallScreen ? 8 : 10),
            child: Text(
              "Next Days",
              style: TextStyle(
                color: textColor,
                fontSize: isSmallScreen ? 15 : 17,
              ),
            ),
          ),
          dailyList(context),
        ],
      ),
    );
  }

  Widget dailyList(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return SizedBox(
      height: isSmallScreen ? 220 : 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: weatherResponse!.daily!.length > 7
            ? 7
            : weatherResponse!.daily!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: isSmallScreen ? 45 : 60,
                padding: EdgeInsets.only(
                  left: isSmallScreen ? 8 : 10,
                  right: isSmallScreen ? 8 : 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: isSmallScreen ? 60 : 80,
                      child: Text(
                        getDay(weatherResponse!.daily![index].dt!),
                        style: TextStyle(
                          color: textColor,
                          fontSize: isSmallScreen ? 11 : 13,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: isSmallScreen ? 25 : 30,
                      width: isSmallScreen ? 25 : 30,
                      child: Image.asset(
                        "assets/weather_icons/${weatherResponse!.daily![index].weather![0].icon}.png",
                      ),
                    ),
                    Text(
                      "${weatherResponse!.daily![index].temp!.max}°/${weatherResponse!.daily![index].temp!.min}°",
                      style: TextStyle(
                        color: textColor,
                        fontSize: isSmallScreen ? 11 : 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
