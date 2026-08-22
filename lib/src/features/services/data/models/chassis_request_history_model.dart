import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';

class ChassisRequestHistoryModel extends ChassisRequestHistoryEntity {
  const ChassisRequestHistoryModel({
    required super.serviceType,
    super.id,
    super.trackingCode,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.isSubscription,
    super.subscriptionId,
    super.isGauranty,
    super.status,
    super.statusTitle,
    super.type,
    super.typeTitle,
    super.agencyCode,
    super.defectTitle,
    super.service,
    super.mobileNumber,
    super.description,
    super.hamlAzad,
    super.reasonHamlAzadId,
    super.vip,
    super.vipConditionTitle,
    super.chassisNumber,
    super.carName,
  });

  factory ChassisRequestHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChassisRequestHistoryModel(
      id: json['id'],
      trackingCode: json['trackingCode'],
      insertDateTime: json['insertDateTime'],
      insertDateTimeJalali: json['insertDateTimeJalali'],
      isSubscription: json['isSubscription'],
      subscriptionId: json['subscriptionId'],
      isGauranty: json['isGauranty'],
      status: json['status'],
      statusTitle: json['statusTitle'],
      type: json['type'] ?? json['serviceType'],
      typeTitle: json['typeTitle'],
      agencyCode: json['agencyCode'],
      defectTitle: json['defectTitle'],
      service: json['service'],
      mobileNumber: json['mobileNumber'],
      description: json['description'],
      hamlAzad: json['hamlAzad'],
      reasonHamlAzadId: json['reasonHamlAzadId'],
      vip: json['vip'],
      vipConditionTitle: json['vipConditionTitle'],
      chassisNumber: json['chassisNumber'],
      carName: json['carName'],
      serviceType: ServiceType.fromValue(
        json['type'] ?? json['serviceType'],
      ),
    );
  }
}
