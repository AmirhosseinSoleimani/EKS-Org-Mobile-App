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

  DateTime? get serverTime {
    if (time.isEmpty) return null;

    try {
      final parts = time.split(':');
      final now = DateTime.now();

      return DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
    } catch (_) {
      return null;
    }
  }
}
