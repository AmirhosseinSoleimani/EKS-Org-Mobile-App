import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_request_entity.dart';

class LaborRequestModel extends LaborRequestEntity {
  LaborRequestModel({
    super.kilometer,
    super.emdadProductId,
    super.emdadServiceId,
    super.hasGaranty,
    super.hasSubscription,
    super.searchText,
    super.serviceRequestId,
    super.serviceType,
    super.workOrderCode,
    super.guarantyStartDate,
    super.carModelId,
    super.carTipId,
  });
  Map<String, dynamic> toJson() {
    return {
      'emdadProductId': emdadProductId,
      'emdadServiceId': emdadServiceId,
      'hasGaranty': hasGaranty,
      'hasSubscription': hasSubscription,
      'searchText': searchText,
      'serviceRequestId': serviceRequestId,
      'kilometer': kilometer,
      'serviceType': serviceType,
      'workOrderCode': workOrderCode,
      'garantyStartDate': guarantyStartDate,
      'carModelId': carModelId,
      'carTipId': carTipId,
    };
  }
}
