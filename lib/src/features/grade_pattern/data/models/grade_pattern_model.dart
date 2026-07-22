import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_detail_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';

class GradePatternModel extends GradePatternEntity {
  const GradePatternModel({
    super.id,
    super.code,
    super.name,
    super.details,
    super.insertDateTimeJalali,
    super.insertUserFullName,
    super.updateDateTimeJalali,
    super.updateUserFullName,
    super.isActive,
  });

  factory GradePatternModel.fromJson(Map<String, dynamic> json) {
    final rawDetails = json['details'];
    return GradePatternModel(
      id: _toInt(_read(json, 'id', 'Id')),
      code: _toInt(_read(json, 'code', 'Code')),
      name: _read(json, 'name', 'Name')?.toString(),
      insertDateTimeJalali:
          _read(json, 'insertDateTimeJalali', 'InsertDateTimeJalali')
              ?.toString(),
      insertUserFullName:
          _read(json, 'insertUserFullName', 'InsertUserFullName')?.toString(),
      updateDateTimeJalali:
          _read(json, 'updateDateTimeJalali', 'UpdateDateTimeJalali')
              ?.toString(),
      updateUserFullName:
          _read(json, 'updateUserFullName', 'UpdateUserFullName')?.toString(),
      isActive: _toBool(_read(json, 'isActive', 'IsActive')),
      details: rawDetails is List
          ? rawDetails
              .whereType<Map>()
              .map((item) => GradePatternDetailModel.fromJson(
                    Map<String, dynamic>.from(item),
                  ))
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'code': code,
      'name': name,
      'details': details.map((item) => item.toModel().toJson()).toList(),
      'insertDateTimeJalali': insertDateTimeJalali,
      'insertUserFullName': insertUserFullName,
      'updateDateTimeJalali': updateDateTimeJalali,
      'updateUserFullName': updateUserFullName,
      'isActive': isActive,
    };
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static bool _toBool(dynamic value) {
    if (value is bool) return value;
    if (value == null) return true;
    return value.toString().toLowerCase() == 'true';
  }

  static dynamic _read(
    Map<String, dynamic> json,
    String camelCaseKey,
    String pascalCaseKey,
  ) {
    return json[camelCaseKey] ?? json[pascalCaseKey];
  }
}
