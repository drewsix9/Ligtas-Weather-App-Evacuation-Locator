import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/custom_colors.dart';
import '../../data/model/weather_response/weather_response.dart';
import '../providers/location_provider.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final WeatherResponse weatherResponse;
  const HourlyWeatherWidget({
    super.key,
    required this.weatherResponse,
  });

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
          child: Text(
            "Today",
            style: TextStyle(fontSize: 18),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 150,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherResponse.hourly!.length > 12
            ? 12
            : weatherResponse.hourly!.length,
        itemBuilder: (context, index) {
          return Consumer<LocationProvider>(
            builder: (context, value, child) {
              int cardIndex = value.getCurrentIndex();
              return GestureDetector(
                onTap: () {
                  value.setCurrentIndex = index;
                },
                child: Container(
                  width: 90,
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 5,
                  ),
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.5, 0),
                        blurRadius: 30,
                        spreadRadius: 1,
                        color: CustomColors.dividerLine.withAlpha(150),
                      ),
                    ],
                    gradient: cardIndex == index
                        ? LinearGradient(
                            colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor,
                            ],
                          )
                        : null,
                  ),
                  child: HourlyDetails(
                    temp: weatherResponse.hourly![index].temp!,
                    timeStamp: weatherResponse.hourly![index].dt!,
                    weatherIcon:
                        weatherResponse.hourly![index].weather![0].icon!,
                    index: index,
                    cardIndex: cardIndex,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  final int temp;
  final int timeStamp;
  final String weatherIcon;
  int index;
  int cardIndex;

  String getTime(final timeStamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(
      timeStamp * 1000,
    );
    return DateFormat("jm").format(date);
  }

  HourlyDetails({
    super.key,
    required this.temp,
    required this.timeStamp,
    required this.weatherIcon,
    required this.index,
    required this.cardIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(
              color: cardIndex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          height: 40,
          width: 40,
          child: Image.asset(
            "assets/weather_icons/$weatherIcon.png",
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp°",
            style: TextStyle(
              color: cardIndex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
            ),
          ),
        ),
      ],
    );
  }
}
