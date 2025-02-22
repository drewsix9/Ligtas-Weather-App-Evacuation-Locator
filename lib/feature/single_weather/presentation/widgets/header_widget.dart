import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/location_provider.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat.yMMMMd('en_US').format(DateTime.now());
  late LocationProvider locationProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      locationProvider = context.read<LocationProvider>();
      getAddress(
        locationProvider.getLattitude(),
        locationProvider.getLongitude(),
      );
    });
    super.initState();
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
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(city, style: TextStyle(fontSize: 35, height: 2)),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
