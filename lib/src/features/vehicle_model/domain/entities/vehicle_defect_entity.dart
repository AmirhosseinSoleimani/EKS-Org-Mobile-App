class VehicleDefectEntity {
  const VehicleDefectEntity({
    this.id,
    this.parentCode,
    this.title,
    this.selected = false,
    this.isActive,
  });

  final int? id;
  final int? parentCode;
  final String? title;
  final bool selected;
  final bool? isActive;

  VehicleDefectEntity copyWith({bool? selected}) {
    return VehicleDefectEntity(
      id: id,
      parentCode: parentCode,
      title: title,
      selected: selected ?? this.selected,
      isActive: isActive,
    );
  }
}
