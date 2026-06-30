

import 'package:eks_sana_plus_org/src/features/services/domain/entities/day_schedule_entity.dart';

class DayScheduleModel extends DayScheduleEntity {
  const DayScheduleModel({
    super.times,
    super.dayName,
    super.date,
    super.id,
  });

  factory DayScheduleModel.fromJson(dynamic json) {
    final itemsJson = json['dayTimes'] as List<dynamic>? ?? [];
    final times = itemsJson.map((e) => TimeRangeModel.fromJson(e)).toList();
    return DayScheduleModel(
      id: json['id'] as int?,
      date: json['date'] as String?,
      dayName: json['dayName'] as String?,
      times: times,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dayTimes'] = times.map((v) => v.toModel().toJson()).toList();
    map['dayName'] = dayName;
    map['date'] = date;
      map['id'] = id;

    return map;
  }
}

class TimeRangeModel extends TimeRangeEntity {
  const TimeRangeModel({
    super.startTime,
    super.endTime,
    super.id,
  });

  factory TimeRangeModel.fromJson(dynamic json) {
    return TimeRangeModel(
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['id'] = id;
    return map;
  }
}
