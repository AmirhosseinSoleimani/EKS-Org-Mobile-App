import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

import 'indicator_filter_button.dart';

class IndicatorFiltersRow extends StatelessWidget {
  const IndicatorFiltersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IndicatorFilterButton(
          title: "فیلتر بر اساس تاریخ",
          onTap: () {},
        ),
        Space.w16,
        IndicatorFilterButton(
          title: "نوع خدمت",
          onTap: () {},
        ),
      ],
    );
  }
}
