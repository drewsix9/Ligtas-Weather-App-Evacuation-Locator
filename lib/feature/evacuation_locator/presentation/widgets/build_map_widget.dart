import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../../../core/const/coordinates.dart';
import '../providers/evacuation_locator_provider.dart';

class BuildMapWidget extends StatefulWidget {
  const BuildMapWidget({super.key});

  @override
  State<BuildMapWidget> createState() => _BuildMapWidgetState();
}

class _BuildMapWidgetState extends State<BuildMapWidget> {
  @override
  Widget build(BuildContext context) {
    final evacProvider = context.watch<EvacuationLocatorProvider>();
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final initialZoom = isSmallScreen ? 8.5 : 9.2;

    return Stack(
      children: [
        FlutterMap(
          mapController: evacProvider.mapController,
          options: MapOptions(
            onMapReady: () {
              context.read<EvacuationLocatorProvider>().setMapControllerReady();
            },
            interactionOptions: InteractionOptions(
              flags: InteractiveFlag.pinchZoom |
                  InteractiveFlag.doubleTapZoom |
                  InteractiveFlag.drag,
              pinchZoomThreshold: isSmallScreen ? 0.5 : 1.0,
            ),
            initialCenter: boholLatLng,
            initialZoom: initialZoom,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              tileProvider: NetworkTileProvider(),
              maxZoom: 18,
              minZoom: 4,
            ),
            if (evacProvider.points.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: evacProvider.points,
                    strokeWidth: isSmallScreen ? 3 : 5,
                    color: Colors.green,
                  ),
                ],
              ),
            Consumer<EvacuationLocatorProvider>(
              builder: (context, provider, child) => MarkerLayer(
                markers: provider.markers,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
