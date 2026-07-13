import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_id_response_entity.dart';

class VehicleIdResponseModel extends VehicleIdResponseEntity {
  const VehicleIdResponseModel({
    super.id,
  });

  factory VehicleIdResponseModel.fromJson(Map<String, dynamic> json) {
    return VehicleIdResponseModel(
      id: json['id']?.toString(),
    );
  }

  static List<VehicleIdResponseModel> fromJsonList(List<dynamic> json) {
    return json
        .map(
          (item) => VehicleIdResponseModel.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
