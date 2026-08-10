import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/emdadgar_invoice_stage_selector.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/invoice_list_section_header.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoices/cubit/emdadgar_initial_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/report_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/list_filter_toolbar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_filter_dropdown.dart';
import 'package:flutter/material.dart';

class EmdadgarInitialInvoiceHeader extends StatelessWidget {
  const EmdadgarInitialInvoiceHeader({
    super.key,
    required this.cubit,
    required this.onFilterTap,
  });

  final EmdadgarInitialInvoiceCubit cubit;
  final VoidCallback onFilterTap;

  static const _subscriptionOptions = <StatusFilterOption<bool?>>[
    StatusFilterOption<bool?>(value: null, label: 'همه'),
    StatusFilterOption<bool?>(value: true, label: 'مشترک'),
    StatusFilterOption<bool?>(value: false, label: 'غیر مشترک'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p16,
        AppPadding.p16,
        AppPadding.p0,
      ),
      child: Column(
        children: [
          ListFilterToolbar<bool?>(
            onFilterTap: onFilterTap,
            statusValue: cubit.filter.showSubscription,
            statusOptions: _subscriptionOptions,
            statusPlaceholder: 'وضعیت',
            onStatusChanged: cubit.setSubscriptionFilter,
          ),
          Space.h16,
          ValueListenableBuilder<bool>(
            valueListenable: cubit.reportLoadingNotifier,
            builder: (_, isLoading, __) => ReportButtonWidget(
              isLoading: isLoading,
              onTap: cubit.exportReport,
            ),
          ),
          Space.h24,
          EmdadgarInvoiceStageSelector(
            selectedStage: cubit.selectedStage,
            onChanged: cubit.setStage,
          ),
          Space.h24,
          InvoiceListSectionHeader(
            title: cubit.selectedStage.sectionTitle,
            count: cubit.totalCount,
            accentColor: theme.colorScheme.primary,
          ),
          if (cubit.supportsSelection && cubit.items.isNotEmpty) ...[
            Space.h12,
            _SelectAllRow(cubit: cubit),
          ],
          Space.h12,
        ],
      ),
    );
  }
}

class _SelectAllRow extends StatelessWidget {
  const _SelectAllRow({required this.cubit});

  final EmdadgarInitialInvoiceCubit cubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder<Set<int>>(
      valueListenable: cubit.selectedRequestIdsNotifier,
      builder: (_, __, ___) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: cubit.isAllSelected,
            activeColor: theme.colorScheme.primary,
            side: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: .55),
            ),
            onChanged: (value) => cubit.setAllSelected(value ?? false),
          ),
          Space.w8,
          Text(
            'انتخاب همه',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
