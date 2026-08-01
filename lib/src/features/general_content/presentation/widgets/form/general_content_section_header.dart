import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class GeneralContentSectionHeader extends StatelessWidget {
  const GeneralContentSectionHeader({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          icon,
          color: colorScheme.primary,
          size: AppSize.s24,
        ),
        Space.w8,
        Expanded(
          child: TitleMediumText(
            text: title,
            fontWeight: FontWeight.w800,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
