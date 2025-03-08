import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/theme_provider.dart';

class DailyForecastWidgetShimmer extends StatelessWidget {
  const DailyForecastWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[600]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        height: 400,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 10),
              width: 100,
              height: 20,
              color: baseColor,
            ),
            dailyListShimmer(context),
          ],
        ),
      ),
    );
  }

  Widget dailyListShimmer(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 60,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 80,
                      height: 20,
                      color: baseColor,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      color: baseColor,
                    ),
                    Container(
                      width: 80,
                      height: 20,
                      color: baseColor,
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
