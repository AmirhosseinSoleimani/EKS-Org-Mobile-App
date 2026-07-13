import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';

class EmdadServiceCategoryGroupModel extends EmdadServiceCategoryGroupEntity {
  const EmdadServiceCategoryGroupModel({
    required super.id,
    super.code,
    required super.name,
    super.indeterminate,
    super.selectable,
    super.categories,
  });

  factory EmdadServiceCategoryGroupModel.fromJson(Map<String, dynamic> json) {
    final categories = json['emdadServiceCategories'] ?? json['emdadCategories'];
    return EmdadServiceCategoryGroupModel(
      id: json['id'] as int? ?? 0,
      code: json['code'] as int?,
      name: json['name'] as String? ?? json['serviceTypeTitle'] as String? ?? '',
      indeterminate: json['indeterminate'] as bool? ?? false,
      selectable: json['selectable'] as bool? ?? false,
      categories: categories is List
          ? categories
              .map((item) => EmdadServiceCategoryModel.fromJson(Map<String, dynamic>.from(item as Map)))
              .toList()
          : const [],
    );
  }
}

class EmdadServiceCategoryModel extends EmdadServiceCategoryEntity {
  const EmdadServiceCategoryModel({
    required super.id,
    super.code,
    required super.title,
    super.selectable,
    super.parentCode,
    super.selected,
  });

  factory EmdadServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return EmdadServiceCategoryModel(
      id: json['id'] as int? ?? 0,
      code: json['code'] as int?,
      title: json['title'] as String? ?? '',
      selectable: json['selectable'] as bool? ?? json['selected'] as bool? ?? false,
      parentCode: json['parentCode']?.toString(),
      selected: json['selected'] as bool?,
    );
  }
}
