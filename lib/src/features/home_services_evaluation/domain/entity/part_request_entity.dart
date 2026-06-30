import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';

import '../../data/model/part_request_model.dart';

class PartRequestEntity {
  ServiceType serviceType;
  int? serviceRequestId;
  int? emdadServiceId;
  int? emdadProductId;
  String? workOrderCode;
  String? searchText;
  bool? hasSubscription;
  bool? hasGaranty;
  int? laborId;
  int? kilometer;
  int? laborGroupId;
  String? guarantyStartDate;
  int? carModelId;
  int? carTipId;

  PartRequestEntity({
    required this.serviceType,
    this.serviceRequestId,
    this.laborId,
    this.hasSubscription,
    this.hasGaranty,
    this.kilometer,
    this.laborGroupId,
    this.searchText,
    this.workOrderCode,
    this.emdadServiceId,
    this.emdadProductId,
    this.guarantyStartDate,
    this.carModelId,
    this.carTipId,
  });
  PartRequestModel toModel() {
    return PartRequestModel(
      serviceRequestId: serviceRequestId,
      laborId: laborId,
      serviceType: serviceType,
      emdadServiceId: emdadServiceId,
      emdadProductId: emdadProductId,
      workOrderCode: workOrderCode,
      searchText: searchText,
      hasSubscription: hasSubscription,
      hasGaranty: hasGaranty,
      kilometer: kilometer,
      laborGroupId: laborGroupId,
      guarantyStartDate: guarantyStartDate,
      carModelId: carModelId,
      carTipId: carTipId,
    );
  }
}
