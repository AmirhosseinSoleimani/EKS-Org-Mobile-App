import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_tool_entity.dart';

class VehicleToolModel extends VehicleToolEntity {
  const VehicleToolModel({
    super.emdadToolsId,
    super.emdadToolsTitle,
    super.isSelectable,
  });

  factory VehicleToolModel.fromJson(Map<String, dynamic> json) {
    return VehicleToolModel(
      emdadToolsId: json['emdadToolsId'] as int?,
      emdadToolsTitle: json['emdadToolsTitle'] as String?,
      isSelectable: json['isSelectable'] as bool?,
    );
  }

  static List<VehicleToolModel> fromJsonList(List<dynamic> json) {
    return json
        .map(
          (item) => VehicleToolModel.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'emdadToolsId': emdadToolsId,
      'emdadToolsTitle': emdadToolsTitle,
      'isSelectable': isSelectable,
    };
  }
}
