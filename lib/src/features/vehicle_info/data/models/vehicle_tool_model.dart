import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_tool_entity.dart';

class VehicleToolModel extends VehicleToolEntity {
  const VehicleToolModel({
    required super.emdadToolsId,
    required super.emdadToolsTitle,
    super.isSelectable,
  });

  factory VehicleToolModel.fromJson(Map<String, dynamic> json) {
    return VehicleToolModel(
      emdadToolsId: json['emdadToolsId'] as int? ?? 0,
      emdadToolsTitle: json['emdadToolsTitle'] as String? ?? '',
      isSelectable: json['isSelectable'] as bool? ?? false,
    );
  }
}
