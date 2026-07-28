import 'package:flutter/material.dart';

class TitleMediumText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? lineHeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;


  const TitleMediumText({
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
          .titleMedium?.copyWith(
        fontSize: fontSize,
        color: color,
        height: lineHeight,
        fontWeight: fontWeight,
      ),
    );
  }
}