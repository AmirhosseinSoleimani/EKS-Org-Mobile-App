import 'package:flutter/material.dart';

class BodySmallText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;

  const BodySmallText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.start,
    this.textOverflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
      textAlign: textAlign,
      style: theme.textTheme.bodySmall?.copyWith(fontSize: fontSize , color: color, fontWeight: fontWeight,overflow: textOverflow,),
    );
  }
}
