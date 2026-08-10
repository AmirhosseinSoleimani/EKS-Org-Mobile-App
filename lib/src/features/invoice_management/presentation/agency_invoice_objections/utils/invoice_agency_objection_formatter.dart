import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_entity.dart';

class InvoiceAgencyObjectionFormatter {
  const InvoiceAgencyObjectionFormatter._();

  static String display(String? value, {String fallback = '---'}) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? fallback : normalized;
  }

  static String requestCode(int? value) {
    return value == null ? 'REQ----' : 'REQ-$value';
  }

  static String agency(InvoiceAgencyObjectionAgencyEntity? agency) {
    final name = agency?.agencyName?.trim();
    final code = agency?.agencyCode?.trim();

    if ((name == null || name.isEmpty) && (code == null || code.isEmpty)) {
      return '---';
    }
    if (name == null || name.isEmpty) return code!;
    if (code == null || code.isEmpty) return name;
    return '$name ($code)';
  }

  static String dateTime(String? jalaliDate, DateTime? dateTime) {
    final date = display(jalaliDate);
    if (date == '---' && dateTime == null) return date;
    if (date != '---' && date.contains(':')) return date;

    final time = dateTime == null
        ? null
        : '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    if (date == '---') return time ?? '---';
    if (time == null) return date;
    return '$date - $time';
  }
}
