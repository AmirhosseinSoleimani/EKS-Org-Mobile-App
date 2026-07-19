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
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor.withAlpha(40),
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        imagePath,
        width: 30,
        height: 30,
        fit: BoxFit.contain,
      ),
    );
  }
}
