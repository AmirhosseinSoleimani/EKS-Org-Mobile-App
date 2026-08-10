import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/enums/emdadgar_invoice_stage.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class EmdadgarInvoiceStageSelector extends StatelessWidget {
  const EmdadgarInvoiceStageSelector({
    super.key,
    required this.selectedStage,
    required this.onChanged,
  });

  final EmdadgarInvoiceStage selectedStage;
  final ValueChanged<EmdadgarInvoiceStage> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: EmdadgarInvoiceStage.values.length,
        separatorBuilder: (_, __) => Space.w8,
        itemBuilder: (context, index) {
          final stage = EmdadgarInvoiceStage.values[index];
          return _StageChip(
            title: stage.title,
            selected: stage == selectedStage,
            onTap: stage == selectedStage ? null : () => onChanged(stage),
          );
        },
      ),
    );
  }
}

class _StageChip extends StatelessWidget {
  const _StageChip({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foreground = selected
        ? theme.colorScheme.primary
        : theme.colorScheme.onPrimaryFixed;

    return Material(
      color: selected
          ? theme.colorScheme.primary.withValues(alpha: 0.08)
          : theme.colorScheme.onPrimary,
      shape: StadiumBorder(
        side: BorderSide(
          color: selected ? Colors.transparent : theme.dividerColor,
        ),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
            vertical: AppPadding.p8,
          ),
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: foreground,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
