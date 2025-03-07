import 'package:flutter/material.dart';
import 'package:weather_app_evac_locator/feature/evacuation_locator/presentation/screens/find_nearest_evac_center_button.dart';

class PromptBox extends StatelessWidget {
  const PromptBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Emergency Evacuation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Find the nearest evacuation center during emergencies.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: FindNearestEvacCenterButton(),
            ),
          ],
        ),
      ),
    );
  }
}
