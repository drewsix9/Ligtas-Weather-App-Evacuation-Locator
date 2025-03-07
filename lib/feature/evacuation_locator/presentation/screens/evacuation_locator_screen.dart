import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_evac_locator/core/utils/custom_colors.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/presentation/providers/evacuation_locator_provider.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/presentation/widgets/build_map_widget.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/presentation/widgets/prompt_box.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<EvacuationLocatorProvider>(context, listen: false)
                  .fetchUserCoordinates();
            },
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Evacuation Locator',
          style: TextStyle(
            color: CustomColors.primaryTextColor,
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
              return Visibility(
                visible: true, // TODO: Show after implementing search
                child: Positioned.fill(
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
