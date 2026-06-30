
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_detail_and_check_subscription_request_entity.dart';

class ServiceDetailAndCheckSubscriptionRequestModel extends ServiceDetailAndCheckSubscriptionRequestEntity {
  ServiceDetailAndCheckSubscriptionRequestModel({
    super.emdadgarDefectInfoId,
    super.emdadgarEvaluationKilometer,
    super.emdadgarServiceCategoryId,
    super.serviceRequestId,
    super.serviceType
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EmdadgarServiceCategoryId'] = emdadgarServiceCategoryId;
    map['ServiceRequestId'] = serviceRequestId;
    map['EmdadgarDefectInfoId'] = emdadgarDefectInfoId;
    map['EmdadgarEvaluationKilometer'] = emdadgarEvaluationKilometer;
    map['serviceType'] = serviceType;
    return map;
  }
}