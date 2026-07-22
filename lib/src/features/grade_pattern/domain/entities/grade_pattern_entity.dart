import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';

class GradePatternEntity {
  const GradePatternEntity({
    this.id,
    this.code,
    this.name,
    this.details = const [],
    this.insertDateTimeJalali,
    this.insertUserFullName,
    this.updateDateTimeJalali,
    this.updateUserFullName,
    this.isActive = true,
  });

  final int? id;
  final int? code;
  final String? name;
  final List<GradePatternDetailEntity> details;
  final String? insertDateTimeJalali;
  final String? insertUserFullName;
  final String? updateDateTimeJalali;
  final String? updateUserFullName;
  final bool isActive;

  GradePatternEntity copyWith({
    int? id,
    int? code,
    String? name,
    List<GradePatternDetailEntity>? details,
    String? insertDateTimeJalali,
    String? insertUserFullName,
    String? updateDateTimeJalali,
    String? updateUserFullName,
    bool? isActive,
  }) {
    return GradePatternEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      details: details ?? this.details,
      insertDateTimeJalali:
          insertDateTimeJalali ?? this.insertDateTimeJalali,
      insertUserFullName: insertUserFullName ?? this.insertUserFullName,
      updateDateTimeJalali:
          updateDateTimeJalali ?? this.updateDateTimeJalali,
      updateUserFullName: updateUserFullName ?? this.updateUserFullName,
      isActive: isActive ?? this.isActive,
    );
  }

  GradePatternModel toModel() {
    return GradePatternModel(
      id: id,
      code: code,
      name: name,
      details: details.map((item) => item.toModel()).toList(),
      insertDateTimeJalali: insertDateTimeJalali,
      insertUserFullName: insertUserFullName,
      updateDateTimeJalali: updateDateTimeJalali,
      updateUserFullName: updateUserFullName,
      isActive: isActive,
    );
  }
}
