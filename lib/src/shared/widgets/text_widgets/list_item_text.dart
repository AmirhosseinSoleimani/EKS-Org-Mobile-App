import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ListItemTitleText extends StatelessWidget {
  const ListItemTitleText({
    super.key,
    required this.text,
    this.maxLines = 2,
    this.textAlign,
    this.textDirection,
    this.overflow = TextOverflow.ellipsis,
  });

  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      _display(text),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textDirection: textDirection,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w700,
        fontSize: AppSize.s16,
      ),
    );
  }
}

class ListItemLabelText extends StatelessWidget {
  const ListItemLabelText({
    super.key,
    required this.text,
    this.maxLines,
    this.textAlign,
    this.textDirection,
    this.overflow = TextOverflow.ellipsis,
  });

  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textDirection: textDirection,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onTertiaryFixed,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class ListItemValueText extends StatelessWidget {
  const ListItemValueText({
    super.key,
    required this.text,
    this.maxLines,
    this.textAlign,
    this.textDirection,
    this.overflow = TextOverflow.ellipsis,
  });

  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      _display(text),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textDirection: textDirection,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onTertiaryFixed,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class ListItemMetaText extends StatelessWidget {
  const ListItemMetaText({
    super.key,
    required this.text,
    this.maxLines = 1,
    this.textAlign,
    this.textDirection,
    this.overflow = TextOverflow.ellipsis,
  });

  final String text;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      _display(text),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textDirection: textDirection,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onPrimaryFixed,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class ListItemLabelValueText extends StatelessWidget {
  const ListItemLabelValueText({
    super.key,
    required this.label,
    required this.value,
    this.fallback = '---',
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.overflow = TextOverflow.ellipsis,
  });

  final String label;
  final String? value;
  final String fallback;
  final int? maxLines;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onTertiaryFixed;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: _displayNullable(value, fallback),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}

String _display(String value) {
  final normalized = value.trim();
  return normalized.isEmpty ? '---' : normalized;
}

String _displayNullable(String? value, String fallback) {
  final normalized = value?.trim();
  return normalized == null || normalized.isEmpty ? fallback : normalized;
}
