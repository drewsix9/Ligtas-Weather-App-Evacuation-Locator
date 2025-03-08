import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/theme_provider.dart';

class HourlyWeatherWidgetShimmer extends StatelessWidget {
  const HourlyWeatherWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          alignment: Alignment.topCenter,
          child: Container(
            width: 80,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: baseColor,
            ),
          ),
        ),
        hourlyListShimmer(context),
      ],
    );
  }

  Widget hourlyListShimmer(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[600]! : Colors.grey[100]!;

    return Container(
      height: 150,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: 90,
              margin: EdgeInsets.only(
                left: 20,
                right: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: baseColor,
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget hourlyDetailsShimmer(BuildContext context) {
  final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
  final baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;
  final highlightColor = isDarkMode ? Colors.grey[600]! : Colors.grey[100]!;

  return Shimmer.fromColors(
    baseColor: baseColor,
    highlightColor: highlightColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 50,
          height: 10,
          color: baseColor,
        ),
        Container(
          margin: EdgeInsets.all(5),
          height: 40,
          width: 40,
          color: baseColor,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          width: 30,
          height: 10,
          color: baseColor,
        ),
      ],
    ),
  );
}
