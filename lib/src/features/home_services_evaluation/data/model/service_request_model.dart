
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_request_entity.dart';

class ServiceRequestModel extends ServiceRequestEntity {
  ServiceRequestModel({
    super.serviceRequestId,
    super.serviceType,
    super.serviceCategoryId,
    super.kilometer,
    super.planningId,
    super.defectId,
    super.nationalCode,
    super.carInfoGuid,
    super.vipConditionId,
    super.serviceName,
    super.guarantyStartDate
  });

  Map<String, dynamic> toJson() {
    return {
      'serviceRequestId': serviceRequestId,
      'serviceType': serviceType,
      'serviceCategoryId': serviceCategoryId,
      'kilometer': kilometer,
      'planningId': planningId,
      'defectId': defectId,
      'nationalCode': nationalCode,
      'carInfoGuid': carInfoGuid,
      'vipConditionId': vipConditionId,
      'serviceName': serviceName,
      'garantyStartDate': guarantyStartDate,
    };
  }
}