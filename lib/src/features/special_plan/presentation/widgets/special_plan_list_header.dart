import 'package:eks_sana_plus_org/src/shared/widgets/list_widgets/list_section_header.dart';
import 'package:flutter/material.dart';

class SpecialPlanListHeader extends StatelessWidget {
  const SpecialPlanListHeader({
    super.key,
    required this.totalCount,
  });

  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return ListSectionHeader(
      title: 'طرح‌های فعلی',
      countText: '$totalCount مورد',
    );
  }
}
