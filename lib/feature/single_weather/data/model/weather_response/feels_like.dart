class FeelsLike {
	double? day;
	double? night;
	double? eve;
	double? morn;

	FeelsLike({this.day, this.night, this.eve, this.morn});

	@override
	String toString() {
		return 'FeelsLike(day: $day, night: $night, eve: $eve, morn: $morn)';
	}

	factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
				day: (json['day'] as num?)?.toDouble(),
				night: (json['night'] as num?)?.toDouble(),
				eve: (json['eve'] as num?)?.toDouble(),
				morn: (json['morn'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toJson() => {
				'day': day,
				'night': night,
				'eve': eve,
				'morn': morn,
			};

	FeelsLike copyWith({
		double? day,
		double? night,
		double? eve,
		double? morn,
	}) {
		return FeelsLike(
			day: day ?? this.day,
			night: night ?? this.night,
			eve: eve ?? this.eve,
			morn: morn ?? this.morn,
		);
	}
}
