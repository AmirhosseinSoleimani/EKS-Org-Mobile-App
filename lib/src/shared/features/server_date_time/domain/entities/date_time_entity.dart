import '../../data/models/date_time_model.dart';

class DateTimeEntity {
  final int milliseconds;
  final String date;
  final String time;
  final String dateTime;

  DateTimeEntity({
    required this.milliseconds,
    required this.date,
    required this.time,
    required this.dateTime,
  });

  DateTimeEntity copyWith({
    int? milliseconds,
    String? date,
    String? time,
    String? dateTime,
  }) {
    return DateTimeEntity(
      milliseconds: milliseconds ?? this.milliseconds,
      date: date ?? this.date,
      time: time ?? this.time,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  DateTimeModel toModel() {
    return DateTimeModel(
      milliseconds: milliseconds,
      date: date,
      time: time,
      dateTime: dateTime,
    );
  }
}
