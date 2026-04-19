import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/vertical_line_indicator.dart';
import 'package:flutter/material.dart';

class NonCooperationTimelineItem extends StatelessWidget {
  final Widget icon;
  final List<Widget> children;

  const NonCooperationTimelineItem({
    super.key,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticallineIndicator(icon: icon),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
