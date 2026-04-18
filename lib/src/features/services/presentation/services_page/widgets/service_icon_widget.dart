import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ServiceIconWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const ServiceIconWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: AppSize.s24,
      ),
    );
  }
}
