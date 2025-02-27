import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DailyForecastWidgetShimmer extends StatelessWidget {
  const DailyForecastWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 400,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[300]!,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 10),
              width: 100,
              height: 20,
              color: Colors.grey[300],
            ),
            dailyListShimmer(),
          ],
        ),
      ),
    );
  }

  Widget dailyListShimmer() {
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
                      color: Colors.grey[300],
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      color: Colors.grey[300],
                    ),
                    Container(
                      width: 80,
                      height: 20,
                      color: Colors.grey[300],
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
