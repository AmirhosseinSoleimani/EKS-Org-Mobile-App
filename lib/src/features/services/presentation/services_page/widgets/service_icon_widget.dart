import 'package:flutter/material.dart';

class ServiceIconWidget extends StatelessWidget {
  final String imagePath;
  final Color iconColor;
  final Color backgroundColor;

  const ServiceIconWidget({
    super.key,
    required this.imagePath,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor.withAlpha(40),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        imagePath,
        width: 48,
        height: 48,
        fit: BoxFit.contain,
      ),
    );
  }
}
