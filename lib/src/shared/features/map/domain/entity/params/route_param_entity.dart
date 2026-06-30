import 'package:eks_sana_plus_org/src/shared/features/map/data/models/param/route_param_model.dart';

class RouteParamEntity {
  final LocationParamEntity? start;
  final LocationParamEntity? destination;
  final bool includeLegs;
  final bool includeStepsPoints;

  RouteParamEntity({
    this.destination,
    required this.start,
    required this.includeLegs,
    required this.includeStepsPoints,
  });

  RouteParamEntity copyWith({
    LocationParamEntity? start,
    LocationParamEntity? destination,
    bool? includeLegs,
    bool? includeStepsPoints,
  }) {
    return RouteParamEntity(
      start: start ?? this.start,
      destination: destination ?? this.destination,
      includeLegs: includeLegs ?? this.includeLegs,
      includeStepsPoints: includeStepsPoints ?? this.includeStepsPoints,
    );
  }

  RouteParamModel toModel() {
    return RouteParamModel(
      start: start?.toModel(),
      destination: destination?.toModel(),
      includeLegs: includeLegs,
      includeStepsPoints: includeStepsPoints,
    );
  }
}

class LocationParamEntity {
  final double latitude;
  final double longitude;

  LocationParamEntity({
    required this.latitude,
    required this.longitude,
  });

  LocationParamEntity copyWith({
    double? latitude,
    double? longitude,
  }) {
    return LocationParamEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  LocationParamModel toModel() {
    return LocationParamModel(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
