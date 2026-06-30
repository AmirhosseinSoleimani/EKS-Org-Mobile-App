import 'package:flutter/material.dart';

class VerticalLineIndicator extends StatelessWidget {
  final Widget icon;
  final Color color;

  const VerticalLineIndicator({
    super.key,
    required this.icon,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        Expanded(
          child: Container(
            width: 2,
            color: color.withAlpha(100),
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color.withAlpha(150),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
