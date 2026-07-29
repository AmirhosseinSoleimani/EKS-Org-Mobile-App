import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class SpecialPlanProductEntity implements DropdownItem<int> {
  const SpecialPlanProductEntity({
    required this.id,
    required this.title,
    this.code,
    this.serviceTypeTitle,
    this.allowedForSpecialPlanInfo = false,
    this.isActive = true,
  });

  final int id;
  final String title;
  final String? code;
  final String? serviceTypeTitle;
  final bool allowedForSpecialPlanInfo;
  final bool isActive;

  @override
  String get label => title;

  @override
  int get value => id;

  @override
  Widget? leading(BuildContext context) => null;
}
