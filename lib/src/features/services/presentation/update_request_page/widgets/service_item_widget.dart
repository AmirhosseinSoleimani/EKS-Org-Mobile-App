import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class ServiceItemWidget extends StatelessWidget {
  final String title;
  final String status;
  final bool selected;
  final Color selectedColor;
  final Color labelColor;
  final VoidCallback onTap;

  const ServiceItemWidget({
    super.key,
    required this.title,
    required this.status,
    required this.selected,
    required this.selectedColor,
    required this.labelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSize.s12),
        decoration: BoxDecoration(
          color: selected ? selectedColor.withAlpha(120) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? selectedColor : Colors.grey.shade300,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<bool>(
              value: true,
              groupValue: selected,
              onChanged: (_) => onTap(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyMediumText(text: title),
                  const SizedBox(height: 6),
                  StatusLabel(text: status, color: labelColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
