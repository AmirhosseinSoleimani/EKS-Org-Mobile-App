import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/pages/add_vehicle_info_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/pages/vehicle_info_history_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/pages/vehicle_info_services_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/pages/vehicle_info_tools_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_info_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_info_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/report_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_filter_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/refresh_widgets/swipe_refresh_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VehicleInfoListPage extends StatelessWidget {
  static const path = '/vehicle-info-list-page';
  static const name = 'vehicle-info-list-page';

  const VehicleInfoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VehicleInfoCubit>()
        ..loadLookups()
        ..fetchList(),
      child: const _VehicleInfoListView(),
    );
  }
}

class _VehicleInfoListView extends StatefulWidget {
  const _VehicleInfoListView();

  @override
  State<_VehicleInfoListView> createState() => _VehicleInfoListViewState();
}

class _VehicleInfoListViewState extends State<_VehicleInfoListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VehicleInfoCubit>();

    return BlocListener<VehicleInfoCubit, VehicleInfoState>(
      listener: (context, state) {
        final error = state.data.errorMessage;
        final success = state.data.successMessage;

        if (error != null && error.isNotEmpty) {
          SnakeBarWidget.showError(
            context: context,
            message: error,
          );
        }

        if (success != null && success.isNotEmpty) {
          SnakeBarWidget.showSuccess(
            context: context,
            message: success,
          );
        }
      },
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'خودروها'),
        floatingActionButton: FloatingActionButtonWidget(
          title: 'خودروی جدید',
          onPressed: () => _showAddVehicleSheet(context, cubit),
        ),
        body: ValueListenableBuilder<bool?>(
          valueListenable: cubit.pageStatusFilter,
          builder: (context, pageStatusFilter, _) {
            return BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppPadding.p16,
                        AppPadding.p16,
                        AppPadding.p16,
                        AppPadding.p0,
                      ),
                      child: _VehicleInfoTopControls(
                        state: state,
                        activeFilter: pageStatusFilter,
                        onFilter: () => _showFilter(context, cubit),
                        onStatusChanged: cubit.setPageStatusFilter,
                        onReport: cubit.loadVehicleReport,
                      ),
                    ),
                    Space.h16,
                    Expanded(
                      child: _buildContent(
                        context: context,
                        cubit: cubit,
                        state: state,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required VehicleInfoCubit cubit,
    required VehicleInfoState state,
  }) {
    final data = state.data;

    if (data.isInitialLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final items = cubit.visibleItems;
    if (items.isEmpty) {
      return SwipeRefreshContainer(
        onRefresh: () => cubit.fetchList(refresh: true),
        child: const Center(child: EmptyListWidget()),
      );
    }

    return RefreshIndicator(
      onRefresh: () => cubit.fetchList(refresh: true),
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p0,
          AppPadding.p16,
          AppPadding.p16,
        ),
        itemCount: items.length + (data.isPaginationLoading ? 1 : 0),
        separatorBuilder: (_, __) => Space.h16,
        itemBuilder: (context, index) {
          if (index >= items.length) {
            return const Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final item = items[index];

          return VehicleInfoSummaryCard(
            item: item,
            onTools: () async {
              final successMessage = await context.pushNamed<String>(
                VehicleInfoToolsPage.name,
                extra: item,
              );
              if (successMessage?.isNotEmpty == true && context.mounted) {
                SnakeBarWidget.showSuccess(context: context, message: successMessage!);
              }
            },
            onServices: () async {
              final successMessage = await context.pushNamed<String>(
                VehicleInfoServicesPage.name,
                extra: item,
              );
              if (successMessage?.isNotEmpty == true && context.mounted) {
                SnakeBarWidget.showSuccess(context: context, message: successMessage!);
              }
            },
            onDelete: item.id == null
                ? null
                : () => _confirmDelete(context, cubit, item),
            onHistory: () {
              context.pushNamed(
                VehicleInfoHistoryPage.name,
                extra: item,
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    VehicleInfoCubit cubit,
    VehicleInfoEntity item,
  ) {
    final id = item.id;
    if (id == null) return;

    DeleteConfirmSheet.show(
      context: context,
      title: 'حذف خودرو',
      message: 'آیا از حذف «${item.title}» مطمئن هستید؟',
      confirmTitle: 'حذف',
      onConfirm: () async {
        await cubit.deleteItem(id);
      },
    );
  }


  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final cubit = context.read<VehicleInfoCubit>();
    final data = cubit.state.data;

    final reachedBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - AppSize.s120;

    if (reachedBottom &&
        data.hasMore &&
        !data.isPaginationLoading &&
        !data.isInitialLoading) {
      cubit.fetchList();
    }
  }

  void _showFilter(
    BuildContext context,
    VehicleInfoCubit cubit,
  ) {
    showFilterBottomSheet<void>(
      context: context,
      builder: (_) => VehicleInfoFilterSheet(
        initialFilter: cubit.state.data.filter,
        vehicleModels: cubit.state.data.vehicleModels,
        onApply: cubit.applyFilter,
        onClear: cubit.clearFilter,
      ),
    );
  }

  Future<void> _showAddVehicleSheet(
    BuildContext context,
    VehicleInfoCubit cubit,
  ) async {
    final successMessage = await BottomSheetMessage.showFullScreenCustom<String>(
      context: context,
      content: const AddVehicleInfoPage(),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );

    if (successMessage != null && successMessage.isNotEmpty && context.mounted) {
      await cubit.fetchList(refresh: true);
      if (!context.mounted) return;
      SnakeBarWidget.showSuccess(
        context: context,
        message: successMessage,
      );
    }
  }
}

class _VehicleInfoTopControls extends StatelessWidget {
  const _VehicleInfoTopControls({
    required this.state,
    required this.activeFilter,
    required this.onFilter,
    required this.onStatusChanged,
    required this.onReport,
  });

  final VehicleInfoState state;
  final bool? activeFilter;
  final VoidCallback onFilter;
  final ValueChanged<bool?> onStatusChanged;
  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FiltersRow(
          spacing: AppSize.s12,
          filters: [
            StatusFilterDropdown<bool?>(
              value: activeFilter,
              options: const [
                StatusFilterOption(value: null, label: 'همه'),
                StatusFilterOption(value: true, label: 'فعال'),
                StatusFilterOption(value: false, label: 'غیرفعال'),
              ],
              onChanged: onStatusChanged,
            ),
            FilterButton(
              title: 'فیلترها',
              onTap: onFilter,
            ),
          ],
        ),
        Space.h16,
        ReportButtonWidget(
          isLoading: state.data.isReportLoading,
          onTap: () {
            if (state.data.isReportLoading) return;
            onReport();
          },
        ),
      ],
    );
  }

}
