import 'package:eks_sana_plus_org/src/features/services/domain/entities/day_schedule_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Wrap(
      spacing: AppSize.s12,
      runSpacing: AppSize.s12,
      children: times.map((time) {
        final isSelected = time.id == selectedTime?.id;

        return _TimeItem(
          time: time,
          isSelected: isSelected,
          onTap: () => onTimeSelected(time),
        );
      }).toList(),
    );
  }
}

/*class _TimeSelectorContent extends StatelessWidget {
  final List<TimeRangeEntity> morningTimes;
  final List<TimeRangeEntity> afternoonTimes;

  const _TimeSelectorContent({
    required this.morningTimes,
    required this.afternoonTimes,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (morningTimes.isNotEmpty)
          _TimeSection(
            title: 'بازه‌های صبح',
            times: morningTimes,
            colorScheme: colorScheme,
          ),
        if (afternoonTimes.isNotEmpty)
          _TimeSection(
            title: 'بازه‌های بعد از ظهر',
            times: afternoonTimes,
            colorScheme: colorScheme,
          ),
      ],
    );
  }
}

class _TimeSection extends StatelessWidget {
  final String title;
  final List<TimeRangeEntity> times;
  final ColorScheme colorScheme;

  const _TimeSection({
    required this.title,
    required this.times,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleLargeText(
          text: title,
          fontSize: AppSize.s16,
          color: colorScheme.onTertiary,
        ),
        Space.h16,
        _TimeListView(times: times),
        Space.h16,
      ],
    );
  }
}*/

/*class _TimeListView extends StatelessWidget {
  final List<TimeRangeEntity> times;

  const _TimeListView({required this.times});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RequestDetailCubit>();
    final screenWidth = MediaQuery.of(context).size.width;
    final selectedTimeId = cubit.selectedTime?.id;

    return SizedBox(
      height: screenWidth * 0.09,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: times.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSize.s12),
        itemBuilder: (_, index) {
          final time = times[index];
          final isSelected = selectedTimeId == time.id;
          return _TimeItem(
            time: time,
            isSelected: isSelected,
            onTap: () => cubit.selectTime(time),
          );
        },
      ),
    );
  }
}*/

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
          borderRadius: BorderRadius.circular(AppSize.s16),
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
