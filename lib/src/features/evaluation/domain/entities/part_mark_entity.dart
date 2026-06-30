import 'package:eks_sana_plus_org/src/features/evaluation/data/models/part_mark_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class PartMarkEntity implements DropdownItem<String?> {
  final String? mark;
  final int? allowIllegalMarkReason;

  const PartMarkEntity({this.mark, this.allowIllegalMarkReason});

  PartMarkModel toModel() {
    return PartMarkModel(
      mark: mark,
      allowIllegalMarkReason: allowIllegalMarkReason,
    );
  }

  PartMarkEntity copyWith({String? mark, int? allowIllegalMarkReason}) {
    return PartMarkEntity(
      mark: mark ?? this.mark,
      allowIllegalMarkReason:
          allowIllegalMarkReason ?? this.allowIllegalMarkReason,
    );
  }

  @override
  String get label => mark ?? '';

  @override
  String? get value => mark;

  @override
  Widget? leading(BuildContext context) => null;
}
