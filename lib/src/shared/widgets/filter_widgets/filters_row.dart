import 'package:flutter/material.dart';
class FiltersRow extends StatelessWidget {
  final List<Widget> filters;
  final double spacing;

  const FiltersRow({
    super.key,
    required this.filters,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        int itemsPerRow = 2;
        if (filters.length == 1) {
          itemsPerRow = 1;
        } else if (filters.length >= 3) {
          itemsPerRow = 3;
        }

        final itemWidth =
            (width - (spacing * (itemsPerRow - 1))) / itemsPerRow;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: filters.map((filter) {
            return SizedBox(
              width: itemWidth,
              child: filter,
            );
          }).toList(),
        );
      },
    );
  }
}
