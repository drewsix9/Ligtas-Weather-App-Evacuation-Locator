import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/state_provider.dart';

class SingleWeatherScreen extends StatefulWidget {
  const SingleWeatherScreen({super.key});

  @override
  State<SingleWeatherScreen> createState() => _SingleWeatherScreenState();
}

class _SingleWeatherScreenState extends State<SingleWeatherScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<StateProvider>(context, listen: false).getLocation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
