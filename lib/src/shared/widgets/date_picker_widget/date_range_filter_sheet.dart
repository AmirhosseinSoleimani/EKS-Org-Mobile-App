import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/validator/date_range_filter_rules.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/jalali_date_text_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/jalali_range_calendar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

enum _DateRangePart { from, to }

class DateRangeFilterSheet extends StatefulWidget {
  const DateRangeFilterSheet({
    super.key,
    required this.onApply,
    required this.onClear,
    this.initialFromDate,
    this.initialToDate,
    this.title = 'فیلتر بر اساس تاریخ',
  });

  final DateTime? initialFromDate;
  final DateTime? initialToDate;
  final void Function(DateTime from, DateTime to) onApply;
  final VoidCallback onClear;
  final String title;

  @override
  State<DateRangeFilterSheet> createState() => _DateRangeFilterSheetState();
}

class _DateRangeFilterSheetState extends State<DateRangeFilterSheet> {
  late final TextEditingController _fromController;
  late final TextEditingController _toController;
  late final FocusNode _fromFocusNode;
  late final FocusNode _toFocusNode;

  late Jalali? _fromDate;
  late Jalali? _toDate;
  late Jalali _visibleDate;
  _DateRangePart _activePart = _DateRangePart.from;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fromDate = _toJalali(widget.initialFromDate);
    _toDate = _toJalali(widget.initialToDate);
    _visibleDate = _fromDate ?? _toDate ?? Jalali.now();

    _fromController = TextEditingController(text: _dateText(_fromDate));
    _toController = TextEditingController(text: _dateText(_toDate));
    _fromFocusNode = FocusNode();
    _toFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _fromFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _fromFocusNode.dispose();
    _toFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FilterBottomSheetScaffold(
      title: widget.title,
      heightFactor: 0.86,
      shrinkWrapContent: true,
      onApply: _apply,
      onClear: _clear,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _DateField(
                  controller: _fromController,
                  focusNode: _fromFocusNode,
                  label: 'از تاریخ',
                  onTap: () => _activate(_DateRangePart.from),
                ),
              ),
              Space.w12,
              Expanded(
                child: _DateField(
                  controller: _toController,
                  focusNode: _toFocusNode,
                  label: 'تا تاریخ',
                  onTap: () => _activate(_DateRangePart.to),
                ),
              ),
            ],
          ),
          if (_errorMessage != null) ...[
            Space.h8,
            BodySmallText(
              text: _errorMessage!,
              color: Theme.of(context).colorScheme.error,
            ),
          ],
          FilterBottomSheetScaffold.fieldGap,
          JalaliRangeCalendar(
            key: ValueKey(
              '${_visibleDate.year}-${_visibleDate.month}-${_activePart.name}',
            ),
            initialVisibleDate: _visibleDate,
            selectedFromDate: _fromDate,
            selectedToDate: _toDate,
            lastDate: _maxSelectableToDate,
            onDateSelected: _selectDate,
          ),
        ],
      ),
    );
  }

  void _activate(_DateRangePart part) {
    setState(() {
      _activePart = part;
      _errorMessage = null;

      final selectedDate = part == _DateRangePart.from ? _fromDate : _toDate;
      if (selectedDate != null) _visibleDate = selectedDate;
    });

    _focusNode(part).requestFocus();
  }

  void _selectDate(Jalali value) {
    if (_activePart == _DateRangePart.from) {
      _selectFromDate(value);
      return;
    }

    _selectToDate(value);
  }

  void _selectFromDate(Jalali value) {
    setState(() {
      _fromDate = value;
      _fromController.text = _dateText(value);
      _errorMessage = null;

      if (_toDate != null &&
          (_compareDates(_toDate!, value) < 0 ||
              _exceedsMaxRange(value, _toDate!))) {
        _toDate = null;
        _toController.clear();
      }

      _activePart = _DateRangePart.to;
      _visibleDate = value;
    });

    _toFocusNode.requestFocus();
  }

  void _selectToDate(Jalali value) {
    final fromDate = _fromDate;
    if (fromDate == null) {
      setState(() {
        _errorMessage = 'ابتدا تاریخ شروع را انتخاب کنید';
        _activePart = _DateRangePart.from;
      });
      _fromFocusNode.requestFocus();
      return;
    }

    if (_compareDates(value, fromDate) < 0) {
      setState(() {
        _errorMessage = 'تاریخ پایان نمی‌تواند قبل از تاریخ شروع باشد';
      });
      return;
    }

    if (_exceedsMaxRange(fromDate, value)) {
      setState(() {
        _errorMessage = 'بازه زمانی نمی‌تواند بیشتر از ۳۰ روز باشد';
      });
      return;
    }

    setState(() {
      _toDate = value;
      _toController.text = _dateText(value);
      _errorMessage = null;
      _visibleDate = value;
    });
  }

  void _apply() {
    final fromDate = _fromDate;
    final toDate = _toDate;

    if (fromDate == null || toDate == null) {
      setState(() {
        _errorMessage = 'انتخاب تاریخ شروع و پایان الزامی است';
      });
      return;
    }

    if (_compareDates(toDate, fromDate) < 0) {
      setState(() {
        _errorMessage = 'تاریخ پایان نمی‌تواند قبل از تاریخ شروع باشد';
      });
      return;
    }

    if (_exceedsMaxRange(fromDate, toDate)) {
      setState(() {
        _errorMessage = 'بازه زمانی نمی‌تواند بیشتر از ۳۰ روز باشد';
      });
      return;
    }

    Navigator.of(context).pop();
    widget.onApply(fromDate.toDateTime(), toDate.toDateTime());
  }

  void _clear() {
    Navigator.of(context).pop();
    widget.onClear();
  }

  FocusNode _focusNode(_DateRangePart part) {
    return part == _DateRangePart.from ? _fromFocusNode : _toFocusNode;
  }

  Jalali? get _maxSelectableToDate {
    if (_activePart != _DateRangePart.to || _fromDate == null) return null;

    return Jalali.fromDateTime(
      DateRangeFilterRules.maxToDate(_fromDate!.toDateTime()),
    );
  }

  bool _exceedsMaxRange(Jalali from, Jalali to) {
    return DateRangeFilterRules.exceedsMaxRange(
      from.toDateTime(),
      to.toDateTime(),
    );
  }

  int _compareDates(Jalali first, Jalali second) {
    return _dateKey(first).compareTo(_dateKey(second));
  }

  int _dateKey(Jalali value) {
    return (value.year * 10000) + (value.month * 100) + value.day;
  }

  Jalali? _toJalali(DateTime? value) {
    return value == null ? null : Jalali.fromDateTime(value);
  }

  String _dateText(Jalali? value) {
    return value == null ? '' : JalaliDateTextFormatter.fullDate(value);
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.onTap,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DatePickerWidget(
      controller: controller,
      focusNode: focusNode,
      labelText: label,
      hintText: 'انتخاب کنید',
      openPickerOnTap: false,
      onFieldTap: onTap,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      suffixIcon: const Icon(Icons.calendar_today_outlined, size: AppSize.s20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: BorderSide(
          color: theme.colorScheme.outline.withAlpha(45),
        ),
      ),
      focusBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        borderSide: BorderSide(
          color: theme.colorScheme.primary,
          width: AppSize.s1,
        ),
      ),
    );
  }
}
