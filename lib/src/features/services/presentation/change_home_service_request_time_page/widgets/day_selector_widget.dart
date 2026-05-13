import 'package:eks_sana_plus_org/src/features/services/domain/entities/day_schedule_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
class DaySelectorWidget extends StatelessWidget {
  final List<DayScheduleEntity?> days;
  final DayScheduleEntity? selectedDay;
  final ValueChanged<DayScheduleEntity> onDaySelected;

  const DaySelectorWidget({
    super.key,
    required this.days,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth * 0.22;
        final clampedWidth = itemWidth.clamp(72.0, 110.0);
        return SizedBox(
          height: clampedWidth * 1.25,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSize.s12),
            itemBuilder: (context, index) {
              final day = days[index];

              if (day == null) {
                return const SizedBox.shrink();
              }

              final isSelected = day.id == selectedDay?.id;

              return SizedBox(
                width: clampedWidth,
                child: AspectRatio(
                  aspectRatio: 0.72,
                  child: _DayItem(
                    day: day,
                    isSelected: isSelected,
                    onTap: () => onDaySelected(day),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _DayItem extends StatelessWidget {
  final DayScheduleEntity day;
  final bool isSelected;
  final VoidCallback onTap;

  const _DayItem({
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        width: screenWidth * 0.21,
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.onSecondaryContainer
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? colorScheme.onSecondaryContainer
                : colorScheme.onInverseSurface,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TitleLargeText(
              text: day.dayName ?? '',
              fontSize: AppSize.s14,
              color: isSelected
                  ? colorScheme.onPrimary
                  : colorScheme.onPrimaryFixedVariant,
            ),
            TitleLargeText(
              text: _getDayFromDateString(day.date),
              fontSize: AppSize.s20,
              color: isSelected
                  ? colorScheme.onPrimary
                  : colorScheme.onPrimaryFixedVariant,
            ),
          ],
        ),
      ),
    );
  }

  String _getDayFromDateString(String? date) {
    if (date == null || date.isEmpty) return '-';
    final parts = date.split('/');
    if (parts.length != 3) return '-';
    return parts[2];
  }
}
