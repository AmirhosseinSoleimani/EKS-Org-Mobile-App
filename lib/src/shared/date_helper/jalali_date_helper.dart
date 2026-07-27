import 'package:shamsi_date/shamsi_date.dart';

class JalaliDateHelper {
  static Jalali? _parseJalali(String? date) {
    if (date == null || date.isEmpty) return null;
    try {
      final parts = date.split('/');
      if (parts.length != 3) return null;
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);
      return Jalali(year, month, day);
    } catch (_) {
      return null;
    }
  }

  static String? getSubscriptionDuration(String? startDate, String? endDate) {
    final start = _parseJalali(startDate);
    final end = _parseJalali(endDate);
    if (start == null || end == null) return null;

    final diffDays = end.toDateTime().difference(start.toDateTime()).inDays;
    final diffMonths = (diffDays / 30).floor();
    final diffYears = (diffMonths / 12).floor();

    if (diffYears >= 1) {
      return '$diffYears ساله';
    } else if (diffMonths >= 1) {
      return '$diffMonths ماهه';
    } else {
      return '$diffDays روزه';
    }
  }

  static int? getRemainingDays(String? endDate) {
    final end = _parseJalali(endDate);
    if (end == null) return null;

    final now = Jalali.now();
    final diff = end.toDateTime().difference(now.toDateTime()).inDays;
    return diff;
  }

  static String getRemainingDaysText(String? endDate) {
    final remaining = getRemainingDays(endDate);
    if (remaining == null) return 'تاریخ نامعتبر';
    if (remaining < 0) return 'منقضی شده';
    if (remaining == 0) return 'امروز منقضی می‌شود';
    return '$remaining روز دیگر';
  }

  static String? getWeekdayName(String? date) {
    final jalali = _parseJalali(date);
    if (jalali == null) return null;

    final weekdays = [
      'شنبه',
      'یک‌شنبه',
      'دوشنبه',
      'سه‌شنبه',
      'چهارشنبه',
      'پنج‌شنبه',
      'جمعه',
    ];

    return weekdays[jalali.weekDay - 1];
  }

  static DateTime? jalaliDateTimeToGregorianDateTime(DateTime? jalaliDateTime) {
    if (jalaliDateTime == null) return null;

    // اگر سال میلادی بود، همان را برگردان
    if (jalaliDateTime.year > 1700) {
      return jalaliDateTime;
    }

    final gregorian = Jalali(
      jalaliDateTime.year,
      jalaliDateTime.month,
      jalaliDateTime.day,
      jalaliDateTime.hour,
      jalaliDateTime.minute,
      jalaliDateTime.second,
    ).toGregorian();

    return DateTime(
      gregorian.year,
      gregorian.month,
      gregorian.day,
      jalaliDateTime.hour,
      jalaliDateTime.minute,
      jalaliDateTime.second,
    );
  }

  static String? formatServerDateTime(DateTime? dateTime) {
    final gregorianDateTime = jalaliDateTimeToGregorianDateTime(dateTime);
    if (gregorianDateTime == null) return null;

    final year = gregorianDateTime.year.toString().padLeft(4, '0');
    final month = gregorianDateTime.month.toString().padLeft(2, '0');
    final day = gregorianDateTime.day.toString().padLeft(2, '0');
    final hour = gregorianDateTime.hour.toString().padLeft(2, '0');
    final minute = gregorianDateTime.minute.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute';
  }

  static String? formatServerDate(String? jalaliDate) {
    final gregorianDate = _parseJalali(jalaliDate)?.toGregorian();
    if (gregorianDate == null) return null;

    final year = gregorianDate.year.toString().padLeft(4, '0');
    final month = gregorianDate.month.toString().padLeft(2, '0');
    final day = gregorianDate.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  static String? formatServerIsoDateTime(DateTime? dateTime) {
    final gregorianDateTime = jalaliDateTimeToGregorianDateTime(dateTime);
    if (gregorianDateTime == null) return null;

    final year = gregorianDateTime.year.toString().padLeft(4, '0');
    final month = gregorianDateTime.month.toString().padLeft(2, '0');
    final day = gregorianDateTime.day.toString().padLeft(2, '0');
    final hour = gregorianDateTime.hour.toString().padLeft(2, '0');
    final minute = gregorianDateTime.minute.toString().padLeft(2, '0');
    final second = gregorianDateTime.second.toString().padLeft(2, '0');

    return '$year-$month-${day}T$hour:$minute:$second';
  }

  static String formatStringJalaliDateTime(String? value) {
    final raw = value?.trim();
    if (raw == null || raw.isEmpty) return '---';

    final parts = raw.split(' ');
    if (parts.length < 2) return raw;

    final date = parts[0].replaceAll('-', '/');
    final timeParts = parts[1].split(':');

    final hour = timeParts.isNotEmpty ? timeParts[0].padLeft(2, '0') : '00';
    final minute = timeParts.length > 1 ? timeParts[1].padLeft(2, '0') : '00';

    return '${_toPersianDigits('$hour:$minute')} - ${_toPersianDigits(date)}';
  }

  static String _toPersianDigits(String value) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    var result = value;
    for (var i = 0; i < english.length; i++) {
      result = result.replaceAll(english[i], persian[i]);
    }
    return result;
  }
}
