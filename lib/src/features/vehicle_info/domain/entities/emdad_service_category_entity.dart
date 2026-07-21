class EmdadServiceCategoryGroupEntity {
  const EmdadServiceCategoryGroupEntity({
    required this.id,
    this.code,
    required this.name,
    this.indeterminate = false,
    this.selectable = false,
    this.categories = const [],
  });

  final int id;
  final int? code;
  final String name;
  final bool indeterminate;
  final bool selectable;
  final List<EmdadServiceCategoryEntity> categories;
}

class EmdadServiceCategoryEntity {
  const EmdadServiceCategoryEntity({
    required this.id,
    this.code,
    required this.title,
    this.selectable = false,
    this.parentCode,
    this.selected,
  });

  final int id;
  final int? code;
  final String title;
  final bool selectable;
  final String? parentCode;
  final bool? selected;

  EmdadServiceCategoryEntity copyWith({
    bool? selectable,
    bool? selected,
  }) {
    return EmdadServiceCategoryEntity(
      id: id,
      code: code,
      title: title,
      selectable: selectable ?? this.selectable,
      parentCode: parentCode,
      selected: selected ?? this.selected,
    );
  }
}
