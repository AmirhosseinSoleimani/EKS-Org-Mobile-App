import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/part_list_param_model.dart';

class PartListParamEntity {
  final int? defectId;
  final int? emdadServiceId;
  final bool? hasGaranty;
  final bool? hasSubscription;
  final int? kilometer;
  final int? laborGroupId;
  final int? laborId;
  final String? searchText;
  final int? serviceRequestId;
  final ServiceType serviceType;
  final String? workOrderCode;

  const PartListParamEntity({
    required this.serviceType,
    this.defectId,
    this.emdadServiceId,
    this.hasGaranty,
    this.hasSubscription,
    this.kilometer,
    this.laborGroupId,
    this.laborId,
    this.searchText,
    this.serviceRequestId,
    this.workOrderCode,
  });

  PartListParamModel toModel() {
    return PartListParamModel(
      defectId: defectId,
      emdadServiceId: emdadServiceId,
      hasGaranty: hasGaranty,
      hasSubscription: hasSubscription,
      kilometer: kilometer,
      laborGroupId: laborGroupId,
      laborId: laborId,
      searchText: searchText,
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
      workOrderCode: workOrderCode,
    );
  }

  PartListParamEntity copyWith({
    int? defectId,
    int? emdadServiceId,
    bool? hasGaranty,
    bool? hasSubscription,
    int? kilometer,
    int? laborGroupId,
    int? laborId,
    String? searchText,
    int? serviceRequestId,
    ServiceType? serviceType,
    String? workOrderCode,
  }) {
    return PartListParamEntity(
      defectId: defectId ?? this.defectId,
      emdadServiceId: emdadServiceId ?? this.emdadServiceId,
      hasGaranty: hasGaranty ?? this.hasGaranty,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      kilometer: kilometer ?? this.kilometer,
      laborGroupId: laborGroupId ?? this.laborGroupId,
      laborId: laborId ?? this.laborId,
      searchText: searchText ?? this.searchText,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
      workOrderCode: workOrderCode ?? this.workOrderCode,
    );
  }
}
