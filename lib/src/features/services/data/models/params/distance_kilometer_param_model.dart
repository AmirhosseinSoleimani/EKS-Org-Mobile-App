import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/distance_kilometer_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';

class DistanceKilometerParamModel extends DistanceKilometerParamEntity {
  const DistanceKilometerParamModel({
    required super.serviceType,
    super.imei,
    super.startDate,
    super.endDate,
    super.needHaml,
  });

  factory DistanceKilometerParamModel.fromJson(Map<String, dynamic> json) {
    return DistanceKilometerParamModel(
      imei: json['imei'] as String?,
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'])
          : null,
      endDate:
          json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
      serviceType: ServiceType.fromValue(json['serviceType'] as int?),
      needHaml: json['needHaml'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imei': imei,
      'startDate': JalaliDateHelper.formatServerDateTime(startDate),
      'endDate': JalaliDateHelper.formatServerDateTime(endDate),
      'serviceType': serviceType.value,
      'needHaml': needHaml,
    };
  }
}
