import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/distance_kilometer_param_entity.dart';

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
      startDate: json['startDate'] != null ? DateTime.tryParse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
      serviceType: ServiceType.fromValue(json['serviceType'] as int?),
      needHaml: json['needHaml'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imei': imei,
      'startDate': _formatDateTime(startDate),
      'endDate': _formatDateTime(endDate),
      'serviceType': serviceType.value,
      'needHaml': needHaml,
    };
  }

  String? _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return null;
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return "$year-$month-$day $hour:$minute";
  }
}
