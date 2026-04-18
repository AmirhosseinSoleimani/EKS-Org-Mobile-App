import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final Color color;

  const BulletPoint({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s8,
      height: AppSize.s8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
