import 'package:flutter/material.dart';

class DisplayLargeText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;

  const DisplayLargeText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: Theme.of(context)
          .textTheme
          .displayLarge
          ?.copyWith(fontSize: fontSize , color: color, fontWeight: FontWeight.w800),
    );
  }
}