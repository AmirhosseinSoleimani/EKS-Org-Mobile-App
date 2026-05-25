

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/labor_list_param_model.dart';

class LaborListParamEntity {
  final ServiceType serviceType;
  final int? defectId;
  final int? emdadServiceId;
  final bool? hasGaranty;
  final bool? hasSubscription;
  final int? kilometer;
  final String? searchText;
  final int? serviceRequestId;
  final String? workOrderCode;

  const LaborListParamEntity({
    required this.serviceType,
    this.defectId,
    this.emdadServiceId,
    this.hasGaranty,
    this.hasSubscription,
    this.kilometer,
    this.searchText,
    this.serviceRequestId,
    this.workOrderCode,
  });

  LaborListParamModel toModel() {
    return LaborListParamModel(
      defectId: defectId,
      emdadServiceId: emdadServiceId,
      hasGaranty: hasGaranty,
      hasSubscription: hasSubscription,
      kilometer: kilometer,
      searchText: searchText,
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
      workOrderCode: workOrderCode,
    );
  }

  LaborListParamEntity copyWith({
    int? defectId,
    int? emdadServiceId,
    bool? hasGaranty,
    bool? hasSubscription,
    int? kilometer,
    String? searchText,
    int? serviceRequestId,
    ServiceType? serviceType,
    String? workOrderCode,
  }) {
    return LaborListParamEntity(
      defectId: defectId ?? this.defectId,
      emdadServiceId: emdadServiceId ?? this.emdadServiceId,
      hasGaranty: hasGaranty ?? this.hasGaranty,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      kilometer: kilometer ?? this.kilometer,
      searchText: searchText ?? this.searchText,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
      workOrderCode: workOrderCode ?? this.workOrderCode,
    );
  }
}