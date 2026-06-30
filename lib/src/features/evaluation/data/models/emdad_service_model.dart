import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdad_service_entity.dart';

class EmdadServiceModel extends EmdadServiceEntity {
  const EmdadServiceModel({
    required super.serviceType,
    required super.serviceTypeTitle,
    required super.serviceCategoryId,
    required super.serviceCategoryCode,
    required super.serviceCategoryTitle,
    required super.serviceId,
    required super.serviceCode,
    required super.serviceTitle,
    required super.serviceFromKilometer,
    required super.serviceToKilometer,
    required super.isSelectable,
    required super.workOrderCode,
    required super.isSubscribedByNationalCode,
    required super.isImageMandatory,
  });

  factory EmdadServiceModel.fromJson(Map<String, dynamic> json) {
    return EmdadServiceModel(
      serviceType: _toInt(json['serviceType']),

      serviceTypeTitle: json['serviceTypeTitle']?.toString() ?? '',

      serviceCategoryId: _toInt(json['serviceCategoryId']),

      serviceCategoryCode: json['serviceCategoryCode']?.toString() ?? '',

      serviceCategoryTitle: json['serviceCategoryTitle']?.toString() ?? '',

      serviceId: _toInt(json['serviceId']),

      serviceCode: json['serviceCode']?.toString() ?? '',

      serviceTitle: json['serviceTitle']?.toString() ?? '',

      serviceFromKilometer: _toInt(json['serviceFromKilometer']),

      serviceToKilometer: _toInt(json['serviceToKilometer']),

      isSelectable: _toBool(json['isSelectable']),

      workOrderCode: json['workOrderCode']?.toString() ?? '',

      isSubscribedByNationalCode: _toBool(json['isSubscribedByNationalCode']),

      isImageMandatory: _toBool(json['isImageMandatory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceType': serviceType,
      'serviceTypeTitle': serviceTypeTitle,
      'serviceCategoryId': serviceCategoryId,
      'serviceCategoryCode': serviceCategoryCode,
      'serviceCategoryTitle': serviceCategoryTitle,
      'serviceId': serviceId,
      'serviceCode': serviceCode,
      'serviceTitle': serviceTitle,
      'serviceFromKilometer': serviceFromKilometer,
      'serviceToKilometer': serviceToKilometer,
      'isSelectable': isSelectable,
      'workOrderCode': workOrderCode,
      'isSubscribedByNationalCode': isSubscribedByNationalCode,
      'isImageMandatory': isImageMandatory,
    };
  }

  static bool _toBool(dynamic v) {
    if (v is bool) return v;
    if (v is String) return v.toLowerCase() == 'true' || v == '1';
    if (v is num) return v != 0;

    return false;
  }

  static int _toInt(dynamic v) {
    if (v is int) return v;

    if (v is String) return int.tryParse(v) ?? 0;

    if (v is num) return v.toInt();

    return 0;
  }
}
