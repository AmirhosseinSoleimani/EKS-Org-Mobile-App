import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_request_model.dart';

class ServiceRequestEntity {
  ServiceRequestEntity({
    required this.serviceType,
    this.serviceRequestId,
    this.serviceCategoryId,
    this.kilometer,
    this.planningId,
    this.defectId,
    this.nationalCode,
    this.carInfoGuid,
    this.vipConditionId,
    this.serviceName,
    this.guarantyStartDate,
  });

  final int? serviceRequestId;
  final ServiceType serviceType;
  final int? serviceCategoryId;
  final int? kilometer;
  final int? planningId;
  final int? defectId;
  final String? nationalCode;
  final String? carInfoGuid;
  final int? vipConditionId;
  final String? serviceName;
  final String? guarantyStartDate;

  ServiceRequestEntity copyWith({
    int? serviceRequestId,
    ServiceType? serviceType,
    int? serviceCategoryId,
    int? kilometer,
    int? planningId,
    int? defectId,
    String? nationalCode,
    String? carInfoGuid,
    int? vipConditionId,
    String? serviceName,
    String? guarantyStartDate,
  }) {
    return ServiceRequestEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      kilometer: kilometer ?? this.kilometer,
      planningId: planningId ?? this.planningId,
      defectId: defectId ?? this.defectId,
      nationalCode: nationalCode ?? this.nationalCode,
      carInfoGuid: carInfoGuid ?? this.carInfoGuid,
      vipConditionId: vipConditionId ?? this.vipConditionId,
      serviceName: serviceName ?? this.serviceName,
      guarantyStartDate: guarantyStartDate ?? this.guarantyStartDate,
    );
  }

  ServiceRequestModel toModel() {
    return ServiceRequestModel(
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
      serviceCategoryId: serviceCategoryId,
      kilometer: kilometer,
      planningId: planningId,
      defectId: defectId,
      nationalCode: nationalCode,
      carInfoGuid: carInfoGuid,
      vipConditionId: vipConditionId,
      serviceName: serviceName,
      guarantyStartDate: guarantyStartDate,
    );
  }
}
