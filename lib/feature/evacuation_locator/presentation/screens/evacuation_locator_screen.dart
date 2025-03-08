import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/presentation/providers/evacuation_locator_provider.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/presentation/widgets/build_map_widget.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/presentation/widgets/prompt_box.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/theme_provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/widgets/theme_toggle_button.dart';

class EvacuationLocatorScreen extends StatefulWidget {
  const EvacuationLocatorScreen({super.key});

  @override
  State<EvacuationLocatorScreen> createState() =>
      _EvacuationLocatorScreenState();
}

class _EvacuationLocatorScreenState extends State<EvacuationLocatorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isToggled;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          ThemeToggleButton(),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.refresh,
            color: textColor,
          ),
          onPressed: () {
            Provider.of<EvacuationLocatorProvider>(context, listen: false)
                .fetchUserCoordinates();
          },
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Evacuation Locator',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: BuildMapWidget(),
          ),
          Consumer<EvacuationLocatorProvider>(
            builder: (context, value, child) {
              return Positioned.fill(
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: value.loading
                        ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                        : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<EvacuationLocatorProvider>(
                builder: (context, provider, child) {
                  return Visibility(
                    visible: provider.showInitialPrompt,
                    child: PromptBox(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
