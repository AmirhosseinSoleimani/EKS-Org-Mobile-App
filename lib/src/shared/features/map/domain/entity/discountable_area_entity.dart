import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class DiscountableAreaEntity implements DropdownItem<int> {
  const DiscountableAreaEntity({
    required this.id,
    required this.areaTitle,
    this.areaCityTitle,
    this.areaProvinceTitle,
  });

  final int id;
  final String areaTitle;
  final String? areaCityTitle;
  final String? areaProvinceTitle;

  String get fullTitle {
    final location = [areaProvinceTitle, areaCityTitle]
        .whereType<String>()
        .where((item) => item.trim().isNotEmpty)
        .join(' - ');
    return location.isEmpty ? areaTitle : '$areaTitle ($location)';
  }

  @override
  String get label => fullTitle;

  @override
  int get value => id;

  @override
  Widget? leading(BuildContext context) => null;
}
