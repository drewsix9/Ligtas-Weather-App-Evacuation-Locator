import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../single_weather/presentation/widgets/theme_toggle_button.dart';
import '../providers/evacuation_locator_provider.dart';
import '../widgets/build_map_widget.dart';
import '../widgets/prompt_box.dart';

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
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 1200;

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
            size: isSmallScreen ? 20 : 24,
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
            fontSize: isSmallScreen ? 18 : 20,
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
                    padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
                    margin: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 20 : 30,
                    ),
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
                        SizedBox(height: isSmallScreen ? 15 : 20),
                        Text(
                          'Finding optimal evacuation route...',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isSmallScreen ? 6 : 8),
                        Text(
                          'Analyzing closest centers',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                          textAlign: TextAlign.center,
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
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
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
