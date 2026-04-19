import 'package:flutter/material.dart';

class VerticallineIndicator extends StatelessWidget {
  final Widget icon;
  final Color color;

  const VerticallineIndicator({
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
            color: color.withOpacity(0.5),
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
