import 'package:eks_sana_plus_org/src/features/services/data/models/params/update_service_request_param_model.dart';

class UpdateServiceRequestParamEntity {
  final int? id;
  final double? latitude;
  final double? longitude;
  final String? aIDAddress;
  final String? licensePlateNo;
  final String? callMobileNumber;
  final String? carInfoGuid;
  final int? cityId;
  final int? defectId;
  final String? description;
  final int? emdadServiceId;
  final bool? trafficPlan;

  const UpdateServiceRequestParamEntity({
    this.id,
    this.latitude,
    this.longitude,
    this.aIDAddress,
    this.licensePlateNo,
    this.callMobileNumber,
    this.carInfoGuid,
    this.cityId,
    this.defectId,
    this.description,
    this.emdadServiceId,
    this.trafficPlan,
  });

  UpdateServiceRequestParamEntity copyWith({
    int? id,
    double? latitude,
    double? longitude,
    String? aIDAddress,
    String? licensePlateNo,
    String? callMobileNumber,
    String? carInfoGuid,
    int? cityId,
    int? defectId,
    String? description,
    int? emdadServiceId,
    bool? trafficPlan,
  }) {
    return UpdateServiceRequestParamEntity(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      aIDAddress: aIDAddress ?? this.aIDAddress,
      licensePlateNo: licensePlateNo ?? this.licensePlateNo,
      callMobileNumber: callMobileNumber ?? this.callMobileNumber,
      carInfoGuid: carInfoGuid ?? this.carInfoGuid,
      cityId: cityId ?? this.cityId,
      defectId: defectId ?? this.defectId,
      description: description ?? this.description,
      emdadServiceId: emdadServiceId ?? this.emdadServiceId,
      trafficPlan: trafficPlan ?? this.trafficPlan,
    );
  }

  UpdateServiceRequestParamModel toModel() => UpdateServiceRequestParamModel(
    id: id,
    latitude: latitude,
    longitude: longitude,
    aIDAddress: aIDAddress,
    licensePlateNo: licensePlateNo,
    callMobileNumber: callMobileNumber,
    carInfoGuid: carInfoGuid,
    cityId: cityId,
    defectId: defectId,
    description: description,
    emdadServiceId: emdadServiceId,
    trafficPlan: trafficPlan,
  );
}
