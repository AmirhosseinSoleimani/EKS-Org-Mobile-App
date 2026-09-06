import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

enum RescuerStatusFilter implements DropdownItem<int> {
  all,
  active,
  inactive;

  @override
  int get value => index;

  @override
  String get label {
    switch (this) {
      case RescuerStatusFilter.all:
        return 'همه وضعیت‌ها';
      case RescuerStatusFilter.active:
        return 'فعال';
      case RescuerStatusFilter.inactive:
        return 'غیرفعال';
    }
  }

  bool matches(RescuerEntity item) {
    switch (this) {
      case RescuerStatusFilter.all:
        return true;
      case RescuerStatusFilter.active:
        return item.isActive == true || item.status == 1;
      case RescuerStatusFilter.inactive:
        return item.isActive != true && item.status != 1;
    }
  }

  @override
  Widget? leading(BuildContext context) {
    return null;
  }
}
