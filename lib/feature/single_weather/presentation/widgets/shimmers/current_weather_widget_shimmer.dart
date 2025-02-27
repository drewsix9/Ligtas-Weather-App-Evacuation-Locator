import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CurrentWeatherWidgetShimmer extends StatelessWidget {
  const CurrentWeatherWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          temperatureAreaWidget(),
          SizedBox(height: 20),
          currentWeatherMoreDetailsWidget(),
        ],
      ),
    );
  }

  Widget currentWeatherMoreDetailsWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            shimmerContainer(),
            shimmerContainer(),
            shimmerContainer(),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            shimmerText(),
            shimmerText(),
            shimmerText(),
          ],
        ),
      ],
    );
  }

  Widget temperatureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        shimmerContainer(width: 80, height: 80),
        Container(height: 50, width: 1, color: Colors.grey[300]),
        shimmerContainer(width: 200, height: 80),
      ],
    );
  }

  Widget shimmerContainer({double width = 60, double height = 60}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget shimmerText({double width = 60, double height = 20}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
