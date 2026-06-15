import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/labor_request_model.dart';

class LaborRequestEntity {
  int? serviceRequestId;
  ServiceType serviceType;
  int? emdadServiceId;
  int? emdadProductId;
  String? workOrderCode;
  String? searchText;
  bool? hasSubscription;
  bool? hasGaranty;
  int? kilometer;
  String? guarantyStartDate;
  int? carModelId;
  int? carTipId;

  LaborRequestEntity({
    required this.serviceType,
    this.serviceRequestId,
    this.emdadServiceId,
    this.emdadProductId,
    this.workOrderCode,
    this.searchText,
    this.kilometer,
    this.hasSubscription,
    this.hasGaranty,
    this.guarantyStartDate,
    this.carModelId,
    this.carTipId,
  });

  LaborRequestEntity copyWith({
    int? serviceRequestId,
    ServiceType? serviceType,
    int? emdadServiceId,
    int? emdadProductId,
    String? workOrderCode,
    String? searchText,
    bool? hasSubscription,
    bool? hasGaranty,
    int? kilometer,
    String? guarantyStartDate,
    int? carModelId,
    int? carTipId,
  }) {
    return LaborRequestEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
      emdadServiceId: emdadServiceId ?? this.emdadServiceId,
      emdadProductId: emdadProductId ?? this.emdadProductId,
      workOrderCode: workOrderCode ?? this.workOrderCode,
      searchText: searchText ?? this.searchText,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      hasGaranty: hasGaranty ?? this.hasGaranty,
      kilometer: kilometer ?? this.kilometer,
      guarantyStartDate: guarantyStartDate ?? this.guarantyStartDate,
      carModelId: carModelId ?? this.carModelId,
      carTipId: carTipId ?? this.carTipId,
    );
  }

  LaborRequestModel toModel() {
    return LaborRequestModel(
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
      emdadServiceId: emdadServiceId,
      emdadProductId: emdadProductId,
      workOrderCode: workOrderCode,
      searchText: searchText,
      kilometer: kilometer,
      hasSubscription: hasSubscription,
      hasGaranty: hasGaranty,
      guarantyStartDate: guarantyStartDate,
      carModelId: carModelId,
      carTipId: carTipId,
    );
  }
}
