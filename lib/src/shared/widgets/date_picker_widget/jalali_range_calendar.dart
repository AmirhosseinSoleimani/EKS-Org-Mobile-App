import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/jalali_date_text_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class JalaliRangeCalendar extends StatefulWidget {
  const JalaliRangeCalendar({
    super.key,
    required this.selectedFromDate,
    required this.selectedToDate,
    required this.onDateSelected,
    this.initialVisibleDate,
    this.firstDate,
    this.lastDate,
  });

  final Jalali? selectedFromDate;
  final Jalali? selectedToDate;
  final Jalali? initialVisibleDate;
  final Jalali? firstDate;
  final Jalali? lastDate;
  final ValueChanged<Jalali> onDateSelected;

  @override
  State<JalaliRangeCalendar> createState() => _JalaliRangeCalendarState();
}

class _JalaliRangeCalendarState extends State<JalaliRangeCalendar> {
  static const _weekDays = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];

  late Jalali _visibleMonth;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialVisibleDate ??
        widget.selectedFromDate ??
        widget.selectedToDate ??
        Jalali.now();
    _visibleMonth = Jalali(initial.year, initial.month, 1);
  }

  @override
  void didUpdateWidget(covariant JalaliRangeCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldInitial = oldWidget.initialVisibleDate;
    final newInitial = widget.initialVisibleDate;

    if (newInitial != null && _dateKey(oldInitial) != _dateKey(newInitial)) {
      _visibleMonth = Jalali(newInitial.year, newInitial.month, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline.withAlpha(45)),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppPadding.p8,
            AppPadding.p8,
            AppPadding.p8,
            AppPadding.p12,
          ),
          child: Column(
            children: [
              _MonthHeader(
                visibleMonth: _visibleMonth,
                canGoPrevious: _canGoPrevious,
                canGoNext: _canGoNext,
                onPrevious: _showPreviousMonth,
                onNext: _showNextMonth,
              ),
              Space.h8,
              const _WeekDaysRow(labels: _weekDays),
              Space.h4,
              _DaysGrid(
                visibleMonth: _visibleMonth,
                selectedFromDate: widget.selectedFromDate,
                selectedToDate: widget.selectedToDate,
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
                onDateSelected: widget.onDateSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _canGoPrevious {
    final firstDate = widget.firstDate;
    if (firstDate == null) return true;
    return _monthKey(_visibleMonth) > _monthKey(firstDate);
  }

  bool get _canGoNext {
    final lastDate = widget.lastDate;
    if (lastDate == null) return true;
    return _monthKey(_visibleMonth) < _monthKey(lastDate);
  }

  void _showPreviousMonth() {
    if (!_canGoPrevious) return;
    setState(() => _visibleMonth = _previousMonth(_visibleMonth));
  }

  void _showNextMonth() {
    if (!_canGoNext) return;
    setState(() => _visibleMonth = _nextMonth(_visibleMonth));
  }

  int _monthKey(Jalali value) => (value.year * 100) + value.month;

  int? _dateKey(Jalali? value) {
    if (value == null) return null;
    return (value.year * 10000) + (value.month * 100) + value.day;
  }

  Jalali _previousMonth(Jalali value) {
    if (value.month == 1) return Jalali(value.year - 1, 12, 1);
    return Jalali(value.year, value.month - 1, 1);
  }

  Jalali _nextMonth(Jalali value) {
    if (value.month == 12) return Jalali(value.year + 1, 1, 1);
    return Jalali(value.year, value.month + 1, 1);
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({
    required this.visibleMonth,
    required this.canGoPrevious,
    required this.canGoNext,
    required this.onPrevious,
    required this.onNext,
  });

  final Jalali visibleMonth;
  final bool canGoPrevious;
  final bool canGoNext;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: canGoNext ? onNext : null,
          icon: const Icon(Icons.chevron_right_rounded),
        ),
        Expanded(
          child: BodyMediumText(
            text:
                '${JalaliDateTextFormatter.monthName(visibleMonth.month)} ${visibleMonth.year}',
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: canGoPrevious ? onPrevious : null,
          icon: const Icon(Icons.chevron_left_rounded),
        ),
      ],
    );
  }
}

class _WeekDaysRow extends StatelessWidget {
  const _WeekDaysRow({required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: labels
          .map(
            (label) => Expanded(
              child: BodyMediumText(
                text: label,
                textAlign: TextAlign.center,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _DaysGrid extends StatelessWidget {
  const _DaysGrid({
    required this.visibleMonth,
    required this.selectedFromDate,
    required this.selectedToDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  });

  final Jalali visibleMonth;
  final Jalali? selectedFromDate;
  final Jalali? selectedToDate;
  final Jalali? firstDate;
  final Jalali? lastDate;
  final ValueChanged<Jalali> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final leadingEmptyCells = _leadingEmptyCells(visibleMonth);
    final daysInMonth = _daysInMonth(visibleMonth);
    final cellCount = ((leadingEmptyCells + daysInMonth + 6) ~/ 7) * 7;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cellCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisExtent: AppSize.s42,
      ),
      itemBuilder: (context, index) {
        final day = index - leadingEmptyCells + 1;
        if (day < 1 || day > daysInMonth) {
          return const SizedBox.shrink();
        }

        final date = Jalali(visibleMonth.year, visibleMonth.month, day);
        return _CalendarDay(
          date: date,
          enabled: _isEnabled(date),
          isStart: _sameDate(date, selectedFromDate),
          isEnd: _sameDate(date, selectedToDate),
          isInRange: _isInRange(date),
          onTap: () => onDateSelected(date),
        );
      },
    );
  }

  bool _isEnabled(Jalali value) {
    final key = _dateKey(value);
    final firstKey = firstDate == null ? null : _dateKey(firstDate!);
    final lastKey = lastDate == null ? null : _dateKey(lastDate!);

    if (firstKey != null && key < firstKey) return false;
    if (lastKey != null && key > lastKey) return false;
    return true;
  }

  bool _isInRange(Jalali value) {
    final from = selectedFromDate;
    final to = selectedToDate;
    if (from == null || to == null) return false;

    final key = _dateKey(value);
    return key > _dateKey(from) && key < _dateKey(to);
  }

  bool _sameDate(Jalali value, Jalali? other) {
    return other != null && _dateKey(value) == _dateKey(other);
  }

  int _leadingEmptyCells(Jalali month) {
    final gregorian = month.toGregorian();
    final weekday = DateTime(
      gregorian.year,
      gregorian.month,
      gregorian.day,
    ).weekday;

    return (weekday + 1) % 7;
  }

  int _daysInMonth(Jalali month) {
    final nextMonth = month.month == 12
        ? Jalali(month.year + 1, 1, 1)
        : Jalali(month.year, month.month + 1, 1);

    final currentGregorian = month.toGregorian();
    final nextGregorian = nextMonth.toGregorian();
    final currentDate = DateTime.utc(
      currentGregorian.year,
      currentGregorian.month,
      currentGregorian.day,
    );
    final nextDate = DateTime.utc(
      nextGregorian.year,
      nextGregorian.month,
      nextGregorian.day,
    );

    return nextDate.difference(currentDate).inDays;
  }

  int _dateKey(Jalali value) {
    return (value.year * 10000) + (value.month * 100) + value.day;
  }
}

class _CalendarDay extends StatelessWidget {
  const _CalendarDay({
    required this.date,
    required this.enabled,
    required this.isStart,
    required this.isEnd,
    required this.isInRange,
    required this.onTap,
  });

  final Jalali date;
  final bool enabled;
  final bool isStart;
  final bool isEnd;
  final bool isInRange;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isBoundary = isStart || isEnd;

    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.s24),
      onTap: enabled ? onTap : null,
      child: ColoredBox(
        color: isInRange ? colorScheme.primary.withAlpha(25) : Colors.transparent,
        child: Center(
          child: AnimatedContainer(
            duration: DurationConstant.d100,
            width: AppSize.s40,
            height: AppSize.s40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isBoundary ? colorScheme.primary : Colors.transparent,
            ),
            child: BodyMediumText(
              text: date.day.toString(),
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              color: !enabled
                  ? colorScheme.onSurface.withAlpha(70)
                  : isBoundary
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
              fontWeight: isBoundary ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
