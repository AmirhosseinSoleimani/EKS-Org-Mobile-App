class DateRangeFilterRules {
  DateRangeFilterRules._();

  static const int maxRangeDays = 30;

  static bool isValid(DateTime from, DateTime to) {
    return !isEndBeforeStart(from, to) && !exceedsMaxRange(from, to);
  }

  static bool isEndBeforeStart(DateTime from, DateTime to) {
    return _utcDateOnly(to).isBefore(_utcDateOnly(from));
  }

  static bool exceedsMaxRange(DateTime from, DateTime to) {
    return _utcDateOnly(to).difference(_utcDateOnly(from)).inDays >
        maxRangeDays;
  }

  static DateTime maxToDate(DateTime from) {
    return DateTime(from.year, from.month, from.day).add(
      const Duration(days: maxRangeDays),
    );
  }

  static DateTime _utcDateOnly(DateTime value) {
    return DateTime.utc(value.year, value.month, value.day);
  }
}
