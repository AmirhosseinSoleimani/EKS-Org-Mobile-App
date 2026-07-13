import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_tool_model.dart';

class VehicleToolEntity {
  final int? emdadToolsId;
  final String? emdadToolsTitle;
  final bool? isSelectable;

  const VehicleToolEntity({
    this.emdadToolsId,
    this.emdadToolsTitle,
    this.isSelectable,
  });

  VehicleToolModel toModel() {
    return VehicleToolModel(
      emdadToolsId: emdadToolsId,
      emdadToolsTitle: emdadToolsTitle,
      isSelectable: isSelectable,
    );
  }

  VehicleToolEntity copyWith({
    int? emdadToolsId,
    String? emdadToolsTitle,
    bool? isSelectable,
  }) {
    return VehicleToolEntity(
      emdadToolsId: emdadToolsId ?? this.emdadToolsId,
      emdadToolsTitle: emdadToolsTitle ?? this.emdadToolsTitle,
      isSelectable: isSelectable ?? this.isSelectable,
    );
  }
}
