import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
class ServiceItemWidget extends StatelessWidget {
  final String title;
  final String status;
  final bool selected;
  final Color selectedColor;
  final Color labelColor;
  final VoidCallback? onTap;
  final bool isSelectable;
  const ServiceItemWidget({
    super.key,
    required this.title,
    required this.status,
    required this.selected,
    required this.selectedColor,
    required this.labelColor,
    required this.onTap,
    required this.isSelectable,
  });

  @override
  Widget build(BuildContext context) {
    final disabledStyle = Colors.grey.shade300;

    return InkWell(
      onTap: isSelectable ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppSize.s4),
        padding: const EdgeInsets.all(AppSize.s12),
        decoration: BoxDecoration(
          color: selected
              ? selectedColor.withAlpha(30)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? selectedColor
                : (isSelectable ? Colors.grey.shade300 : disabledStyle),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<bool>(
              value: true,
              groupValue: selected,
              activeColor: selectedColor,
              onChanged: isSelectable ? (_) => onTap?.call() : null,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyMediumText(
                    text: title,
                    color: isSelectable ? null : disabledStyle,
                  ),
                  const SizedBox(height: 6),
                  StatusLabel(
                    text: status,
                    color: labelColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
