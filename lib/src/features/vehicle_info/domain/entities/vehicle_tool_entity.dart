class VehicleToolEntity {
  const VehicleToolEntity({
    required this.emdadToolsId,
    required this.emdadToolsTitle,
    this.isSelectable = false,
  });

  final int emdadToolsId;
  final String emdadToolsTitle;
  final bool isSelectable;

  VehicleToolEntity copyWith({bool? isSelectable}) {
    return VehicleToolEntity(
      emdadToolsId: emdadToolsId,
      emdadToolsTitle: emdadToolsTitle,
      isSelectable: isSelectable ?? this.isSelectable,
    );
  }
}
