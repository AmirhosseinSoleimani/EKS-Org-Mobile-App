import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_info_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/service_request_step_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class RequestTimelineSection extends StatelessWidget {
  final ControlInfoServiceRequestEntity? data;
  final Color activeColor;

  const RequestTimelineSection({
    required this.data,
    required this.activeColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      _RequestStepItem(
        step: data?.call,
        title: "تماس",
        icon: Icons.call,
      ),
      _RequestStepItem(
        step: data?.serviceRequestRegistrationBegin,
        title: "شروع ثبت",
        icon: Icons.edit_square,
      ),
      _RequestStepItem(
        step: data?.serviceRequestRegistrationFinish,
        title: "پایان ثبت",
        icon: Icons.insert_page_break_sharp,
      ),
      _RequestStepItem(
        step: data?.assignEmdadgar,
        title: "اعزام",
        icon: Icons.car_crash,
      ),
    ];

    final timesBetween = [
      data?.timeFromCallToBeginRequestRegistration,
      data?.timeFromBeginToFinishRequestRegistration,
      data?.timeFromFinishRequestRegistrationToAssignEmdadgar,
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
        } else {
          final lineIndex = (index - 1) ~/ 2;
          return _LineRow(
            isActive:
                steps[lineIndex].hasValue && steps[lineIndex + 1].hasValue,
            activeColor: activeColor,
            text: timesBetween[lineIndex],
          );
        }
      }),
    );
  }
}

class _RequestStepItem {
  final IconData icon;
  final ServiceRequestStepEntity? step;
  final String title;

  bool get hasValue => step != null;

  _RequestStepItem({
    required this.step,
    required this.title,
    required this.icon,
  });
}

//
// ---- ROW: STEP + CONTENT ----
//
class _StepRow extends StatelessWidget {
  final _RequestStepItem item;
  final Color activeColor;

  const _StepRow({
    required this.item,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final s = item.step;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // آیکن
        Container(
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

        const SizedBox(width: 12),

        // متن
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.hasValue)
                Text(
                  "${s?.authorFullname ?? ''} | ${s?.dateJalali ?? ''} - ${s?.time ?? ''}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              Text(
                item.hasValue ? item.title : "ثبت نشده",
                style: TextStyle(
                  fontSize: 14,
                  color: item.hasValue ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
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
  final String? text;

  const _LineRow({
    required this.isActive,
    required this.activeColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : Colors.grey;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 36,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
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
          BodySmallText(
            text: text!,
          ),
        ],
      ),
    );
  }
}
