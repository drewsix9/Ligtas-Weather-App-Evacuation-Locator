import 'current.dart';
import 'daily.dart';
import 'hourly.dart';

class WeatherResponse {
	double? lat;
	double? lon;
	String? timezone;
	int? timezoneOffset;
	Current? current;
	List<Hourly>? hourly;
	List<Daily>? daily;

	WeatherResponse({
		this.lat, 
		this.lon, 
		this.timezone, 
		this.timezoneOffset, 
		this.current, 
		this.hourly, 
		this.daily, 
	});

	@override
	String toString() {
		return 'WeatherResponse(lat: $lat, lon: $lon, timezone: $timezone, timezoneOffset: $timezoneOffset, current: $current, hourly: $hourly, daily: $daily)';
	}

	factory WeatherResponse.fromJson(Map<String, dynamic> json) {
		return WeatherResponse(
			lat: (json['lat'] as num?)?.toDouble(),
			lon: (json['lon'] as num?)?.toDouble(),
			timezone: json['timezone'] as String?,
			timezoneOffset: json['timezone_offset'] as int?,
			current: json['current'] == null
						? null
						: Current.fromJson(json['current'] as Map<String, dynamic>),
			hourly: (json['hourly'] as List<dynamic>?)
						?.map((e) => Hourly.fromJson(e as Map<String, dynamic>))
						.toList(),
			daily: (json['daily'] as List<dynamic>?)
						?.map((e) => Daily.fromJson(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toJson() => {
				'lat': lat,
				'lon': lon,
				'timezone': timezone,
				'timezone_offset': timezoneOffset,
				'current': current?.toJson(),
				'hourly': hourly?.map((e) => e.toJson()).toList(),
				'daily': daily?.map((e) => e.toJson()).toList(),
			};

	WeatherResponse copyWith({
		double? lat,
		double? lon,
		String? timezone,
		int? timezoneOffset,
		Current? current,
		List<Hourly>? hourly,
		List<Daily>? daily,
	}) {
		return WeatherResponse(
			lat: lat ?? this.lat,
			lon: lon ?? this.lon,
			timezone: timezone ?? this.timezone,
			timezoneOffset: timezoneOffset ?? this.timezoneOffset,
			current: current ?? this.current,
			hourly: hourly ?? this.hourly,
			daily: daily ?? this.daily,
		);
	}
}
