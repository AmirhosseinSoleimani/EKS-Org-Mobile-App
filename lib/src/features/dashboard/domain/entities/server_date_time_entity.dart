import '../../data/models/server_date_time_model.dart';

class ServerDateTimeEntity {
  final int milliseconds;
  final String date;
  final String time;
  final String dateTime;

  ServerDateTimeEntity({
    required this.milliseconds,
    required this.date,
    required this.time,
    required this.dateTime,
  });

  ServerDateTimeEntity copyWith({
    int? milliseconds,
    String? date,
    String? time,
    String? dateTime,
  }) {
    return ServerDateTimeEntity(
      milliseconds: milliseconds ?? this.milliseconds,
      date: date ?? this.date,
      time: time ?? this.time,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  ServerDateTimeModel toModel() {
    return ServerDateTimeModel(
      milliseconds: milliseconds,
      date: date,
      time: time,
      dateTime: dateTime,
    );
  }
}
