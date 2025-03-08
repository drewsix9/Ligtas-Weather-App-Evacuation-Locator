import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/theme_provider.dart';

class CurrentWeatherWidgetShimmer extends StatelessWidget {
  const CurrentWeatherWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[600]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        children: [
          temperatureAreaWidget(context),
          SizedBox(height: 20),
          currentWeatherMoreDetailsWidget(context),
        ],
      ),
    );
  }

  Widget currentWeatherMoreDetailsWidget(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            shimmerContainer(context),
            shimmerContainer(context),
            shimmerContainer(context),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            shimmerText(context),
            shimmerText(context),
            shimmerText(context),
          ],
        ),
      ],
    );
  }

  Widget temperatureAreaWidget(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        shimmerContainer(context, width: 80, height: 80),
        Container(height: 50, width: 1, color: baseColor),
        shimmerContainer(context, width: 200, height: 80),
      ],
    );
  }

  Widget shimmerContainer(
    BuildContext context, {
    double width = 60,
    double height = 60,
  }) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget shimmerText(
    BuildContext context, {
    double width = 60,
    double height = 20,
  }) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
