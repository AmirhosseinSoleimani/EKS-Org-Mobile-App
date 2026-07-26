import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class EmdadServiceCategoryEntity implements DropdownItem<int?> {
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

  @override
  int? get value => id;

  @override
  String get label => title ?? '---';

  @override
  Widget? leading(BuildContext context) => null;

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
