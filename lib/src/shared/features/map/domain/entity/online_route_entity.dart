import 'package:eks_sana_plus_org/src/shared/features/map/data/models/online_route_model.dart';

class RouteDataEntity {
  final List<RouteEntity> routes;

  RouteDataEntity({
    required this.routes,
  });

  RouteDataEntity copyWith({
    List<RouteEntity>? routes,
  }) {
    return RouteDataEntity(
      routes: routes ?? this.routes,
    );
  }

  RouteDataModel toModel() {
    return RouteDataModel(
      routes: routes.map((e) => e.toModel()).toList(),
    );
  }
}

class RouteEntity {
  final List<LegEntity> legs;
  final DistanceDurationEntity distance;
  final DistanceDurationEntity duration;
  final LocationEntity start;
  final LocationEntity destination;

  RouteEntity({
    required this.legs,
    required this.distance,
    required this.duration,
    required this.start,
    required this.destination,
  });

  RouteEntity copyWith({
    List<LegEntity>? legs,
    DistanceDurationEntity? distance,
    DistanceDurationEntity? duration,
    LocationEntity? start,
    LocationEntity? destination,
  }) {
    return RouteEntity(
      legs: legs ?? this.legs,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      start: start ?? this.start,
      destination: destination ?? this.destination,
    );
  }

  RouteModel toModel() {
    return RouteModel(
      legs: legs.map((e) => e.toModel()).toList(),
      distance: distance.toModel(),
      duration: duration.toModel(),
      start: start.toModel(),
      destination: destination.toModel(),
    );
  }
}

class LegEntity {
  final List<StepEntity> steps;
  final DistanceDurationEntity distance;
  final DistanceDurationEntity duration;
  final LocationEntity start;
  final LocationEntity destination;

  LegEntity({
    required this.steps,
    required this.distance,
    required this.duration,
    required this.start,
    required this.destination,
  });

  LegEntity copyWith({
    List<StepEntity>? steps,
    DistanceDurationEntity? distance,
    DistanceDurationEntity? duration,
    LocationEntity? start,
    LocationEntity? destination,
  }) {
    return LegEntity(
      steps: steps ?? this.steps,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      start: start ?? this.start,
      destination: destination ?? this.destination,
    );
  }

  LegModel toModel() {
    return LegModel(
      steps: steps.map((e) => e.toModel()).toList(),
      distance: distance.toModel(),
      duration: duration.toModel(),
      start: start.toModel(),
      destination: destination.toModel(),
    );
  }
}

class StepEntity {
  final List<List<double>> points;
  final String travelMode;
  final double traffic;
  final DistanceDurationEntity distance;
  final DistanceDurationEntity duration;
  final LocationEntity start;
  final LocationEntity destination;

  StepEntity({
    required this.points,
    required this.travelMode,
    required this.traffic,
    required this.distance,
    required this.duration,
    required this.start,
    required this.destination,
  });

  StepEntity copyWith({
    List<List<double>>? points,
    String? travelMode,
    double? traffic,
    DistanceDurationEntity? distance,
    DistanceDurationEntity? duration,
    LocationEntity? start,
    LocationEntity? destination,
  }) {
    return StepEntity(
      points: points ?? this.points,
      travelMode: travelMode ?? this.travelMode,
      traffic: traffic ?? this.traffic,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      start: start ?? this.start,
      destination: destination ?? this.destination,
    );
  }

  StepModel toModel() {
    return StepModel(
      points: points,
      travelMode: travelMode,
      traffic: traffic,
      distance: distance.toModel(),
      duration: duration.toModel(),
      start: start.toModel(),
      destination: destination.toModel(),
    );
  }
}

class DistanceDurationEntity {
  final String text;
  final double value;

  DistanceDurationEntity({
    required this.text,
    required this.value,
  });

  DistanceDurationEntity copyWith({
    String? text,
    double? value,
  }) {
    return DistanceDurationEntity(
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }

  DistanceDurationModel toModel() {
    return DistanceDurationModel(
      text: text,
      value: value,
    );
  }
}

class LocationEntity {
  final double latitude;
  final double longitude;

  LocationEntity({
    required this.latitude,
    required this.longitude,
  });

  LocationEntity copyWith({
    double? latitude,
    double? longitude,
  }) {
    return LocationEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  LocationModel toModel() {
    return LocationModel(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
