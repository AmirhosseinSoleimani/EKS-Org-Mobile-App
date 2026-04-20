import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_filter_param_entity.dart';

class RequestFilterParamModel extends RequestFilterParamEntity {
  const RequestFilterParamModel({
    super.serviceRequestId,
    super.callMobileNumber,
    super.chassisNumber,
    super.rescuerName,
    super.cityName,
    super.provinceName,
    super.requestStatus,
    super.timePeriod,
    super.page = 1,
    super.pageSize = 20,
  });

  Map<String, dynamic> toJson() {
    return {
      "RequestStatus": requestStatus.value,
      "ServiceRequestId": serviceRequestId,
      "CallMobileNumber": callMobileNumber,
      "ChassisNumber": chassisNumber,
      "CityName": cityName,
      "ProvinceName": provinceName,
      "EmdadgarTitle": rescuerName,
      "PageSize": pageSize,
      "Page": page,
    };
  }
}
