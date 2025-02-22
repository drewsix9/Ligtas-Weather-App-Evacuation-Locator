import 'rain.dart';
import 'weather.dart';

class Hourly {
	int? dt;
	double? temp;
	double? feelsLike;
	int? pressure;
	int? humidity;
	double? dewPoint;
	double? uvi;
	int? clouds;
	int? visibility;
	double? windSpeed;
	int? windDeg;
	double? windGust;
	List<Weather>? weather;
	double? pop;
	Rain? rain;

	Hourly({
		this.dt, 
		this.temp, 
		this.feelsLike, 
		this.pressure, 
		this.humidity, 
		this.dewPoint, 
		this.uvi, 
		this.clouds, 
		this.visibility, 
		this.windSpeed, 
		this.windDeg, 
		this.windGust, 
		this.weather, 
		this.pop, 
		this.rain, 
	});

	@override
	String toString() {
		return 'Hourly(dt: $dt, temp: $temp, feelsLike: $feelsLike, pressure: $pressure, humidity: $humidity, dewPoint: $dewPoint, uvi: $uvi, clouds: $clouds, visibility: $visibility, windSpeed: $windSpeed, windDeg: $windDeg, windGust: $windGust, weather: $weather, pop: $pop, rain: $rain)';
	}

	factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
				dt: json['dt'] as int?,
				temp: (json['temp'] as num?)?.toDouble(),
				feelsLike: (json['feels_like'] as num?)?.toDouble(),
				pressure: json['pressure'] as int?,
				humidity: json['humidity'] as int?,
				dewPoint: (json['dew_point'] as num?)?.toDouble(),
				uvi: (json['uvi'] as num?)?.toDouble(),
				clouds: json['clouds'] as int?,
				visibility: json['visibility'] as int?,
				windSpeed: (json['wind_speed'] as num?)?.toDouble(),
				windDeg: json['wind_deg'] as int?,
				windGust: (json['wind_gust'] as num?)?.toDouble(),
				weather: (json['weather'] as List<dynamic>?)
						?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
						.toList(),
				pop: (json['pop'] as num?)?.toDouble(),
				rain: json['rain'] == null
						? null
						: Rain.fromJson(json['rain'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'dt': dt,
				'temp': temp,
				'feels_like': feelsLike,
				'pressure': pressure,
				'humidity': humidity,
				'dew_point': dewPoint,
				'uvi': uvi,
				'clouds': clouds,
				'visibility': visibility,
				'wind_speed': windSpeed,
				'wind_deg': windDeg,
				'wind_gust': windGust,
				'weather': weather?.map((e) => e.toJson()).toList(),
				'pop': pop,
				'rain': rain?.toJson(),
			};

	Hourly copyWith({
		int? dt,
		double? temp,
		double? feelsLike,
		int? pressure,
		int? humidity,
		double? dewPoint,
		double? uvi,
		int? clouds,
		int? visibility,
		double? windSpeed,
		int? windDeg,
		double? windGust,
		List<Weather>? weather,
		double? pop,
		Rain? rain,
	}) {
		return Hourly(
			dt: dt ?? this.dt,
			temp: temp ?? this.temp,
			feelsLike: feelsLike ?? this.feelsLike,
			pressure: pressure ?? this.pressure,
			humidity: humidity ?? this.humidity,
			dewPoint: dewPoint ?? this.dewPoint,
			uvi: uvi ?? this.uvi,
			clouds: clouds ?? this.clouds,
			visibility: visibility ?? this.visibility,
			windSpeed: windSpeed ?? this.windSpeed,
			windDeg: windDeg ?? this.windDeg,
			windGust: windGust ?? this.windGust,
			weather: weather ?? this.weather,
			pop: pop ?? this.pop,
			rain: rain ?? this.rain,
		);
	}
}
