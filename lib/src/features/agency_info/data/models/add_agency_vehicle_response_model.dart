import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/add_agency_vehicle_entity.dart';

class AddAgencyVehicleResponseModel extends AddAgencyVehicleEntity {
  const AddAgencyVehicleResponseModel({
    required super.id,
  });

  factory AddAgencyVehicleResponseModel.fromResponse(dynamic data) {
    if (data is Map) {
      return AddAgencyVehicleResponseModel(
        id: (data['data'] ?? data['Data'])?.toString() ?? '',
      );
    }

    return AddAgencyVehicleResponseModel(
      id: data?.toString() ?? '',
    );
  }
}