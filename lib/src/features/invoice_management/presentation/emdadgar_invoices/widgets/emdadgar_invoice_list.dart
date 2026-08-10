import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/emdadgar_invoice_summary_card.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoices/cubit/emdadgar_initial_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:flutter/material.dart';

class EmdadgarInitialInvoiceList extends StatelessWidget {
  const EmdadgarInitialInvoiceList({
    super.key,
    required this.cubit,
    required this.scrollController,
    required this.onInvoiceTap,
    required this.onOperationsTap,
  });

  final EmdadgarInitialInvoiceCubit cubit;
  final ScrollController scrollController;
  final ValueChanged<EmdadgarInvoiceRecordEntity> onInvoiceTap;
  final ValueChanged<EmdadgarInvoiceRecordEntity> onOperationsTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<EmdadgarInvoiceRecordEntity>>(
      valueListenable: cubit.itemsNotifier,
      builder: (context, items, _) {
        if (items.isEmpty) return _EmptyContent(cubit: cubit);

        return ValueListenableBuilder<Set<int>>(
          valueListenable: cubit.selectedRequestIdsNotifier,
          builder: (context, selectedIds, _) {
            return ValueListenableBuilder<bool>(
              valueListenable: cubit.paginationLoadingNotifier,
              builder: (context, loadingMore, _) {
                return RefreshIndicator(
                  onRefresh: () => cubit.fetchList(refresh: true),
                  child: ListView.separated(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: const EdgeInsets.fromLTRB(
                      AppPadding.p16,
                      AppPadding.p0,
                      AppPadding.p16,
                      AppPadding.p24,
                    ),
                    itemCount: items.length + (loadingMore ? 1 : 0),
                    separatorBuilder: (_, __) => Space.h16,
                    itemBuilder: (context, index) {
                      if (index >= items.length) {
                        return const Padding(
                          padding: EdgeInsets.all(AppPadding.p16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final item = items[index];
                      final requestId = item.identity?.serviceRequestId;

                      return EmdadgarInvoiceSummaryCard(
                        item: item,
                        selected: requestId != null &&
                            selectedIds.contains(requestId),
                        onSelectionChanged: (selected) =>
                            cubit.setItemSelected(item, selected),
                        selectionEnabled: cubit.supportsSelection,
                        onInvoiceTap: () => onInvoiceTap(item),
                        onOperationsTap: () => onOperationsTap(item),
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _EmptyContent extends StatelessWidget {
  const _EmptyContent({required this.cubit});

  final EmdadgarInitialInvoiceCubit cubit;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => cubit.fetchList(refresh: true),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 160),
          EmptyListWidget(),
        ],
      ),
    );
  }
}
