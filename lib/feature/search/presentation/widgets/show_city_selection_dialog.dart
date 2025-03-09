import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/custom_colors.dart';
import '../../../single_weather/presentation/providers/location_provider.dart';
import '../../../single_weather/presentation/providers/theme_provider.dart';
import '../../data/services/fetch_query.dart';
import '../providers/suggestion_provider.dart';

void showCitySelectionDialog(
  BuildContext context,
  SuggestionProvider suggestionProvider,
  LocationProvider locationProvider,
) {
  final isDarkMode =
      Provider.of<ThemeProvider>(context, listen: false).isToggled;

  // Use theme-aware colors
  final cardBgColor = Theme.of(context).cardColor;
  final textColor = Theme.of(context).textTheme.bodyLarge?.color;
  final dividerColor = Theme.of(context).dividerColor;

  // Use appropriate gradient colors based on theme
  final gradientStartColor = isDarkMode
      ? CustomDarkColors.firstGradientColor
      : CustomColors.firstGradientColor;
  final gradientEndColor = isDarkMode
      ? CustomDarkColors.secondGradientColor
      : CustomColors.secondGradientColor;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 8,
        backgroundColor: cardBgColor,
        title: Row(
          children: [
            Icon(
              Icons.location_city,
              color: gradientStartColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'Search City',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          constraints: const BoxConstraints(maxWidth: 400),
          child: TypeAheadField(
            animationDuration: const Duration(milliseconds: 300),
            decorationBuilder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.black.withOpacity(0.3)
                      : Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: dividerColor,
                    width: 1.5,
                  ),
                ),
                child: child,
              );
            },
            debounceDuration: const Duration(milliseconds: 300),
            suggestionsCallback: (pattern) async {
              if (pattern.length < 2) return [];
              return await FetchQueryApi().fetchQuery(pattern);
            },
            builder: (context, controller, focusNode) => TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                hintStyle: TextStyle(color: textColor?.withOpacity(0.6)),
                prefixIcon: Icon(
                  Icons.search,
                  color: gradientStartColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: dividerColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: gradientStartColor,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: cardBgColor.withOpacity(0.7),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            // loadingBuilder: (context) => Center(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 16),
            //     child: CircularProgressIndicator(
            //       valueColor: AlwaysStoppedAnimation<Color>(gradientStartColor),
            //     ),
            //   ),
            // ),
            itemBuilder: (context, suggestion) {
              String cityName = suggestion['name'] ?? '';
              String stateName = suggestion['state'] ?? '';
              String countryName = suggestion['country'] ?? '';

              List<String> locationParts = [];
              if (cityName.isNotEmpty) locationParts.add(cityName);
              if (stateName.isNotEmpty) locationParts.add(stateName);
              if (countryName.isNotEmpty) locationParts.add(countryName);

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: Icon(Icons.place, color: gradientEndColor),
                title: Text(
                  cityName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                subtitle: Text(
                  [stateName, countryName]
                      .where((e) => e.isNotEmpty)
                      .join(', '),
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor?.withOpacity(0.7),
                  ),
                ),
                tileColor: isDarkMode ? Colors.grey[800] : Colors.grey[50],
                hoverColor: gradientStartColor.withOpacity(0.1),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(8),
                // ),
              );
            },
            onSelected: (city) {
              locationProvider.isLoading = true;
              locationProvider.fetchLatLngLocation(city['lat'], city['lon']);
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
