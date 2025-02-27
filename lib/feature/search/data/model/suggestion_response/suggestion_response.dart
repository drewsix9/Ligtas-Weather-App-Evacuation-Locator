class SuggestionResponse {
  String? name;
  double? lat;
  double? lon;
  String? country;
  String? state;

  SuggestionResponse({
    this.name,
    this.lat,
    this.lon,
    this.country,
    this.state,
  });

  @override
  String toString() {
    return 'SuggestionResponse(name: $name, lat: $lat, lon: $lon, country: $country, state: $state)';
  }

  factory SuggestionResponse.fromJson(Map<String, dynamic> json) {
    return SuggestionResponse(
      name: json['name'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      country: json['country'] as String?,
      state: json['state'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'lat': lat,
        'lon': lon,
        'country': country,
        'state': state,
      };

  SuggestionResponse copyWith({
    String? name,
    double? lat,
    double? lon,
    String? country,
    String? state,
  }) {
    return SuggestionResponse(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      country: country ?? this.country,
      state: state ?? this.state,
    );
  }
}
