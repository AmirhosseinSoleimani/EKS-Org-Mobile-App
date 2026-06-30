import 'package:eks_sana_plus_org/src/features/evaluation/data/models/defect_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class DefectEntity implements DropdownItem {
  DefectEntity({
    this.id,
    this.title,
    this.code,
    this.parentId,
    this.parentCode,
    this.saipaYadakEzharCode,
    this.isActive,
  });

  int? id;
  String? title;
  int? parentId;
  int? code;
  String? saipaYadakEzharCode;
  int? parentCode;
  bool? isActive;

  DefectEntity copyWith({
    int? id,
    String? title,
    int? parentId,
    int? code,
    String? saipaYadakEzharCode,
    int? parentCode,
    bool? isActive,
  }) {
    return DefectEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      parentId: parentId ?? this.parentId,
      code: code ?? this.code,
      saipaYadakEzharCode: saipaYadakEzharCode ?? this.saipaYadakEzharCode,
      parentCode: parentCode ?? this.parentCode,
      isActive: isActive ?? this.isActive,
    );
  }

  DefectModel toModel() {
    return DefectModel(
      id: id,
      title: title,
      code: code,
      parentId: parentId,
      saipaYadakEzharCode: saipaYadakEzharCode,
      parentCode: parentCode,
      isActive: isActive,
    );
  }

  @override
  String get label => title ?? '';

  @override
  Widget? leading(BuildContext context) => null;

  @override
  get value => id ?? 0;
}
