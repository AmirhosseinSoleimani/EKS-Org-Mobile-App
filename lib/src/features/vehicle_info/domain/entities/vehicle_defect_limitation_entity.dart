class VehicleDefectLimitationEntity {
  const VehicleDefectLimitationEntity({
    required this.id,
    this.parentCode,
    required this.title,
    this.selected = false,
  });

  final int id;
  final String? parentCode;
  final String title;
  final bool selected;

  VehicleDefectLimitationEntity copyWith({bool? selected}) {
    return VehicleDefectLimitationEntity(
      id: id,
      parentCode: parentCode,
      title: title,
      selected: selected ?? this.selected,
    );
  }
}
