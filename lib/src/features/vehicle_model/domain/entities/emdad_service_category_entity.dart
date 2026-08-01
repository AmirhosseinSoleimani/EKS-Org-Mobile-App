class EmdadServiceCategoryEntity {
  const EmdadServiceCategoryEntity({
    this.id,
    this.title,
    this.serviceTypeId,
    this.serviceTypeTitle,
    this.selected = false,
  });

  final int? id;
  final String? title;
  final int? serviceTypeId;
  final String? serviceTypeTitle;
  final bool selected;

  EmdadServiceCategoryEntity copyWith({bool? selected}) {
    return EmdadServiceCategoryEntity(
      id: id,
      title: title,
      serviceTypeId: serviceTypeId,
      serviceTypeTitle: serviceTypeTitle,
      selected: selected ?? this.selected,
    );
  }
}
