import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/distance_kilometer_param_model.dart';

class DistanceKilometerParamEntity {
  final ServiceType serviceType;
  final String? imei;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? needHaml;

  const DistanceKilometerParamEntity({
    this.imei,
    this.startDate,
    this.endDate,
    required this.serviceType,
    this.needHaml,
  });

  DistanceKilometerParamModel toModel() {
    return DistanceKilometerParamModel(
      imei: imei,
      startDate: startDate,
      endDate: endDate,
      serviceType: serviceType,
      needHaml: needHaml,
    );
  }

  DistanceKilometerParamEntity copyWith({
    String? imei,
    DateTime? startDate,
    DateTime? endDate,
    ServiceType? serviceType,
    bool? needHaml,
  }) {
    return DistanceKilometerParamEntity(
      imei: imei ?? this.imei,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      serviceType: serviceType ?? this.serviceType,
      needHaml: needHaml ?? this.needHaml,
    );
  }
}
