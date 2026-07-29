import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class SpecialPlanFilterActions extends StatelessWidget {
  const SpecialPlanFilterActions({
    super.key,
    required this.onApply,
    required this.onClear,
  });

  final ValueChanged<BuildContext> onApply;
  final ValueChanged<BuildContext> onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: InkwellButtonWidget(
            title: 'اعمال فیلتر',
            onTap: () => onApply(context),
          ),
        ),
        Space.w12,
        Expanded(
          child: InkwellButtonWidget(
            title: 'حذف فیلتر',
            backgroundColor: theme.colorScheme.onPrimary,
            borderColor: theme.colorScheme.outline,
            titleColor: theme.colorScheme.onSurface,
            onTap: () => onClear(context),
          ),
        ),
      ],
    );
  }
}
