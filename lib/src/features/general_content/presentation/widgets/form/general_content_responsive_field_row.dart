import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class GeneralContentResponsiveFieldRow extends StatelessWidget {
  const GeneralContentResponsiveFieldRow({
    super.key,
    required this.first,
    required this.second,
  });

  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < AppSize.s320) {
          return Column(
            children: [
              first,
              Space.h16,
              second,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: first),
            Space.w12,
            Expanded(child: second),
          ],
        );
      },
    );
  }
}
