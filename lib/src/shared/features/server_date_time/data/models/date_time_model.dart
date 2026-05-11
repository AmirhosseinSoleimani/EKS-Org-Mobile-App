import 'package:eks_sana_plus_org/src/shared/features/server_date_time/domain/entities/date_time_entity.dart';

class DateTimeModel extends DateTimeEntity {
  DateTimeModel({
    required super.milliseconds,
    required super.date,
    required super.time,
    required super.dateTime,
  });

  factory DateTimeModel.fromJson(Map<String, dynamic> json) {
    return DateTimeModel(
      milliseconds: json['milliseconds'],
      date: json['date'],
      time: json['time'],
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'milliseconds': milliseconds,
      'date': date,
      'time': time,
      'dateTime': dateTime,
    };
  }
}
