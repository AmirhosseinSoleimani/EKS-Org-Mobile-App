import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';

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
      fromDate: JalaliDateHelper.formatServerDateOnly(from),
      toDate: JalaliDateHelper.formatServerDateOnly(today),
    );
  }
}
