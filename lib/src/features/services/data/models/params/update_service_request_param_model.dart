import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/update_service_request_param_entity.dart';

class UpdateServiceRequestParamModel extends UpdateServiceRequestParamEntity {
  const UpdateServiceRequestParamModel({
    super.id,
    super.latitude,
    super.longitude,
    super.aIDAddress,
    super.licensePlateNo,
    super.callMobileNumber,
    super.carInfoGuid,
    super.cityId,
    super.defectId,
    super.description,
    super.emdadServiceId,
    super.trafficPlan,
  });

  factory UpdateServiceRequestParamModel.fromJson(Map<String, dynamic> json) {
    return UpdateServiceRequestParamModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      aIDAddress: json['aIDAddress']?.toString(),
      licensePlateNo: json['LicensePlateNo']?.toString(),
      callMobileNumber: json['callMobileNumber']?.toString(),
      carInfoGuid: json['carInfoGuid']?.toString(),
      cityId: json['cityId'] as int?,
      defectId: json['defectId'] as int?,
      description: json['description']?.toString(),
      emdadServiceId: json['emdadServiceId'] as int?,
      trafficPlan: json['trafficPlan'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'aIDAddress': aIDAddress,
      'LicensePlateNo': licensePlateNo,
      'callMobileNumber': callMobileNumber,
      'carInfoGuid': carInfoGuid,
      'cityId': cityId,
      'defectId': defectId,
      'description': description,
      'emdadServiceId': emdadServiceId,
      'trafficPlan': trafficPlan,
    };
  }
}
