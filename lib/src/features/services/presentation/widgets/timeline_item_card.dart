import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/vertical_line_indicator.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class TimelineItemCard extends StatelessWidget {
  final Widget icon;
  final List<Widget> children;
  final List<Widget> expandedChildren;

  const TimelineItemCard({
    super.key,
    required this.icon,
    required this.children,
    this.expandedChildren = const [],
  });

  @override
  Widget build(BuildContext context) {
    final expanded = ValueNotifier<bool>(false);

    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalLineIndicator(icon: icon),
            const SizedBox(width: 8),
            Expanded(
              child: _TimelineCardContainer(
                expanded: expanded,
                expandedChildren: expandedChildren,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineCardContainer extends StatelessWidget {
  final ValueNotifier<bool> expanded;
  final List<Widget> children;
  final List<Widget> expandedChildren;

  const _TimelineCardContainer({
    required this.expanded,
    required this.children,
    required this.expandedChildren,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: expanded,
        builder: (context, isExpanded, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...children,
              if (expandedChildren.isNotEmpty) ...[
                if (!isExpanded)
                  _ExpandToggleButton(
                    label: "جزئیات بیشتر",
                    icon: Icons.keyboard_arrow_down,
                    onTap: () => expanded.value = true,
                    color: colorScheme.secondary,
                  ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  height: isExpanded ? null : 0,
                  padding: isExpanded
                      ? const EdgeInsets.only(top: 12)
                      : EdgeInsets.zero,
                  child: isExpanded
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: expandedChildren,
                        )
                      : null,
                ),
                if (isExpanded)
                  _ExpandToggleButton(
                    label: "جزئیات کمتر",
                    icon: Icons.keyboard_arrow_up,
                    onTap: () => expanded.value = false,
                    color: colorScheme.secondary,
                  ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ExpandToggleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _ExpandToggleButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BodyMediumText(text: label, color: color),
            const SizedBox(width: 2),
            Icon(icon, size: 20, color: color),
          ],
        ),
      ),
    );
  }
}
