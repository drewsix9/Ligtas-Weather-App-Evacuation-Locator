class EvacuationCenterModel {
  final String name;
  final String municipality;
  final double latitude;
  final double longitude;

  EvacuationCenterModel({
    required this.name,
    required this.municipality,
    required this.latitude,
    required this.longitude,
  });

  String toJson() {
    return '''
    {
      "name": "$name",
      "municipality": "$municipality",
      "latitude": $latitude,
      "longitude": $longitude
    }
    ''';
  }
}
