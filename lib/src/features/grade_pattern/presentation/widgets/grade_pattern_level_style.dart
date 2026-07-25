import 'package:flutter/material.dart';

class GradePatternLevelStyle {
  const GradePatternLevelStyle({
    required this.title,
    required this.color,
    required this.description,
  });

  final String title;
  final Color color;
  final String description;
}

GradePatternLevelStyle gradePatternLevelStyle(String title) {
  final normalized = title.trim();
  if (normalized.contains('ممتاز')) {
    return const GradePatternLevelStyle(
      title: 'ممتاز',
      color: Color(0xFF1B6D24),
      description: 'سطح بالاترین عملکرد',
    );
  }
  if (normalized.contains('عالی')) {
    return const GradePatternLevelStyle(
      title: 'عالی',
      color: Color(0xFF5FAF5D),
      description: 'عملکرد فراتر از انتظار',
    );
  }
  if (normalized.contains('خوب')) {
    return const GradePatternLevelStyle(
      title: 'خوب',
      color: Color(0xFF48626E),
      description: 'مطابق با استانداردهای فعلی',
    );
  }
  if (normalized.contains('متوسط')) {
    return const GradePatternLevelStyle(
      title: 'متوسط',
      color: Color(0xFFDB950C),
      description: 'نیاز به نظارت دوره‌ای',
    );
  }
  if (normalized.contains('بهبود')) {
    return const GradePatternLevelStyle(
      title: 'نیاز به بهبود',
      color: Color(0xFF964900),
      description: 'تحت بررسی و هشدار',
    );
  }
  if (normalized.contains('مرز')) {
    return const GradePatternLevelStyle(
      title: 'در مرز بحران',
      color: Color(0xFFDA0000),
      description: 'عدم انطباق با استانداردها',
    );
  }
  if (normalized.contains('بحران')) {
    return const GradePatternLevelStyle(
      title: 'بحرانی',
      color: Color(0xFFBA1A1A),
      description: 'تعلیق موقت خدمات واحد',
    );
  }
  return GradePatternLevelStyle(
    title: normalized.isEmpty ? '---' : normalized,
    color: const Color(0xFF48626E),
    description: 'بدون توضیح',
  );
}

String gradePatternNumber(num value) {
  final asDouble = value.toDouble();
  if (asDouble == asDouble.roundToDouble()) {
    return asDouble.toInt().toString();
  }
  return asDouble.toStringAsFixed(1);
}
