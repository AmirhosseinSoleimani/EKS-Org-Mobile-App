import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class JalaliDateTextFormatter {
  JalaliDateTextFormatter._();

  static const List<String> _monthNames = [
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

  static String monthName(int month) => _monthNames[month - 1];

  static String fullDate(Jalali date) {
    return '${date.day} ${monthName(date.month)} ${date.year}';
  }

  static String compactRange(DateTime from, DateTime to) {
    final fromJalali = Jalali.fromDateTime(from);
    final toJalali = Jalali.fromDateTime(to);

    if (fromJalali.year == toJalali.year &&
        fromJalali.month == toJalali.month) {
      final month = monthName(fromJalali.month);
      return '${fromJalali.day} $month تا ${toJalali.day} $month';
    }

    return '${fromJalali.day} ${monthName(fromJalali.month)} تا '
        '${toJalali.day} ${monthName(toJalali.month)}';
  }
}
