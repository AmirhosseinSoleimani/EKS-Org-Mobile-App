

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
