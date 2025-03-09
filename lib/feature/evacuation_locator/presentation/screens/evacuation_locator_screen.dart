import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/presentation/providers/evacuation_locator_provider.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/presentation/widgets/build_map_widget.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/presentation/widgets/prompt_box.dart';
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
            builder: (context, provider, child) {
              // Show blur when either loading or processing routes
              final shouldBlur =
                  provider.loading || provider.isProcessingRoutes;
              return Positioned.fill(
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: shouldBlur
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
          // Progress indicator and message for route processing
          Consumer<EvacuationLocatorProvider>(
            builder: (context, provider, child) {
              if (provider.isProcessingRoutes) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          value: provider.processProgress > 0
                              ? provider.processProgress
                              : null,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Finding optimal evacuation route...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Analyzing closest centers',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
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
