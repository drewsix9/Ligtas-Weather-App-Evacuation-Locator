import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HourlyWeatherWidgetShimmer extends StatelessWidget {
  const HourlyWeatherWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
              color: Colors.grey[300],
            ),
          ),
        ),
        hourlyListShimmer(),
      ],
    );
  }

  Widget hourlyListShimmer() {
    return Container(
      height: 150,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 90,
              margin: EdgeInsets.only(
                left: 20,
                right: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget hourlyDetailsShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 50,
          height: 10,
          color: Colors.grey[300],
        ),
        Container(
          margin: EdgeInsets.all(5),
          height: 40,
          width: 40,
          color: Colors.grey[300],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          width: 30,
          height: 10,
          color: Colors.grey[300],
        ),
      ],
    ),
  );
}
