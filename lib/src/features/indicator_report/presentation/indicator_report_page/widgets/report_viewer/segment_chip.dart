
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/view_models/parsed_segment.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class SegmentChip extends StatelessWidget {
  final ParsedSegment segment;
  final ServiceType serviceType;

  const SegmentChip({super.key,
    required this.segment,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          segment.label,
          style: textTheme.labelSmall?.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (segment.parenValue != null) ...[
              Text(
                '(${segment.parenValue})',
                style: textTheme.labelSmall?.copyWith(
                  color: serviceType.serviceColor,
                  fontSize: 10,
                ),
              ),
              const SizedBox(width: AppSize.s4),
            ],
            Text(
              segment.value,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


