class NavganDefectEntity {
  const NavganDefectEntity({
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

  NavganDefectEntity copyWith({bool? selected}) {
    return NavganDefectEntity(
      id: id,
      parentCode: parentCode,
      title: title,
      selected: selected ?? this.selected,
      isActive: isActive,
    );
  }
}
