import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/models/invoice_agency_objection_filter_value.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class InvoiceAgencyObjectionFilterSheet extends StatefulWidget {
  const InvoiceAgencyObjectionFilterSheet({
    super.key,
    required this.initialFilter,
    required this.onApply,
    required this.onClear,
  });

  final InvoiceAgencyObjectionFilterValue initialFilter;
  final ValueChanged<InvoiceAgencyObjectionFilterValue> onApply;
  final VoidCallback onClear;

  @override
  State<InvoiceAgencyObjectionFilterSheet> createState() =>
      _InvoiceAgencyObjectionFilterSheetState();
}

class _InvoiceAgencyObjectionFilterSheetState
    extends State<InvoiceAgencyObjectionFilterSheet> {
  late final TextEditingController _requestTrackCodeController;
  late final TextEditingController _agencyCodeController;
  late final TextEditingController _aidPerNameController;
  late final TextEditingController _fromDateController;
  late final TextEditingController _toDateController;

  Jalali? _fromDate;
  Jalali? _toDate;

  @override
  void initState() {
    super.initState();
    final filter = widget.initialFilter;

    _requestTrackCodeController = TextEditingController(
      text: filter.requestTrackCode ?? '',
    );
    _agencyCodeController = TextEditingController(
      text: filter.agencyCode ?? '',
    );
    _aidPerNameController = TextEditingController(
      text: filter.aidPerName ?? '',
    );

    _fromDate = _jalaliFromApiDate(filter.fromDate);
    _toDate = _jalaliFromApiDate(filter.toDate);
    _fromDateController = TextEditingController(text: _formatJalali(_fromDate));
    _toDateController = TextEditingController(text: _formatJalali(_toDate));
  }

  @override
  void dispose() {
    _requestTrackCodeController.dispose();
    _agencyCodeController.dispose();
    _aidPerNameController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FilterBottomSheetScaffold(
      title: 'فیلترها',
      onApply: _apply,
      onClear: _clear,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: _requestTrackCodeController,
            labelText: 'شماره درخواست',
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          Space.h12,
          DatePickerWidget(
            controller: _fromDateController,
            labelText: 'از تاریخ',
            hintText: 'انتخاب تاریخ',
            initialDate: _fromDate,
            lastDate: _toDate,
            onTap: (value) => setState(() => _fromDate = value),
          ),
          Space.h12,
          DatePickerWidget(
            controller: _toDateController,
            labelText: 'تا تاریخ',
            hintText: 'انتخاب تاریخ',
            initialDate: _toDate,
            firstDate: _fromDate,
            onTap: (value) => setState(() => _toDate = value),
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: _agencyCodeController,
            labelText: 'کد نمایندگی',
            textInputAction: TextInputAction.next,
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: _aidPerNameController,
            labelText: 'نام امدادگر',
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  void _apply() {
    widget.onApply(
      InvoiceAgencyObjectionFilterValue(
        requestTrackCode: _normalized(_requestTrackCodeController.text),
        fromDate: JalaliDateHelper.formatServerDateOnly(_fromDate?.toDateTime()),
        toDate: JalaliDateHelper.formatServerDateOnly(_toDate?.toDateTime()),
        agencyCode: _normalized(_agencyCodeController.text),
        aidPerName: _normalized(_aidPerNameController.text),
      ),
    );
    Navigator.of(context).pop();
  }

  void _clear() {
    widget.onClear();
    Navigator.of(context).pop();
  }

  String? _normalized(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? null : normalized;
  }

  Jalali? _jalaliFromApiDate(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return null;

    final parts = normalized.split(RegExp(r'[-/]'));
    if (parts.length != 3) return null;

    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);
    if (year == null || month == null || day == null) return null;

    try {
      return Gregorian(year, month, day).toJalali();
    } catch (_) {
      return null;
    }
  }

  String _formatJalali(Jalali? value) {
    if (value == null) return '';
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '${value.year}/$month/$day';
  }
}
