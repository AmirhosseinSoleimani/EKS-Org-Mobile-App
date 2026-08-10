
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoices/cubit/emdadgar_initial_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/theme/app_semantic_colors.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class EmdadgarSelectedItemsBar extends StatelessWidget {
  const EmdadgarSelectedItemsBar({
    super.key,
    required this.cubit,
    required this.onConfirmTap,
  });

  final EmdadgarInitialInvoiceCubit cubit;
  final VoidCallback onConfirmTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semanticColors = theme.extension<AppSemanticColors>()!;

    return ValueListenableBuilder<Set<int>>(
      valueListenable: cubit.selectedRequestIdsNotifier,
      builder: (context, selectedIds, _) {
        if (selectedIds.isEmpty) return const SizedBox.shrink();

        return SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              AppPadding.p16,
              AppPadding.p12,
              AppPadding.p16,
              AppPadding.p16,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              border: Border(top: BorderSide(color: theme.dividerColor)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${selectedIds.length} مورد انتخاب شده',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
                  width: AppSize.s150,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: cubit.confirmLoadingNotifier,
                    builder: (_, isLoading, __) => InkwellButtonWidget(
                      title: 'تایید',
                      backgroundColor: semanticColors.confirmation,
                      showLoading: isLoading,
                      onTap: onConfirmTap,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
