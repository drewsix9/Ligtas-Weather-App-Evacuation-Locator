class Temp {
	double? day;
	double? min;
	double? max;
	double? night;
	double? eve;
	double? morn;

	Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

	@override
	String toString() {
		return 'Temp(day: $day, min: $min, max: $max, night: $night, eve: $eve, morn: $morn)';
	}

	factory Temp.fromJson(Map<String, dynamic> json) => Temp(
				day: (json['day'] as num?)?.toDouble(),
				min: (json['min'] as num?)?.toDouble(),
				max: (json['max'] as num?)?.toDouble(),
				night: (json['night'] as num?)?.toDouble(),
				eve: (json['eve'] as num?)?.toDouble(),
				morn: (json['morn'] as num?)?.toDouble(),
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
		double? day,
		double? min,
		double? max,
		double? night,
		double? eve,
		double? morn,
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
