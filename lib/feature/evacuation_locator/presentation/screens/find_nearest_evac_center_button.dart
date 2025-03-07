import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/evacuation_locator_provider.dart';

class FindNearestEvacCenterButton extends StatelessWidget {
  const FindNearestEvacCenterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.location_on,
        size: 24,
        color: Colors.white,
      ),
      label: const Text('FIND NEAREST CENTER'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
      onPressed: () {
        onClickFindNearestEvacCenter(context);
      },
    );
  }
}

void onClickFindNearestEvacCenter(BuildContext context) {
  final provider =
      Provider.of<EvacuationLocatorProvider>(context, listen: false);
  provider.hideInitialPrompt();
  provider.fetchUserCoordinates();
}
