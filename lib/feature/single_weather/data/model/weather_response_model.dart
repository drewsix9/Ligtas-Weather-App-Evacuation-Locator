// ignore_for_file: constant_identifier_names

import 'dart:convert';

class WeatherResponseModel {
  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  Current current;
  List<Current> hourly;
  List<Daily> daily;

  WeatherResponseModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  WeatherResponseModel copyWith({
    double? lat,
    double? lon,
    String? timezone,
    int? timezoneOffset,
    Current? current,
    List<Current>? hourly,
    List<Daily>? daily,
  }) => WeatherResponseModel(
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    timezone: timezone ?? this.timezone,
    timezoneOffset: timezoneOffset ?? this.timezoneOffset,
    current: current ?? this.current,
    hourly: hourly ?? this.hourly,
    daily: daily ?? this.daily,
  );

  factory WeatherResponseModel.fromRawJson(String str) =>
      WeatherResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) =>
      WeatherResponseModel(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: Current.fromJson(json["current"]),
        hourly: List<Current>.from(
          json["hourly"].map((x) => Current.fromJson(x)),
        ),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "timezone": timezone,
    "timezone_offset": timezoneOffset,
    "current": current.toJson(),
    "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
    "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
  };
}

class Current {
  int dt;
  int? sunrise;
  int? sunset;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  double windGust;
  List<Weather> weather;
  double? pop;
  Rain? rain;

  Current({
    required this.dt,
    this.sunrise,
    this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    this.pop,
    this.rain,
  });

  Current copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
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
  }) => Current(
    dt: dt ?? this.dt,
    sunrise: sunrise ?? this.sunrise,
    sunset: sunset ?? this.sunset,
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

  factory Current.fromRawJson(String str) => Current.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    dt: json["dt"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    temp: json["temp"]?.toDouble(),
    feelsLike: json["feels_like"]?.toDouble(),
    pressure: json["pressure"],
    humidity: json["humidity"],
    dewPoint: json["dew_point"]?.toDouble(),
    uvi: json["uvi"]?.toDouble(),
    clouds: json["clouds"],
    visibility: json["visibility"],
    windSpeed: json["wind_speed"]?.toDouble(),
    windDeg: json["wind_deg"],
    windGust: json["wind_gust"]?.toDouble(),
    weather: List<Weather>.from(
      json["weather"].map((x) => Weather.fromJson(x)),
    ),
    pop: json["pop"]?.toDouble(),
    rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "sunrise": sunrise,
    "sunset": sunset,
    "temp": temp,
    "feels_like": feelsLike,
    "pressure": pressure,
    "humidity": humidity,
    "dew_point": dewPoint,
    "uvi": uvi,
    "clouds": clouds,
    "visibility": visibility,
    "wind_speed": windSpeed,
    "wind_deg": windDeg,
    "wind_gust": windGust,
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "pop": pop,
    "rain": rain?.toJson(),
  };
}

class Rain {
  double the1H;

  Rain({required this.the1H});

  Rain copyWith({double? the1H}) => Rain(the1H: the1H ?? this.the1H);

  factory Rain.fromRawJson(String str) => Rain.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rain.fromJson(Map<String, dynamic> json) =>
      Rain(the1H: json["1h"]?.toDouble());

  Map<String, dynamic> toJson() => {"1h": the1H};
}

class Weather {
  int id;
  Main main;
  Description description;
  Icon icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  Weather copyWith({
    int? id,
    Main? main,
    Description? description,
    Icon? icon,
  }) => Weather(
    id: id ?? this.id,
    main: main ?? this.main,
    description: description ?? this.description,
    icon: icon ?? this.icon,
  );

  factory Weather.fromRawJson(String str) => Weather.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: mainValues.map[json["main"]]!,
    description: descriptionValues.map[json["description"]]!,
    icon: iconValues.map[json["icon"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": mainValues.reverse[main],
    "description": descriptionValues.reverse[description],
    "icon": iconValues.reverse[icon],
  };
}

enum Description {
  BROKEN_CLOUDS,
  HEAVY_INTENSITY_RAIN,
  LIGHT_RAIN,
  MODERATE_RAIN,
  OVERCAST_CLOUDS,
  SCATTERED_CLOUDS,
}

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "heavy intensity rain": Description.HEAVY_INTENSITY_RAIN,
  "light rain": Description.LIGHT_RAIN,
  "moderate rain": Description.MODERATE_RAIN,
  "overcast clouds": Description.OVERCAST_CLOUDS,
  "scattered clouds": Description.SCATTERED_CLOUDS,
});

enum Icon { THE_03_D, THE_04_D, THE_04_N, THE_10_D, THE_10_N }

final iconValues = EnumValues({
  "03d": Icon.THE_03_D,
  "04d": Icon.THE_04_D,
  "04n": Icon.THE_04_N,
  "10d": Icon.THE_10_D,
  "10n": Icon.THE_10_N,
});

enum Main { CLOUDS, RAIN }

final mainValues = EnumValues({"Clouds": Main.CLOUDS, "Rain": Main.RAIN});

class Daily {
  int dt;
  int sunrise;
  int sunset;
  int moonrise;
  int moonset;
  double moonPhase;
  String summary;
  Temp temp;
  FeelsLike feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double windSpeed;
  int windDeg;
  double windGust;
  List<Weather> weather;
  int clouds;
  double pop;
  double rain;
  double uvi;

  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.summary,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.rain,
    required this.uvi,
  });

  Daily copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
    int? moonrise,
    int? moonset,
    double? moonPhase,
    String? summary,
    Temp? temp,
    FeelsLike? feelsLike,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<Weather>? weather,
    int? clouds,
    double? pop,
    double? rain,
    double? uvi,
  }) => Daily(
    dt: dt ?? this.dt,
    sunrise: sunrise ?? this.sunrise,
    sunset: sunset ?? this.sunset,
    moonrise: moonrise ?? this.moonrise,
    moonset: moonset ?? this.moonset,
    moonPhase: moonPhase ?? this.moonPhase,
    summary: summary ?? this.summary,
    temp: temp ?? this.temp,
    feelsLike: feelsLike ?? this.feelsLike,
    pressure: pressure ?? this.pressure,
    humidity: humidity ?? this.humidity,
    dewPoint: dewPoint ?? this.dewPoint,
    windSpeed: windSpeed ?? this.windSpeed,
    windDeg: windDeg ?? this.windDeg,
    windGust: windGust ?? this.windGust,
    weather: weather ?? this.weather,
    clouds: clouds ?? this.clouds,
    pop: pop ?? this.pop,
    rain: rain ?? this.rain,
    uvi: uvi ?? this.uvi,
  );

  factory Daily.fromRawJson(String str) => Daily.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    dt: json["dt"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
    moonPhase: json["moon_phase"]?.toDouble(),
    summary: json["summary"],
    temp: Temp.fromJson(json["temp"]),
    feelsLike: FeelsLike.fromJson(json["feels_like"]),
    pressure: json["pressure"],
    humidity: json["humidity"],
    dewPoint: json["dew_point"]?.toDouble(),
    windSpeed: json["wind_speed"]?.toDouble(),
    windDeg: json["wind_deg"],
    windGust: json["wind_gust"]?.toDouble(),
    weather: List<Weather>.from(
      json["weather"].map((x) => Weather.fromJson(x)),
    ),
    clouds: json["clouds"],
    pop: json["pop"]?.toDouble(),
    rain: json["rain"]?.toDouble(),
    uvi: json["uvi"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "moon_phase": moonPhase,
    "summary": summary,
    "temp": temp.toJson(),
    "feels_like": feelsLike.toJson(),
    "pressure": pressure,
    "humidity": humidity,
    "dew_point": dewPoint,
    "wind_speed": windSpeed,
    "wind_deg": windDeg,
    "wind_gust": windGust,
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "clouds": clouds,
    "pop": pop,
    "rain": rain,
    "uvi": uvi,
  };
}

class FeelsLike {
  double day;
  double night;
  double eve;
  double morn;

  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  FeelsLike copyWith({double? day, double? night, double? eve, double? morn}) =>
      FeelsLike(
        day: day ?? this.day,
        night: night ?? this.night,
        eve: eve ?? this.eve,
        morn: morn ?? this.morn,
      );

  factory FeelsLike.fromRawJson(String str) =>
      FeelsLike.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
    day: json["day"]?.toDouble(),
    night: json["night"]?.toDouble(),
    eve: json["eve"]?.toDouble(),
    morn: json["morn"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "night": night,
    "eve": eve,
    "morn": morn,
  };
}

class Temp {
  double day;
  double min;
  double max;
  double night;
  double eve;
  double morn;

  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  Temp copyWith({
    double? day,
    double? min,
    double? max,
    double? night,
    double? eve,
    double? morn,
  }) => Temp(
    day: day ?? this.day,
    min: min ?? this.min,
    max: max ?? this.max,
    night: night ?? this.night,
    eve: eve ?? this.eve,
    morn: morn ?? this.morn,
  );

  factory Temp.fromRawJson(String str) => Temp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
    day: json["day"]?.toDouble(),
    min: json["min"]?.toDouble(),
    max: json["max"]?.toDouble(),
    night: json["night"]?.toDouble(),
    eve: json["eve"]?.toDouble(),
    morn: json["morn"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "min": min,
    "max": max,
    "night": night,
    "eve": eve,
    "morn": morn,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
