import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/labor_list_param_entity.dart';


class LaborListParamModel extends LaborListParamEntity {
  const LaborListParamModel({
    required super.serviceType,
    super.defectId,
    super.emdadServiceId,
    super.hasGaranty,
    super.hasSubscription,
    super.kilometer,
    super.searchText,
    super.serviceRequestId,
    super.workOrderCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'defectId': defectId,
      'emdadServiceId': emdadServiceId,
      'hasGaranty': hasGaranty,
      'hasSubscription': hasSubscription,
      'kilometer': kilometer,
      'searchText': searchText,
      'serviceRequestId': serviceRequestId,
      'serviceType': serviceType.value,
      'workOrderCode': workOrderCode,
    };
  }
}