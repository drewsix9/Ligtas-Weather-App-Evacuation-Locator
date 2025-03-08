import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_evac_locator/feature/search/presentation/providers/suggestion_provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/theme_provider.dart';

import '../../data/model/weather_response/weather_response.dart';
import '../providers/location_provider.dart';

class HeaderWidget extends StatefulWidget {
  final WeatherResponse weatherResponse;

  const HeaderWidget({super.key, required this.weatherResponse});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat.yMMMMd('en_US').format(DateTime.now());
  late LocationProvider locationProvider;
  late SuggestionProvider suggestionProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      locationProvider = context.read<LocationProvider>();
      suggestionProvider = context.read<SuggestionProvider>();
      getAddress(
        locationProvider.getLattitude,
        locationProvider.getLongitude,
      );
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.weatherResponse != widget.weatherResponse) {
      getAddress(
        locationProvider.getLattitude,
        locationProvider.getLongitude,
      );
      setState(() {
        date = DateFormat.yMMMMd('en_US').format(DateTime.now());
      });
    }
  }

  getAddress(lat, lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemarks[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final secondaryTextColor = isDarkMode ? Colors.grey[400] : Colors.grey[700];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: TextStyle(
              fontSize: 35,
              height: 2,
              color: textColor,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: secondaryTextColor,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
