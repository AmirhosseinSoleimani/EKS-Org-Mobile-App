import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/expand_toggle_button.dart';
import 'package:flutter/material.dart';

class TimelineItemCard extends StatelessWidget {

  final List<Widget> children;
  final List<Widget> expandedChildren;

  const TimelineItemCard({
    super.key,

    required this.children,
    this.expandedChildren = const [],
  });

  @override
  Widget build(BuildContext context) {
    final expanded = ValueNotifier<bool>(false);

    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 18),
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
                  ExpandToggleButton(
                    label: "جزئیات بیشتر",
                    icon: Icons.expand_more,
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
                  ExpandToggleButton(
                    label: "جزئیات کمتر",
                    icon: Icons.expand_less,
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

