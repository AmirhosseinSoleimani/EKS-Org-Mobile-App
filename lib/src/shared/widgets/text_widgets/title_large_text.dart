import 'package:flutter/material.dart';

class TitleLargeText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final TextDirection? textDirection;

  const TitleLargeText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.textAlign,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: textDirection,
      textAlign: textAlign,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontSize: fontSize, color: color),
    );
  }
}