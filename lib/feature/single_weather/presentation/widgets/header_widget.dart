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
  String city = "Loading location..."; // Default value while loading
  bool isLoadingCity = true;
  String formattedDateTime = "";
  String timeZoneName = "";
  late LocationProvider locationProvider;
  late SuggestionProvider suggestionProvider;

  @override
  void initState() {
    super.initState();
    // Set initial city from weather data immediately
    _setInitialCity();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      locationProvider = context.read<LocationProvider>();
      suggestionProvider = context.read<SuggestionProvider>();
      getAddress(
        locationProvider.getLattitude,
        locationProvider.getLongitude,
      );
      updateTimeWithOffset();
    });
  }

  void _setInitialCity() {
    // Use timezone from weather data as initial city name
    if (widget.weatherResponse.timezone != null) {
      String initialCity =
          widget.weatherResponse.timezone!.split('/').last.replaceAll('_', ' ');
      setState(() {
        city = initialCity;
      });
    }
  }

  @override
  void didUpdateWidget(covariant HeaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.weatherResponse != widget.weatherResponse) {
      // Set city from weather data immediately when data changes
      _setInitialCity();

      getAddress(
        locationProvider.getLattitude,
        locationProvider.getLongitude,
      );
      updateTimeWithOffset();
    }
  }

  void updateTimeWithOffset() {
    if (widget.weatherResponse.timezoneOffset != null) {
      // Get current UTC time
      final utcTime = DateTime.now().toUtc();

      // Apply timezone offset (in seconds) to get local time
      final offsetInSeconds = widget.weatherResponse.timezoneOffset!;
      final localTime = utcTime.add(Duration(seconds: offsetInSeconds));

      // Format the date and time together
      final dateFormatter = DateFormat.yMMMMd('en_US');
      final timeFormatter = DateFormat('HH:mm');

      final formattedDate = dateFormatter.format(localTime);
      final formattedTime = timeFormatter.format(localTime);

      // Get timezone name from offset
      final hours = (offsetInSeconds / 3600).round();
      final timeZoneFormatted = hours >= 0 ? 'GMT+$hours' : 'GMT$hours';

      setState(() {
        formattedDateTime = "$formattedDate $formattedTime";
        timeZoneName = timeZoneFormatted;
      });
    } else {
      // Fallback to UTC if no timezone offset is available
      final now = DateTime.now().toUtc();
      final formattedDate = DateFormat.yMMMMd('en_US').format(now);
      final formattedTime = DateFormat('HH:mm').format(now);

      setState(() {
        formattedDateTime = "$formattedDate $formattedTime";
        timeZoneName = "UTC";
      });
    }
  }

  getAddress(lat, lon) async {
    setState(() {
      isLoadingCity = true;
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        // Use locality if available, otherwise try other fields
        if (place.locality != null && place.locality!.isNotEmpty) {
          setState(() {
            city = place.locality!;
            isLoadingCity = false;
          });
        } else if (place.subAdministrativeArea != null &&
            place.subAdministrativeArea!.isNotEmpty) {
          setState(() {
            city = place.subAdministrativeArea!;
            isLoadingCity = false;
          });
        } else if (place.administrativeArea != null &&
            place.administrativeArea!.isNotEmpty) {
          setState(() {
            city = place.administrativeArea!;
            isLoadingCity = false;
          });
        } else {
          // Keep using the initial city name from timezone
          setState(() {
            isLoadingCity = false;
          });
        }
      } else {
        // No placemarks found, keep using the initial city name
        setState(() {
          isLoadingCity = false;
        });
      }
    } catch (e) {
      print('Error getting location name: $e');
      // Keep using the initial city name
      setState(() {
        isLoadingCity = false;
      });
    }
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
          child: isLoadingCity
              ? Row(
                  children: [
                    Text(
                      city,
                      style: TextStyle(
                        fontSize: 35,
                        height: 2,
                        color: textColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          secondaryTextColor ?? Colors.grey,
                        ),
                      ),
                    ),
                  ],
                )
              : Text(
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
            "as of $formattedDateTime ($timeZoneName)",
            style: TextStyle(
              fontSize: 14,
              color: secondaryTextColor,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
