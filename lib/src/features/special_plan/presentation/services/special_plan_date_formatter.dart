import 'package:shamsi_date/shamsi_date.dart';

class SpecialPlanDateFormatter {
  const SpecialPlanDateFormatter._();

  static String jalaliDate(DateTime? date) {
    if (date == null) return '---';
    final formatter = Jalali.fromDateTime(date.toLocal()).formatter;
    return '${formatter.yyyy}/${formatter.mm}/${formatter.dd}';
  }

  static String jalaliDateTime(DateTime? date) {
    if (date == null) return '---';
    final local = date.toLocal();
    final formatter = Jalali.fromDateTime(local).formatter;
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '${formatter.yyyy}/${formatter.mm}/${formatter.dd} - $hour:$minute';
  }

  static int? remainingDays(DateTime? endDate) {
    if (endDate == null) return null;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final localEnd = endDate.toLocal();
    final end = DateTime(localEnd.year, localEnd.month, localEnd.day);
    return end.difference(today).inDays;
  }
}
