import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/emdadgar_list_param_entity.dart';

class EmdadgarListParamModel extends EmdadgarListParamEntity {
  EmdadgarListParamModel({
    super.serviceRequestId,
    super.serviceType,
    super.serviceId,
    super.aidPerName,
    super.aidPerCode,
    super.aidDistanceKm,
    super.isActive,
    super.onlyReadyEmdadgar,
    super.requestCityEmdadgar,
    super.requestProvinceEmdadgar,
  });

  Map<String, dynamic> toJson() {
    return {
      "serviceRequestId": serviceRequestId,
      "serviceType": serviceType,
      "serviceId": serviceId,
      "aidPerName": aidPerName,
      "aidPerCode": aidPerCode,
      "aidDistanceKm": aidDistanceKm,
      "isActive": isActive,
      "onlyReadyEmdadgar": onlyReadyEmdadgar,
      "requestCityEmdadgar": requestCityEmdadgar,
      "requestProvinceEmdadgar": requestProvinceEmdadgar,
    };
  }
}
