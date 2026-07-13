import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/submit_vehicle_tools_response_entity.dart';

class SubmitVehicleToolsResponseModel extends SubmitVehicleToolsResponseEntity {
  const SubmitVehicleToolsResponseModel({
    super.message,
  });

  factory SubmitVehicleToolsResponseModel.fromJson(Map<String, dynamic> json) {
    return SubmitVehicleToolsResponseModel(
      message: json['message'] as String?,
    );
  }

  static List<SubmitVehicleToolsResponseModel> fromJsonList(List<dynamic> json) {
    return json
        .map(
          (item) => SubmitVehicleToolsResponseModel.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
