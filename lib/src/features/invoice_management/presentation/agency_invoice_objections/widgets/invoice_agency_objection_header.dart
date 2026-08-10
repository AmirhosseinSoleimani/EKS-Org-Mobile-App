import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/cubit/invoice_agency_objection_cubit.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/invoice_list_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/report_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/list_filter_toolbar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_filter_dropdown.dart';
import 'package:flutter/material.dart';

class InvoiceAgencyObjectionHeader extends StatelessWidget {
  const InvoiceAgencyObjectionHeader({
    super.key,
    required this.cubit,
    required this.onFilterTap,
  });

  final InvoiceAgencyObjectionCubit cubit;
  final VoidCallback onFilterTap;

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
          ListFilterToolbar<int?>(
            onFilterTap: onFilterTap,
            statusValue: cubit.selectedStatus,
            statusOptions: _statusOptions,
            statusPlaceholder: 'وضعیت',
            onStatusChanged: cubit.setStatusFilter,
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
          InvoiceListSectionHeader(
            title: 'درخواست‌های فعلی',
            count: cubit.totalCount,
            accentColor: theme.colorScheme.primary,
          ),
          Space.h12,
        ],
      ),
    );
  }

  List<StatusFilterOption<int?>> get _statusOptions {
    final entries = cubit.knownStatuses.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return <StatusFilterOption<int?>>[
      const StatusFilterOption<int?>(value: null, label: 'همه'),
      ...entries.map(
        (entry) => StatusFilterOption<int?>(
          value: entry.key,
          label: entry.value,
        ),
      ),
    ];
  }
}
