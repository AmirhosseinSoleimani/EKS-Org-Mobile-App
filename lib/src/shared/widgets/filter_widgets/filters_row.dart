import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class FiltersRow extends StatelessWidget {
  final List<Widget> filters;

  const FiltersRow({
    super.key,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < filters.length; i++) ...[
          filters[i],
          if (i != filters.length - 1) Space.w16,
        ]
      ],
    );
  }
}
