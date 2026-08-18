import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_event_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_group_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class ControlTimelineSection extends StatelessWidget {
  final ControlGroupEntity? data;
  final Color activeColor;
  final Color inactiveColor;
  final String titleStart;
  final String titleArrived;
  final String titleFinished;

  const ControlTimelineSection({
    required this.data,
    required this.activeColor,
    this.inactiveColor = Colors.grey,
    this.titleStart = 'حرکت کرده',
    this.titleArrived = 'رسیده است',
    this.titleFinished = 'اتمام کار',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      _StepItem(
        event: data?.emdadgarStartedDriving,
        title: titleStart,
        icon: Icons.edit,
      ),
      _StepItem(
        event: data?.emdadgarArrived,
        title: titleArrived,
        icon: Icons.location_on,
      ),
      _StepItem(
        event: data?.jobDone,
        title: titleFinished,
        icon: Icons.check,
      ),
    ];

    final timesBetween = [
      data?.durationFromStartDrivingToArrived,
      data?.durationFromArrivedToJobDone,
    ];

    return Column(
      children: List.generate(steps.length * 2 - 1, (index) {
        final isStep = index.isEven;

        if (isStep) {
          final stepIndex = index ~/ 2;
          return _StepRow(
            item: steps[stepIndex],
            activeColor: activeColor,
          );
        }

        final lineIndex = (index - 1) ~/ 2;
        final prevActive = steps[lineIndex].event != null;
        final nextActive = steps[lineIndex + 1].event != null;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: _LineRow(
            isActive: prevActive && nextActive,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            text: timesBetween[lineIndex],
          ),
        );
      }),
    );
  }
}

class _StepItem {
  final IconData icon;
  final ControlEventEntity? event;
  final String title;

  bool get hasValue => event != null;

  _StepItem({
    required this.event,
    required this.title,
    required this.icon,
  });
}

class _StepRow extends StatelessWidget {
  final _StepItem item;
  final Color activeColor;

  const _StepRow({
    required this.item,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final event = item.event;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 36,
          child: Center(
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: item.hasValue ? activeColor : Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.hasValue)
                BodySmallText(
                  text:
                      "${event?.authorFullName ?? ''} | ${event?.followUpDateJalali ?? ''} - ${event?.followUpTime ?? ''}",
                ),
              if (item.hasValue) Space.h4,
              TitleLargeText(
                text: item.hasValue ? item.title : 'ثبت نشده',
                fontSize: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LineRow extends StatelessWidget {
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final String? text;

  const _LineRow({
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : inactiveColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 36,
          child: Center(
            child: Container(
              width: 2,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        _TimeLabel(text: text, color: color),
      ],
    );
  }
}

class _TimeLabel extends StatelessWidget {
  final String? text;
  final Color color;

  const _TimeLabel({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) {
      return const SizedBox(height: 36);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.hourglass_bottom, size: 14, color: color),
          const SizedBox(width: 4),
          BodySmallText(text: text!),
        ],
      ),
    );
  }
}
