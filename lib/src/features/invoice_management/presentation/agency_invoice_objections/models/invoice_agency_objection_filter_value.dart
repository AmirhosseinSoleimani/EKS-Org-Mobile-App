class InvoiceAgencyObjectionFilterValue {
  const InvoiceAgencyObjectionFilterValue({
    this.requestTrackCode,
    this.fromDate,
    this.toDate,
    this.agencyCode,
    this.aidPerName,
  });

  final String? requestTrackCode;
  final String? fromDate;
  final String? toDate;
  final String? agencyCode;
  final String? aidPerName;

  factory InvoiceAgencyObjectionFilterValue.withDefaultDateRange({
    DateTime? now,
  }) {
    final today = now ?? DateTime.now();
    final from = today.subtract(const Duration(days: 7));

    return InvoiceAgencyObjectionFilterValue(
      fromDate: _formatApiDate(from),
      toDate: _formatApiDate(today),
    );
  }

  static String _formatApiDate(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '${value.year}-$month-$day';
  }
}
