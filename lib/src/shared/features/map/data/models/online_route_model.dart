import 'package:eks_sana_plus_org/src/shared/features/map/data/models/location_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';

class RouteDataModel extends RouteDataEntity {
  RouteDataModel({
    required List<RouteModel> routes,
  }) : super(routes: routes);

  factory RouteDataModel.fromJson(Map<String, dynamic> json) {
    return RouteDataModel(
      routes: (json["routes"] as List)
          .map((e) => RouteModel.fromJson(e))
          .toList(),
    );
  }
}

class RouteModel extends RouteEntity {
  RouteModel({
    required List<LegModel> legs,
    required DistanceDurationModel distance,
    required DistanceDurationModel duration,
    required LocationModel start,
    required LocationModel destination,
  }) : super(
    legs: legs,
    distance: distance,
    duration: duration,
    start: start,
    destination: destination,
  );

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      legs: (json["legs"] as List).map((e) => LegModel.fromJson(e)).toList(),
      distance: DistanceDurationModel.fromJson(json["distance"]),
      duration: DistanceDurationModel.fromJson(json["duration"]),
      start: LocationModel.fromJson(json["start"]),
      destination: LocationModel.fromJson(json["destination"]),
    );
  }
}

class LegModel extends LegEntity {
  LegModel({
    required List<StepModel> steps,
    required DistanceDurationModel distance,
    required DistanceDurationModel duration,
    required LocationModel start,
    required LocationModel destination,
  }) : super(
    steps: steps,
    distance: distance,
    duration: duration,
    start: start,
    destination: destination,
  );

  factory LegModel.fromJson(Map<String, dynamic> json) {
    return LegModel(
      steps:
      (json["steps"] as List).map((e) => StepModel.fromJson(e)).toList(),
      distance: DistanceDurationModel.fromJson(json["distance"]),
      duration: DistanceDurationModel.fromJson(json["duration"]),
      start: LocationModel.fromJson(json["start"]),
      destination: LocationModel.fromJson(json["destination"]),
    );
  }
}

class StepModel extends StepEntity {
  StepModel({
    required List<List<double>> points,
    required String travelMode,
    required double traffic,
    required DistanceDurationModel distance,
    required DistanceDurationModel duration,
    required LocationModel start,
    required LocationModel destination,
  }) : super(
    points: points,
    travelMode: travelMode,
    traffic: traffic,
    distance: distance,
    duration: duration,
    start: start,
    destination: destination,
  );

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      points:
      (json["points"] as List).map((e) => (e as List).cast<double>()).toList(),
      travelMode: json["travelMode"],
      traffic: (json["traffic"] as num).toDouble(),
      distance: DistanceDurationModel.fromJson(json["distance"]),
      duration: DistanceDurationModel.fromJson(json["duration"]),
      start: LocationModel.fromJson(json["start"]),
      destination: LocationModel.fromJson(json["destination"]),
    );
  }
}

class DistanceDurationModel extends DistanceDurationEntity {
  DistanceDurationModel({
    required super.text,
    required super.value,
  });

  factory DistanceDurationModel.fromJson(Map<String, dynamic> json) {
    return DistanceDurationModel(
      text: json["text"],
      value: (json["value"] as num).toDouble(),
    );
  }
}
