import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlanLookupEntity implements DropdownItem {
  final int? id;
  final String? title;
  final String? name;
  final double? latitude;
  final double? longitude;
  final String? address;

  @override
  final int? value;

  const PlanLookupEntity({
    this.id,
    this.value,
    this.title,
    this.name,
    this.latitude,
    this.longitude,
    this.address,
  });

  int? get resolvedId => id ?? value;

  String get displayTitle {
    final normalizedTitle = title?.trim();
    if (normalizedTitle != null && normalizedTitle.isNotEmpty) {
      return normalizedTitle;
    }

    final normalizedName = name?.trim();
    if (normalizedName != null && normalizedName.isNotEmpty) {
      return normalizedName;
    }

    return '---';
  }

  @override
  String get label => title ?? '';

  @override
  Widget? leading(BuildContext context) => null;
}
