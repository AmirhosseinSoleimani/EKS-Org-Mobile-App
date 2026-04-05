import 'package:flutter/material.dart';

extension NumericStringExtension on String {
  String get withoutCommas => replaceAll(',', '');

  String get withCommas {
    final numeric = withoutCommas;
    if (numeric.isEmpty || !RegExp(r'^\d+$').hasMatch(numeric)) {
      return this;
    }

    final reversed = numeric.split('').reversed.join();
    final buffer = StringBuffer();

    for (int i = 0; i < reversed.length; i++) {
      if (i != 0 && i % 3 == 0) buffer.write(',');
      buffer.write(reversed[i]);
    }

    return buffer.toString().split('').reversed.join();
  }
}


extension MobileNormalizer on String {
  String toLocalMobile() {
    if (startsWith('+98')) {
      return replaceFirst('+98', '0');
    }
    return this;
  }
}
extension Time24To12Extension on String {
  String to12HourFormat() {
    if (isEmpty) return '-';

    try {
      final parts = split(':');
      int hour = int.parse(parts[0]);
      final minute = parts.length > 1 ? parts[1] : '00';

      final isPM = hour >= 12;
      if (hour == 0) {
        hour = 12;
      } else if (hour > 12) {
        hour -= 12;
      }

      final hourStr = hour.toString().padLeft(2, '0');
      final suffix = isPM ? 'بعد از ظهر' : 'قبل از ظهر';

      return '$hourStr:$minute $suffix';
    } catch (e) {
      return this;
    }
  }
}

extension TextStyleExtension on String {

  Text headlineLarge(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text headlineMedium(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text headlineSmall(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text titleLarge(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text titleMedium(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight,  TextAlign? textAlign, int? maxLines, TextOverflow? overflow}) {
    return Text(
      this,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  Text titleSmall(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text displayLarge(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text displayMedium(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text displaySmall(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text bodyLarge(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text bodyMedium(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight, TextAlign? textAlign, int? maxLines, TextOverflow? overflow}) {
    return Text(
      this,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  Text bodySmall(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text labelLarge(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text labelMedium(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  Text labelSmall(BuildContext context, {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return Text(
      this,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

}