import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class IndicatorFilterButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;

  const IndicatorFilterButton({
    super.key,
    required this.title,
    required this.onTap,
    this.icon = Icons.keyboard_arrow_down,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSize.s8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: BodyMediumText(
                  text: title,
                  fontSize: AppPadding.p12,
                  maxLines: 1,
                ),
              ),
              Space.w4,
              Icon(
                icon,
                size: AppSize.s24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
