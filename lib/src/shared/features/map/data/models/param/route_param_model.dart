import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/params/route_param_entity.dart';


class RouteParamModel extends RouteParamEntity {
  RouteParamModel({
    required LocationParamModel super.start,
    required LocationParamModel super.destination,
    required super.includeLegs,
    required super.includeStepsPoints,
  });

  factory RouteParamModel.fromJson(Map<String, dynamic> json) {
    return RouteParamModel(
      start: LocationParamModel.fromJson(json['start']),
      destination: LocationParamModel.fromJson(json['destination']),
      includeLegs: json['includeLegs'] ?? false,
      includeStepsPoints: json['includeStepsPoints'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "start": (start as LocationParamModel).toJson(),
      "destination": (destination as LocationParamModel).toJson(),
      "includeLegs": includeLegs,
      "includeStepsPoints": includeStepsPoints,
    };
  }
}

class LocationParamModel extends LocationParamEntity {
  LocationParamModel({
    required super.latitude,
    required super.longitude,
  });

  factory LocationParamModel.fromJson(Map<String, dynamic> json) {
    return LocationParamModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
