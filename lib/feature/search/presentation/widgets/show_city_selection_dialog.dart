import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_app_evac_locator/feature/search/domain/usecases/fetch_query.dart';
import 'package:weather_app_evac_locator/feature/search/presentation/providers/suggestion_provider.dart';
import 'package:weather_app_evac_locator/feature/single_weather/presentation/providers/location_provider.dart';

void showCitySelectionDialog(
  BuildContext context,
  SuggestionProvider suggestionProvider,
  LocationProvider locationProvider,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Select City'),
        content: TypeAheadField(
          suggestionsCallback: (pattern) async {
            return await FetchQueryApi().fetchQuery(pattern);
          },
          builder: (context, controller, focusNode) => TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: 'Enter city name',
              border: OutlineInputBorder(),
              labelText: 'City',
            ),
          ),
          itemBuilder: (context, suggestion) {
            String cityName = suggestion['name'] ?? '';
            String stateName = suggestion['state'] ?? '';
            String countryName = suggestion['country'] ?? '';

            List<String> locationParts = [];
            if (cityName.isNotEmpty) locationParts.add(cityName);
            if (stateName.isNotEmpty) locationParts.add(stateName);
            if (countryName.isNotEmpty) locationParts.add(countryName);

            String location = locationParts.join(', ');

            return ListTile(
              title: Text(
                location,
                style: TextStyle(fontSize: 16),
              ),
            );
          },
          onSelected: (city) {
            locationProvider.isLoading = true;
            locationProvider.fetchLatLngLocation(city['lat'], city['lon']);
            Navigator.pop(context);
          },
        ),
      );
    },
  );
}
