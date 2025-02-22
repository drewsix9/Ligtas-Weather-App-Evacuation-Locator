import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/location_provider.dart';
import '../widgets/header_widget.dart';

class SingleWeatherScreen extends StatefulWidget {
  const SingleWeatherScreen({super.key});

  @override
  State<SingleWeatherScreen> createState() => _SingleWeatherScreenState();
}

class _SingleWeatherScreenState extends State<SingleWeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationProvider>().getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LocationProvider>(
          builder:
              (context, provider, child) =>
                  provider.checkLoading()
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(
                        scrollDirection: Axis.vertical,
                        children: [SizedBox(height: 20), HeaderWidget()],
                      ),
        ),
      ),
    );
  }
}
