import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/theme_provider.dart';

import '../../../../core/utils/custom_colors.dart';
import '../../../search/presentation/providers/suggestion_provider.dart';
import '../../../search/presentation/widgets/show_city_selection_dialog.dart';
import '../providers/location_provider.dart';
import '../widgets/comfort_level_widget.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/daily_foreacast_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/hourly_weather_widget.dart';
import '../widgets/shimmers/current_weather_widget_shimmer.dart';
import '../widgets/shimmers/daily_forecast_widget_shimmer.dart';
import '../widgets/shimmers/header_widget_shimmer.dart';
import '../widgets/shimmers/hourly_weather_widget_shimmer.dart';

class SingleWeatherScreen extends StatefulWidget {
  const SingleWeatherScreen({super.key});

  @override
  State<SingleWeatherScreen> createState() => _SingleWeatherScreenState();
}

class _SingleWeatherScreenState extends State<SingleWeatherScreen> {
  late LocationProvider locationProvider;
  late SuggestionProvider suggestionProvider;
  late ThemeProvider themeProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      locationProvider = context.read<LocationProvider>();
      suggestionProvider = context.read<SuggestionProvider>();
      themeProvider = context.read<ThemeProvider>();
      if (locationProvider.checkLoading() == true) {
        locationProvider.fetchCurrentLocation();
      } else {
        locationProvider.getCurrentIndex();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showCitySelectionDialog(
              context,
              suggestionProvider,
              locationProvider,
            );
          },
          icon: Icon(
            Icons.search_rounded,
            color: CustomColors.primaryTextColor,
          ),
        ),
        actions: [],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Weather',
          style: TextStyle(
            color: CustomColors.primaryTextColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<LocationProvider>(
          builder: (context, provider, child) => provider.checkLoading()
              ? ListView(
                  children: [
                    SizedBox(height: 20),
                    HeaderWidgetShimmer(),
                    CurrentWeatherWidgetShimmer(),
                    SizedBox(height: 20),
                    HourlyWeatherWidgetShimmer(),
                    DailyForecastWidgetShimmer(),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                  ],
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(height: 20),
                    HeaderWidget(
                      weatherResponse: provider.weatherResponse!,
                    ),
                    CurrentWeatherWidget(
                      weatherResponse: provider.weatherResponse!,
                    ),
                    SizedBox(height: 20),
                    HourlyWeatherWidget(
                      weatherResponse: provider.weatherResponse!,
                    ),
                    DailyForecastWidget(
                      weatherResponse: provider.weatherResponse!,
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ComfortLevelWidget(
                      weatherResponse: provider.weatherResponse!,
                    ),
                  ],
                ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     locationProvider.toggleLoading();
      //     print("${locationProvider.checkLoading()}");
      //   },
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}
