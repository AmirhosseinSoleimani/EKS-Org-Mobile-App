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
      color: Color(0xFF188544),
      description: 'سطح بالاترین عملکرد',
    );
  }
  if (normalized.contains('عالی')) {
    return const GradePatternLevelStyle(
      title: 'عالی',
      color: Color(0xFF4CAF50),
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
      color: Color(0xFFD08A00),
      description: 'نیاز به نظارت دوره‌ای',
    );
  }
  if (normalized.contains('بهبود')) {
    return const GradePatternLevelStyle(
      title: 'نیاز به بهبود',
      color: Color(0xFFA65A00),
      description: 'تحت بررسی و هشدار',
    );
  }
  if (normalized.contains('مرز')) {
    return const GradePatternLevelStyle(
      title: 'در مرز بحران',
      color: Color(0xFFE30613),
      description: 'عدم انطباق با استانداردها',
    );
  }
  if (normalized.contains('بحران')) {
    return const GradePatternLevelStyle(
      title: 'بحرانی',
      color: Color(0xFFE30613),
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
