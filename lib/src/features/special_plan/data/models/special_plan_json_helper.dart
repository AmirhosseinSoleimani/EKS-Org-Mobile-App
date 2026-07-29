class SpecialPlanJsonHelper {
  const SpecialPlanJsonHelper._();

  static String? string(dynamic value) {
    final result = value?.toString().trim();
    return result == null || result.isEmpty ? null : result;
  }

  static int? integer(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  static bool? boolean(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    final normalized = value?.toString().trim().toLowerCase();
    if (normalized == 'true' || normalized == '1') return true;
    if (normalized == 'false' || normalized == '0') return false;
    return null;
  }

  static DateTime? dateTime(dynamic value) {
    final raw = value?.toString().trim();
    if (raw == null || raw.isEmpty) return null;
    return DateTime.tryParse(raw);
  }

  static DateTime? utcDateTime(dynamic value) {
    final raw = value?.toString().trim();
    if (raw == null || raw.isEmpty) return null;
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return null;
    if (parsed.isUtc || _hasTimeZone(raw)) return parsed.toLocal();
    return DateTime.utc(
      parsed.year,
      parsed.month,
      parsed.day,
      parsed.hour,
      parsed.minute,
      parsed.second,
      parsed.millisecond,
      parsed.microsecond,
    ).toLocal();
  }

  static bool _hasTimeZone(String value) {
    return value.endsWith('Z') ||
        RegExp(r'[+-]\d{2}:?\d{2}$').hasMatch(value);
  }

  static List<dynamic> records(dynamic raw) {
    if (raw is List) return raw;
    if (raw is! Map) return const [];
    final root = Map<String, dynamic>.from(raw);
    final data = root['data'] ?? root['Data'];
    if (data is List) return data;
    if (data is Map) {
      final nested = data['records'] ?? data['Records'] ??
          data['items'] ?? data['Items'];
      return nested is List ? nested : const [];
    }
    final direct = root['records'] ?? root['Records'];
    return direct is List ? direct : const [];
  }

  static int count(dynamic raw, int fallback) {
    if (raw is! Map) return fallback;
    final root = Map<String, dynamic>.from(raw);
    final data = root['data'] ?? root['Data'];
    if (data is Map) {
      return integer(data['count'] ?? data['Count'] ??
              data['totalCount'] ?? data['TotalCount']) ??
          fallback;
    }
    return integer(root['count'] ?? root['Count'] ??
            root['totalCount'] ?? root['TotalCount']) ??
        fallback;
  }
}
