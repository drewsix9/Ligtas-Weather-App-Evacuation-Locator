import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/env_config.dart';
import '../../../search/presentation/providers/suggestion_provider.dart';
import '../../../search/presentation/widgets/show_city_selection_dialog.dart';
import '../providers/location_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/comfort_level_widget.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/daily_foreacast_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/hourly_weather_widget.dart';
import '../widgets/shimmers/current_weather_widget_shimmer.dart';
import '../widgets/shimmers/daily_forecast_widget_shimmer.dart';
import '../widgets/shimmers/header_widget_shimmer.dart';
import '../widgets/shimmers/hourly_weather_widget_shimmer.dart';
import '../widgets/theme_toggle_button.dart';

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
    EnvConfig.validateEnvConfig();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      locationProvider = context.read<LocationProvider>();
      suggestionProvider = context.read<SuggestionProvider>();
      themeProvider = context.read<ThemeProvider>();
      if (locationProvider.checkLoading == true) {
        locationProvider.fetchCurrentLocation();
      } else {
        locationProvider.getCurrentIndex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final suggestionProvider = Provider.of<SuggestionProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final dividerColor = Theme.of(context).dividerColor;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 1200;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
            color: textColor,
          ),
        ),
        actions: [
          ThemeToggleButton(),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Weather',
          style: TextStyle(
            color: textColor,
            fontSize: isSmallScreen ? 20 : 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<LocationProvider>(
          builder: (context, provider, child) {
            final spacer = SizedBox(height: isSmallScreen ? 10 : 20);
            final divider = Container(
              height: 1,
              color: dividerColor,
            );

            if (provider.checkLoading) {
              return ListView(
                children: [
                  SizedBox(height: isSmallScreen ? 10 : 20),
                  HeaderWidgetShimmer(),
                  CurrentWeatherWidgetShimmer(),
                  SizedBox(height: isSmallScreen ? 10 : 20),
                  HourlyWeatherWidgetShimmer(),
                  DailyForecastWidgetShimmer(),
                ],
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    spacer,
                    HeaderWidget(
                      weatherResponse: provider.weatherResponse!,
                    ),
                    CurrentWeatherWidget(
                      weatherResponse: provider.weatherResponse!,
                    ),
                    spacer,
                    HourlyWeatherWidget(
                      weatherResponse: provider.weatherResponse!,
                    ),
                    DailyForecastWidget(
                      weatherResponse: provider.weatherResponse!,
                    ),
                    divider,
                    const SizedBox(height: 10),
                    ComfortLevelWidget(
                      weatherResponse: provider.weatherResponse!,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
