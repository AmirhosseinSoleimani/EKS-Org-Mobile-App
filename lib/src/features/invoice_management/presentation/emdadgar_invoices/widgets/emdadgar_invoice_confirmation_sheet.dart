import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/theme/app_semantic_colors.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class EmdadgarInvoiceConfirmationSheet extends StatelessWidget {
  const EmdadgarInvoiceConfirmationSheet({
    super.key,
    required this.onConfirm,
    required this.selectedCount,
  });

  final VoidCallback onConfirm;
  final int selectedCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semanticColors = theme.extension<AppSemanticColors>()!;
    final successColor = theme.colorScheme.onError;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppSize.s64,
          height: AppSize.s64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(theme.colorScheme.onPrimary, successColor, .14),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.fact_check_outlined,
            color: successColor,
            size: AppSize.s32,
          ),
        ),
        Space.h24,
        Text(
          'تایید صورت وضعیت‌ها',
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
        Space.h12,
        Text(
          'آیا از تایید $selectedCount صورت وضعیت انتخاب شده اطمینان دارید؟',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Space.h24,
        InkwellButtonWidget(
          title: 'تایید',
          backgroundColor: semanticColors.confirmation,
          onTap: onConfirm,
        ),
        Space.h12,
        InkwellButtonWidget(
          title: 'انصراف',
          backgroundColor: theme.colorScheme.onPrimary,
          titleColor: theme.colorScheme.onSurfaceVariant,
          borderColor: theme.dividerColor,
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
