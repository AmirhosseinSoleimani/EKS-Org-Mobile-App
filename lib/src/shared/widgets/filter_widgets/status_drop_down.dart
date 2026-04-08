import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class StatusDropdown extends StatelessWidget {
  final Offset position;
  final double width;
  final VoidCallback onDismiss;
  final Function(RequestStatus) onSelect;

  const StatusDropdown({
    super.key,
    required this.position,
    required this.width,
    required this.onDismiss,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position.dy,
      left: position.dx,
      width: width,
      child: Material(
        elevation: 4,
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: RequestStatus.values.map((status) {
            return ListTile(
              title: BodySmallText(text: status.title),
              onTap: () => onSelect(status),
            );
          }).toList(),
        ),
      ),
    );
  }
}
