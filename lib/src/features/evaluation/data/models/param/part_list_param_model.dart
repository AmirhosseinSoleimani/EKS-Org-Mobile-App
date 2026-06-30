import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_list_param_entity.dart';


class PartListParamModel extends PartListParamEntity {
  const PartListParamModel({
    required super.serviceType,
    super.defectId,
    super.emdadServiceId,
    super.hasGaranty,
    super.hasSubscription,
    super.kilometer,
    super.laborGroupId,
    super.laborId,
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
      'laborGroupId': laborGroupId,
      'laborId': laborId,
      'searchText': searchText,
      'serviceRequestId': serviceRequestId,
      'serviceType': serviceType.value,
      'workOrderCode': workOrderCode,
    };
  }
}