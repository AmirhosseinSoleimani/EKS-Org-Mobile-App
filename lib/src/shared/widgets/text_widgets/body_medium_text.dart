import 'package:flutter/material.dart';

class BodyMediumText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? lineHeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextDirection? textDirection;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;

  const BodyMediumText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.textAlign,
    this.lineHeight,
    this.maxLines,
    this.textOverflow ,
    this.fontWeight,
    this.textDirection = TextDirection.rtl,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: textDirection,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      style: Theme.of(context)
          .textTheme
          .bodyMedium?.copyWith(
        fontSize: fontSize,
        color: color,
        height: lineHeight,
        fontWeight: fontWeight,
      ),
    );
  }
}
