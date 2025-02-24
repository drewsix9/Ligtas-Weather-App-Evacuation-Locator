class Temp {
  int? day;
  int? min;
  int? max;
  int? night;
  int? eve;
  int? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  @override
  String toString() {
    return 'Temp(day: $day, min: $min, max: $max, night: $night, eve: $eve, morn: $morn)';
  }

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
    day: (json['day'] as num?)?.round(),
    min: (json['min'] as num?)?.round(),
    max: (json['max'] as num?)?.round(),
    night: (json['night'] as num?)?.round(),
    eve: (json['eve'] as num?)?.round(),
    morn: (json['morn'] as num?)?.round(),
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'min': min,
    'max': max,
    'night': night,
    'eve': eve,
    'morn': morn,
  };

  Temp copyWith({
    int? day,
    int? min,
    int? max,
    int? night,
    int? eve,
    int? morn,
  }) {
    return Temp(
      day: day ?? this.day,
      min: min ?? this.min,
      max: max ?? this.max,
      night: night ?? this.night,
      eve: eve ?? this.eve,
      morn: morn ?? this.morn,
    );
  }
}
