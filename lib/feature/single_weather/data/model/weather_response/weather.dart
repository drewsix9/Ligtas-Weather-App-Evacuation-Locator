class Weather {
	int? id;
	String? main;
	String? description;
	String? icon;

	Weather({this.id, this.main, this.description, this.icon});

	@override
	String toString() {
		return 'Weather(id: $id, main: $main, description: $description, icon: $icon)';
	}

	factory Weather.fromJson(Map<String, dynamic> json) => Weather(
				id: json['id'] as int?,
				main: json['main'] as String?,
				description: json['description'] as String?,
				icon: json['icon'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'main': main,
				'description': description,
				'icon': icon,
			};

	Weather copyWith({
		int? id,
		String? main,
		String? description,
		String? icon,
	}) {
		return Weather(
			id: id ?? this.id,
			main: main ?? this.main,
			description: description ?? this.description,
			icon: icon ?? this.icon,
		);
	}
}
