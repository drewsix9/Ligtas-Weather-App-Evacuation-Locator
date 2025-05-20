import 'package:flutter/material.dart';

import '../screens/find_nearest_evac_center_button.dart';

class PromptBox extends StatelessWidget {
  const PromptBox({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Emergency Evacuation',
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isSmallScreen ? 6 : 8),
            Text(
              'Find the nearest evacuation center during emergencies.',
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
              ),
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),
            Center(
              child: FindNearestEvacCenterButton(),
            ),
          ],
        ),
      ),
    );
  }
}
