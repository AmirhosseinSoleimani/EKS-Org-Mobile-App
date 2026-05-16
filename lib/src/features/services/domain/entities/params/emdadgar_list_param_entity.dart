import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/emdadgar_list_param_model.dart';

class EmdadgarListParamEntity {
  int? serviceRequestId;
  ServiceType serviceType;
  int? serviceId;
  String? aidPerName;
  String? aidPerCode;
  int? aidDistanceKm;
  bool? isActive;
  bool? onlyReadyEmdadgar;
  bool? requestCityEmdadgar;
  bool? requestProvinceEmdadgar;

  EmdadgarListParamEntity({
   required this.serviceType,
    this.serviceRequestId,
    this.serviceId,
    this.aidPerName,
    this.aidPerCode,
    this.aidDistanceKm,
    this.isActive,
    this.onlyReadyEmdadgar,
    this.requestCityEmdadgar,
    this.requestProvinceEmdadgar,
  });

  EmdadgarListParamEntity copyWith({
    int? serviceRequestId,
    ServiceType? serviceType,
    int? serviceId,
    String? aidPerName,
    String? aidPerCode,
    int? aidDistanceKm,
    bool? isActive,
    bool? onlyReadyEmdadgar,
    bool? requestCityEmdadgar,
    bool? requestProvinceEmdadgar,
  }) {
    return EmdadgarListParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
      serviceId: serviceId ?? this.serviceId,
      aidPerName: aidPerName ?? this.aidPerName,
      aidPerCode: aidPerCode ?? this.aidPerCode,
      aidDistanceKm: aidDistanceKm ?? this.aidDistanceKm,
      isActive: isActive ?? this.isActive,
      onlyReadyEmdadgar: onlyReadyEmdadgar ?? this.onlyReadyEmdadgar,
      requestCityEmdadgar: requestCityEmdadgar ?? this.requestCityEmdadgar,
      requestProvinceEmdadgar:
      requestProvinceEmdadgar ?? this.requestProvinceEmdadgar,
    );
  }

  EmdadgarListParamModel toModel() {
    return EmdadgarListParamModel(
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
      serviceId: serviceId,
      aidPerName: aidPerName,
      aidPerCode: aidPerCode,
      aidDistanceKm: aidDistanceKm,
      isActive: isActive,
      onlyReadyEmdadgar: onlyReadyEmdadgar,
      requestCityEmdadgar: requestCityEmdadgar,
      requestProvinceEmdadgar: requestProvinceEmdadgar,
    );
  }
}
