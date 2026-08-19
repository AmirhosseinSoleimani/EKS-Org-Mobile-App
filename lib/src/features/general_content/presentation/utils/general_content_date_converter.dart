import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class GeneralContentDateConverter {
  const GeneralContentDateConverter._();

  static String initialJalaliText({
    String? jalaliValue,
    String? gregorianValue,
  }) {
    final jalali = _datePart(jalaliValue);
    if (jalali != null) {
      return _normalizeDigits(jalali).replaceAll('-', '/');
    }

    final gregorian = _tryParseGregorian(gregorianValue);
    if (gregorian == null) return '';

    final converted = gregorian.toJalali();
    return _formatJalali(converted);
  }

  static String? toGregorianString(String? jalaliValue) {
    return JalaliDateHelper.formatServerDate(jalaliValue);
  }

  static bool isApplyDateBeforeStartDate({
    required String startDate,
    required String applyDate,
  }) {
    final start = tryParseJalali(startDate)?.toGregorian();
    final apply = tryParseJalali(applyDate)?.toGregorian();
    if (start == null || apply == null) return false;

    final startValue = DateTime(start.year, start.month, start.day);
    final applyValue = DateTime(apply.year, apply.month, apply.day);
    return applyValue.isBefore(startValue);
  }

  static Jalali? tryParseJalali(String? value) {
    final normalized = _normalizeDigits(value ?? '').replaceAll('-', '/');
    final parts = normalized.split('/');
    if (parts.length != 3) return null;

    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);
    if (year == null || month == null || day == null) return null;

    try {
      return Jalali(year, month, day);
    } catch (_) {
      return null;
    }
  }

  static Gregorian? _tryParseGregorian(String? value) {
    final datePart = _datePart(value);
    if (datePart == null) return null;

    final normalized = _normalizeDigits(datePart).replaceAll('/', '-');
    final parts = normalized.split('-');
    if (parts.length != 3) return null;

    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);
    if (year == null || month == null || day == null) return null;

    try {
      return Gregorian(year, month, day);
    } catch (_) {
      return null;
    }
  }

  static String? _datePart(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed.split(RegExp(r'[ T]')).first;
  }

  static String _formatJalali(Jalali value) {
    return '${value.year.toString().padLeft(4, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/'
        '${value.day.toString().padLeft(2, '0')}';
  }

  static String _normalizeDigits(String value) {
    const persian = '۰۱۲۳۴۵۶۷۸۹';
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    var result = value;
    for (var index = 0; index < 10; index++) {
      result = result
          .replaceAll(persian[index], index.toString())
          .replaceAll(arabic[index], index.toString());
    }
    return result;
  }
}
