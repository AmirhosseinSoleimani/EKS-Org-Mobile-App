import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';


class LookupEntity  implements DropdownItem{
  const LookupEntity({
    required this.id,
    required this.title,
    this.latitude,
    this.longitude,
    this.address,
    this.extra,
  });

  final int id;
  final String title;
  final double? latitude;
  final double? longitude;
  final String? address;
  final Map<String, dynamic>? extra;

  @override
  String get label => title;

  @override
  Widget? leading(BuildContext context) => null;

  @override
  get value => id;
}
