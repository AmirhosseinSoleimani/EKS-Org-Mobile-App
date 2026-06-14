import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_request_entity.dart';

class PartRequestModel extends PartRequestEntity {
  PartRequestModel({
    super.emdadProductId,
    super.emdadServiceId,
    super.hasGaranty,
    super.hasSubscription,
    super.kilometer,
    super.laborGroupId,
    super.laborId,
    super.searchText,
    super.serviceRequestId,
    super.serviceType,
    super.workOrderCode,
    super.guarantyStartDate,
    super.carModelId,
    super.carTipId,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceRequestId'] = serviceRequestId;
    map['laborId'] = laborId;
    map['emdadProductId'] = emdadProductId;
    map['emdadServiceId'] = emdadServiceId;
    map['hasGaranty'] = hasGaranty;
    map['hasSubscription'] = hasSubscription;
    map['kilometer'] = kilometer;
    map['laborGroupId'] = laborGroupId;
    map['searchText'] = searchText;
    map['serviceType'] = serviceType;
    map['workOrderCode'] = workOrderCode;
    map['garantyStartDate'] = guarantyStartDate;
    map['carModelId'] = carModelId;
    map['carTipId'] = carTipId;
    return map;
  }
}
