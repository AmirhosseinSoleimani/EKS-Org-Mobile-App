import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/server_date_time_entity.dart';

class ServerDateTimeModel extends ServerDateTimeEntity {
  ServerDateTimeModel({
    required super.milliseconds,
    required super.date,
    required super.time,
    required super.dateTime,
  });

  factory ServerDateTimeModel.fromJson(Map<String, dynamic> json) {
    return ServerDateTimeModel(
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
