import 'dart:convert';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

class RouteResponseModel {
  String type;
  List<double> bbox;
  List<Feature> features;
  Metadata metadata;

  RouteResponseModel({
    required this.type,
    required this.bbox,
    required this.features,
    required this.metadata,
  });

  RouteResponseModel copyWith({
    String? type,
    List<double>? bbox,
    List<Feature>? features,
    Metadata? metadata,
  }) =>
      RouteResponseModel(
        type: type ?? this.type,
        bbox: bbox ?? this.bbox,
        features: features ?? this.features,
        metadata: metadata ?? this.metadata,
      );

  factory RouteResponseModel.fromRawJson(String str) =>
      RouteResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RouteResponseModel.fromJson(Map<String, dynamic> json) =>
      RouteResponseModel(
        type: json["type"],
        bbox: List<double>.from(json["bbox"].map((x) => x?.toDouble())),
        features: List<Feature>.from(
          json["features"].map((x) => Feature.fromJson(x)),
        ),
        metadata: Metadata.fromJson(json["metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "bbox": List<dynamic>.from(bbox.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "metadata": metadata.toJson(),
      };

  LatLngBounds toLatLngBounds() => LatLngBounds(
        latlng.LatLng(bbox[1], bbox[0]),
        latlng.LatLng(bbox[3], bbox[2]),
      );
}

class Feature {
  List<double> bbox;
  String type;
  Properties properties;
  Geometry geometry;

  Feature({
    required this.bbox,
    required this.type,
    required this.properties,
    required this.geometry,
  });

  Feature copyWith({
    List<double>? bbox,
    String? type,
    Properties? properties,
    Geometry? geometry,
  }) =>
      Feature(
        bbox: bbox ?? this.bbox,
        type: type ?? this.type,
        properties: properties ?? this.properties,
        geometry: geometry ?? this.geometry,
      );

  factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        bbox: List<double>.from(json["bbox"].map((x) => x?.toDouble())),
        type: json["type"],
        properties: Properties.fromJson(json["properties"]),
        geometry: Geometry.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "bbox": List<dynamic>.from(bbox.map((x) => x)),
        "type": type,
        "properties": properties.toJson(),
        "geometry": geometry.toJson(),
      };
}

class Geometry {
  List<List<double>> coordinates;
  String type;

  Geometry({
    required this.coordinates,
    required this.type,
  });

  Geometry copyWith({
    List<List<double>>? coordinates,
    String? type,
  }) =>
      Geometry(
        coordinates: coordinates ?? this.coordinates,
        type: type ?? this.type,
      );

  factory Geometry.fromRawJson(String str) =>
      Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<List<double>>.from(
          json["coordinates"]
              .map((x) => List<double>.from(x.map((x) => x?.toDouble()))),
        ),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(
          coordinates.map((x) => List<dynamic>.from(x.map((x) => x))),
        ),
        "type": type,
      };
}

class Properties {
  List<Segment> segments;
  List<int> wayPoints;
  Summary summary;

  Properties({
    required this.segments,
    required this.wayPoints,
    required this.summary,
  });

  Properties copyWith({
    List<Segment>? segments,
    List<int>? wayPoints,
    Summary? summary,
  }) =>
      Properties(
        segments: segments ?? this.segments,
        wayPoints: wayPoints ?? this.wayPoints,
        summary: summary ?? this.summary,
      );

  factory Properties.fromRawJson(String str) =>
      Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        segments: List<Segment>.from(
          json["segments"].map((x) => Segment.fromJson(x)),
        ),
        wayPoints: List<int>.from(json["way_points"].map((x) => x)),
        summary: Summary.fromJson(json["summary"]),
      );

  Map<String, dynamic> toJson() => {
        "segments": List<dynamic>.from(segments.map((x) => x.toJson())),
        "way_points": List<dynamic>.from(wayPoints.map((x) => x)),
        "summary": summary.toJson(),
      };
}

class Segment {
  double distance;
  double duration;
  List<Step> steps;

  Segment({
    required this.distance,
    required this.duration,
    required this.steps,
  });

  Segment copyWith({
    double? distance,
    double? duration,
    List<Step>? steps,
  }) =>
      Segment(
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
        steps: steps ?? this.steps,
      );

  factory Segment.fromRawJson(String str) => Segment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "duration": duration,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
      };
}

class Step {
  double distance;
  double duration;
  int type;
  String instruction;
  String name;
  List<int> wayPoints;

  Step({
    required this.distance,
    required this.duration,
    required this.type,
    required this.instruction,
    required this.name,
    required this.wayPoints,
  });

  Step copyWith({
    double? distance,
    double? duration,
    int? type,
    String? instruction,
    String? name,
    List<int>? wayPoints,
  }) =>
      Step(
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
        type: type ?? this.type,
        instruction: instruction ?? this.instruction,
        name: name ?? this.name,
        wayPoints: wayPoints ?? this.wayPoints,
      );

  factory Step.fromRawJson(String str) => Step.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        type: json["type"],
        instruction: json["instruction"],
        name: json["name"],
        wayPoints: List<int>.from(json["way_points"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "duration": duration,
        "type": type,
        "instruction": instruction,
        "name": name,
        "way_points": List<dynamic>.from(wayPoints.map((x) => x)),
      };
}

class Summary {
  double distance;
  double duration;

  Summary({
    required this.distance,
    required this.duration,
  });

  Summary copyWith({
    double? distance,
    double? duration,
  }) =>
      Summary(
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
      );

  factory Summary.fromRawJson(String str) => Summary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "duration": duration,
      };
}

class Metadata {
  String attribution;
  String service;
  int timestamp;
  Query query;
  Engine engine;

  Metadata({
    required this.attribution,
    required this.service,
    required this.timestamp,
    required this.query,
    required this.engine,
  });

  Metadata copyWith({
    String? attribution,
    String? service,
    int? timestamp,
    Query? query,
    Engine? engine,
  }) =>
      Metadata(
        attribution: attribution ?? this.attribution,
        service: service ?? this.service,
        timestamp: timestamp ?? this.timestamp,
        query: query ?? this.query,
        engine: engine ?? this.engine,
      );

  factory Metadata.fromRawJson(String str) =>
      Metadata.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        attribution: json["attribution"],
        service: json["service"],
        timestamp: json["timestamp"],
        query: Query.fromJson(json["query"]),
        engine: Engine.fromJson(json["engine"]),
      );

  Map<String, dynamic> toJson() => {
        "attribution": attribution,
        "service": service,
        "timestamp": timestamp,
        "query": query.toJson(),
        "engine": engine.toJson(),
      };
}

class Engine {
  String version;
  DateTime buildDate;
  DateTime graphDate;

  Engine({
    required this.version,
    required this.buildDate,
    required this.graphDate,
  });

  Engine copyWith({
    String? version,
    DateTime? buildDate,
    DateTime? graphDate,
  }) =>
      Engine(
        version: version ?? this.version,
        buildDate: buildDate ?? this.buildDate,
        graphDate: graphDate ?? this.graphDate,
      );

  factory Engine.fromRawJson(String str) => Engine.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Engine.fromJson(Map<String, dynamic> json) => Engine(
        version: json["version"],
        buildDate: DateTime.parse(json["build_date"]),
        graphDate: DateTime.parse(json["graph_date"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "build_date": buildDate.toIso8601String(),
        "graph_date": graphDate.toIso8601String(),
      };
}

class Query {
  List<List<double>> coordinates;
  String profile;
  String profileName;
  String format;

  Query({
    required this.coordinates,
    required this.profile,
    required this.profileName,
    required this.format,
  });

  Query copyWith({
    List<List<double>>? coordinates,
    String? profile,
    String? profileName,
    String? format,
  }) =>
      Query(
        coordinates: coordinates ?? this.coordinates,
        profile: profile ?? this.profile,
        profileName: profileName ?? this.profileName,
        format: format ?? this.format,
      );

  factory Query.fromRawJson(String str) => Query.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        coordinates: List<List<double>>.from(
          json["coordinates"]
              .map((x) => List<double>.from(x.map((x) => x?.toDouble()))),
        ),
        profile: json["profile"],
        profileName: json["profileName"],
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(
          coordinates.map((x) => List<dynamic>.from(x.map((x) => x))),
        ),
        "profile": profile,
        "profileName": profileName,
        "format": format,
      };
}
