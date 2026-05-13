import 'package:eks_sana_plus_org/src/features/services/domain/entities/day_schedule_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class TimeSelectorWidget extends StatelessWidget {
  final List<TimeRangeEntity> times;
  final TimeRangeEntity? selectedTime;
  final ValueChanged<TimeRangeEntity> onTimeSelected;

  const TimeSelectorWidget({
    super.key,
    required this.times,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth * 0.34;

        final clampedWidth = itemWidth.clamp(90.0, 140.0);

        return SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: times.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSize.s12),
            itemBuilder: (context, index) {
              final time = times[index];

              final isSelected = time.id == selectedTime?.id;

              return SizedBox(
                width: clampedWidth,
                child: _TimeItem(
                  time: time,
                  isSelected: isSelected,
                  onTap: () => onTimeSelected(time),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _TimeItem extends StatelessWidget {
  final TimeRangeEntity time;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeItem({
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p4,
          horizontal: AppPadding.p14,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.onSecondaryContainer
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSize.s12),
          border: Border.all(
            color: isSelected
                ? colorScheme.onSecondaryContainer
                : colorScheme.onInverseSurface,
          ),
        ),
        child: Center(
          child: TitleLargeText(
            text: '${time.startTime} - ${time.endTime}',
            fontSize: AppSize.s14,
            color: isSelected
                ? colorScheme.onPrimary
                : colorScheme.onPrimaryFixedVariant,
          ),
        ),
      ),
    );
  }
}
