import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class GradePatternEntity implements DropdownItem<int?> {
  const GradePatternEntity({
    this.id,
    this.code,
    this.name,
    this.gradeId,
    this.gradeCode,
    this.gradeTitle,
    this.gradeCoefficient,
    this.managmentCommisionPercent,
    this.details = const [],
    this.detailsJson,
    this.isActive,
  });

  final int? id;
  final int? code;
  final String? name;
  final int? gradeId;
  final String? gradeCode;
  final String? gradeTitle;
  final double? gradeCoefficient;
  final double? managmentCommisionPercent;
  final List<GradePatternEntity> details;
  final String? detailsJson;
  final bool? isActive;

  @override
  int? get value => id ?? gradeId;

  @override
  String get label => name ?? gradeTitle ?? gradeCode ?? code?.toString() ?? '---';

  @override
  Widget? leading(BuildContext context) => null;
}
