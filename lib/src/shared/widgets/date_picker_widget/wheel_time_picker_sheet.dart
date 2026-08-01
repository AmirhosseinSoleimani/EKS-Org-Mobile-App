import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class WheelTimePickerSheet extends StatefulWidget {
  const WheelTimePickerSheet({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
  });

  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  @override
  State<WheelTimePickerSheet> createState() => _WheelTimePickerSheetState();
}

class _WheelTimePickerSheetState extends State<WheelTimePickerSheet> {
  static const double _itemExtent = 52;
  static const int _loopMultiplier = 1000;

  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;
  late int _hour;
  late int _minute;

  @override
  void initState() {
    super.initState();
    _hour = widget.initialTime.hour;
    _minute = widget.initialTime.minute;
    _hourController = FixedExtentScrollController(
      initialItem: _initialLoopItem(_hour, 24),
    );
    _minuteController = FixedExtentScrollController(
      initialItem: _initialLoopItem(_minute, 60),
    );
  }

  int _initialLoopItem(int value, int length) {
    return (length * _loopMultiplier) + value;
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _onHourChanged(int index) {
    setState(() => _hour = index % 24);
    _notifyChanged();
  }

  void _onMinuteChanged(int index) {
    setState(() => _minute = index % 60);
    _notifyChanged();
  }

  void _notifyChanged() {
    widget.onTimeChanged(TimeOfDay(hour: _hour, minute: _minute));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TitleMediumText(
            text: 'انتخاب ساعت',
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSize.s20),
          SizedBox(
            height: _itemExtent * 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _SelectionHighlight(itemExtent: _itemExtent),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _TimeWheel(
                      controller: _hourController,
                      itemCount: 24,
                      itemExtent: _itemExtent,
                      selectedValue: _hour,
                      onSelectedItemChanged: _onHourChanged,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p12,
                      ),
                      child: BodyMediumText(
                        text: ':',
                        fontSize: AppSize.s24,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    _TimeWheel(
                      controller: _minuteController,
                      itemCount: 60,
                      itemExtent: _itemExtent,
                      selectedValue: _minute,
                      onSelectedItemChanged: _onMinuteChanged,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 72,
                child: BodyMediumText(
                  text: 'ساعت',
                  fontSize: AppSize.s12,
                  color: theme.colorScheme.onSurfaceVariant,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 48),
              SizedBox(
                width: 72,
                child: BodyMediumText(
                  text: 'دقیقه',
                  fontSize: AppSize.s12,
                  color: theme.colorScheme.onSurfaceVariant,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeWheel extends StatelessWidget {
  const _TimeWheel({
    required this.controller,
    required this.itemCount,
    required this.itemExtent,
    required this.selectedValue,
    required this.onSelectedItemChanged,
  });

  final FixedExtentScrollController controller;
  final int itemCount;
  final double itemExtent;
  final int selectedValue;
  final ValueChanged<int> onSelectedItemChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 72,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: itemExtent,
        diameterRatio: 1.55,
        perspective: 0.003,
        physics: const FixedExtentScrollPhysics(),
        overAndUnderCenterOpacity: 0.35,
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List<Widget>.generate(itemCount, (index) {
            final isSelected = index == selectedValue;
            return Center(
              child: BodyMediumText(
                text: index.toString().padLeft(2, '0'),
                fontSize: isSelected ? AppSize.s22 : AppSize.s18,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _SelectionHighlight extends StatelessWidget {
  const _SelectionHighlight({required this.itemExtent});

  final double itemExtent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IgnorePointer(
      child: Container(
        height: itemExtent,
        width: 190,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withAlpha(140),
          borderRadius: BorderRadius.circular(AppSize.s12),
          border: Border.all(
            color: theme.colorScheme.primary.withAlpha(56),
          ),
        ),
      ),
    );
  }
}
