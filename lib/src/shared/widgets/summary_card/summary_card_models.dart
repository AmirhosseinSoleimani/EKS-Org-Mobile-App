import 'package:flutter/material.dart';

enum SummaryCardBadgePlacement {
  trailing,
  aboveTitle,
}

@immutable
class SummaryCardInfo {
  const SummaryCardInfo({
    required this.label,
    this.value,
    this.icon,
    this.iconWidget,
    this.maxLines = 1,
    this.textDirection,
    this.fallback = '---',
  }) : assert(icon != null || iconWidget != null);

  final String label;
  final String? value;
  final IconData? icon;
  final Widget? iconWidget;
  final int maxLines;
  final TextDirection? textDirection;
  final String fallback;
}

@immutable
class SummaryCardMeta {
  const SummaryCardMeta({
    required this.label,
    this.value,
    this.date,
    this.dateTextDirection,
    this.fallback = '---',
  });

  final String label;
  final String? value;
  final String? date;
  final TextDirection? dateTextDirection;
  final String fallback;
}
