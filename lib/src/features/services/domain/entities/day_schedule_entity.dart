

import 'package:eks_sana_plus_org/src/features/services/data/models/day_schedule_model.dart';

class DayScheduleEntity {
  final List<TimeRangeEntity> times;
  final String? dayName;
  final String? date;
  final int? id;

  const DayScheduleEntity({
    this.times = const <TimeRangeEntity>[],
    this.dayName,
    this.date,
    this.id,
  });

  DayScheduleEntity copyWith({
    List<TimeRangeEntity>? times,
    String? dayName,
    String? date,
    int? id,
  }) {
    return DayScheduleEntity(
      times: times ?? this.times,
      dayName: dayName ?? this.dayName,
      date: date ?? this.date,
      id: id ?? this.id,
    );
  }

  DayScheduleModel toModel() {
    return DayScheduleModel(
      id: id,
      date: date,
      dayName: dayName,
      times: times.map((e) => e.toModel()).toList(),
    );
  }

  String get monthAndYearTitle {
    if (date == null || date!.isEmpty) {
      return '';
    }

    final parts = date!.split('/');

    if (parts.length < 2) {
      return '';
    }

    final year = parts[0];
    final month = int.tryParse(parts[1]) ?? 0;

    const monthNames = [
      '',
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند',
    ];

    final monthName =
    month >= 1 && month <= 12
        ? monthNames[month]
        : '';

    return '$monthName $year';
  }
}

class TimeRangeEntity {
  final String? startTime;
  final String? endTime;
  final int? id;

  const TimeRangeEntity({
    this.startTime,
    this.endTime,
    this.id,
  });

  TimeRangeEntity copyWith({
    String? startTime,
    String? endTime,
    int? id,
  }) {
    return TimeRangeEntity(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      id: id ?? this.id,
    );
  }

  TimeRangeModel toModel() {
    return TimeRangeModel(
      startTime: startTime,
      endTime: endTime,
      id: id,
    );
  }
}
