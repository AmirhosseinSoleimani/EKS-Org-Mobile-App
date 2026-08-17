import 'package:flutter/material.dart';

class ExpandableSection extends StatefulWidget {
  final Widget header;
  final Widget child;
  final bool isExpanded;
  final bool hasBorder;
  final Widget? brief;

  const ExpandableSection({
    super.key,
    required this.header,
    required this.child,
    this.isExpanded = false,
    this.hasBorder = false,
    this.brief,
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
  }

  void toggle() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        border: widget.hasBorder
            ? Border.all(width: 1, color: Colors.grey.shade300)
            : null,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: toggle,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: widget.header),
                  if (!isExpanded && widget.brief != null) ...[
                    Expanded(child: widget.brief!),
                  ],
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: widget.child,
            ),
        ],
      ),
    );
  }
}
