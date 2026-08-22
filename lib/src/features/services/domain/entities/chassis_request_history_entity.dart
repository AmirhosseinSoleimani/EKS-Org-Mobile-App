import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/chassis_request_history_model.dart';

class ChassisRequestHistoryEntity {
  final int? id;
  final int? trackingCode;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final bool? isSubscription;
  final int? subscriptionId;
  final bool? isGauranty;
  final int? status;
  final String? statusTitle;
  final int? type;
  final String? typeTitle;
  final String? agencyCode;
  final String? defectTitle;
  final String? service;
  final String? mobileNumber;
  final String? description;
  final bool? hamlAzad;
  final int? reasonHamlAzadId;
  final bool? vip;
  final String? vipConditionTitle;
  final String? chassisNumber;
  final String? carName;
  final ServiceType serviceType;

  const ChassisRequestHistoryEntity({
    this.id,
    this.trackingCode,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.isSubscription,
    this.subscriptionId,
    this.isGauranty,
    this.status,
    this.statusTitle,
    this.type,
    this.typeTitle,
    this.agencyCode,
    this.defectTitle,
    this.service,
    this.mobileNumber,
    this.description,
    this.hamlAzad,
    this.reasonHamlAzadId,
    this.vip,
    this.vipConditionTitle,
    this.chassisNumber,
    this.carName,
    required this.serviceType,
  });

  bool get shouldShowSubscriptionStatus =>
      serviceType == ServiceType.reliefService;

  bool get shouldShowVipStatus => vip == true;

  bool get shouldShowOutOfFleetPermit =>
      hamlAzad == true && reasonHamlAzadId != null && status != 2;

  ChassisRequestHistoryEntity copyWith({
    int? id,
    int? trackingCode,
    String? insertDateTime,
    String? insertDateTimeJalali,
    bool? isSubscription,
    int? subscriptionId,
    bool? isGauranty,
    int? status,
    String? statusTitle,
    int? type,
    String? typeTitle,
    String? agencyCode,
    String? defectTitle,
    String? service,
    String? mobileNumber,
    String? description,
    bool? hamlAzad,
    int? reasonHamlAzadId,
    bool? vip,
    String? vipConditionTitle,
    String? chassisNumber,
    String? carName,
    ServiceType? serviceType,
  }) {
    return ChassisRequestHistoryEntity(
      id: id ?? this.id,
      trackingCode: trackingCode ?? this.trackingCode,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      insertDateTimeJalali:
          insertDateTimeJalali ?? this.insertDateTimeJalali,
      isSubscription: isSubscription ?? this.isSubscription,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      isGauranty: isGauranty ?? this.isGauranty,
      status: status ?? this.status,
      statusTitle: statusTitle ?? this.statusTitle,
      type: type ?? this.type,
      typeTitle: typeTitle ?? this.typeTitle,
      agencyCode: agencyCode ?? this.agencyCode,
      defectTitle: defectTitle ?? this.defectTitle,
      service: service ?? this.service,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      description: description ?? this.description,
      hamlAzad: hamlAzad ?? this.hamlAzad,
      reasonHamlAzadId: reasonHamlAzadId ?? this.reasonHamlAzadId,
      vip: vip ?? this.vip,
      vipConditionTitle: vipConditionTitle ?? this.vipConditionTitle,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      carName: carName ?? this.carName,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  ChassisRequestHistoryModel toModel() {
    return ChassisRequestHistoryModel(
      id: id,
      serviceType: serviceType,
      trackingCode: trackingCode,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      isSubscription: isSubscription,
      subscriptionId: subscriptionId,
      isGauranty: isGauranty,
      status: status,
      statusTitle: statusTitle,
      type: type,
      typeTitle: typeTitle,
      agencyCode: agencyCode,
      defectTitle: defectTitle,
      service: service,
      mobileNumber: mobileNumber,
      description: description,
      hamlAzad: hamlAzad,
      reasonHamlAzadId: reasonHamlAzadId,
      vip: vip,
      vipConditionTitle: vipConditionTitle,
      chassisNumber: chassisNumber,
      carName: carName,
    );
  }
}
