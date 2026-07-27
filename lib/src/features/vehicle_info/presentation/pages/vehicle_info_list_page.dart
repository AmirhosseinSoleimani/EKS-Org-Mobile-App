import 'package:eks_sana_plus_org/src/di/di_setup.dart';
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
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
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
        body: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
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
                    onFilter: () => _showFilter(context, cubit),
                    onStatus: () => _showStatusFilter(context, cubit),
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

    if (data.items.isEmpty) {
      return const Center(
        child: EmptyListWidget(),
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
        itemCount: data.items.length + (data.isPaginationLoading ? 1 : 0),
        separatorBuilder: (_, __) => Space.h16,
        itemBuilder: (context, index) {
          if (index >= data.items.length) {
            return const Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final item = data.items[index];

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
                : () => cubit.deleteItem(item.id!),
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
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.s20),
        ),
      ),
      builder: (_) {
        return VehicleInfoFilterSheet(
          initialFilter: cubit.state.data.filter,
          vehicleModels: cubit.state.data.vehicleModels,
          onApply: cubit.applyFilter,
          onClear: cubit.clearFilter,
        );
      },
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

  void _showStatusFilter(
      BuildContext context,
      VehicleInfoCubit cubit,
      ) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.s20),
        ),
      ),
      builder: (_) {
        return _VehicleStatusSheet(
          value: cubit.state.data.filter.isActive,
          onChanged: (value) {
            final currentFilter = cubit.state.data.filter;

            cubit.applyFilter(
              currentFilter.copyWith(
                isActive: value,
                clearIsActive: value == null,
                skip: 0,
              ),
            );
          },
        );
      },
    );
  }
}
class _VehicleInfoTopControls extends StatelessWidget {
  const _VehicleInfoTopControls({
    required this.state,
    required this.onFilter,
    required this.onStatus,
    required this.onReport,
  });

  final VehicleInfoState state;
  final VoidCallback onFilter;
  final VoidCallback onStatus;
  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _HeaderButton(
                title: 'فیلترها',
                icon: Icons.keyboard_arrow_down_rounded,
                onTap: onFilter,
              ),
            ),
            Space.w12,
            Expanded(
              child: _HeaderButton(
                title: _statusTitle(state.data.filter.isActive),
                icon: Icons.keyboard_arrow_down_rounded,
                onTap: onStatus,
              ),
            ),
          ],
        ),
        Space.h16,
        _ReportButton(
          isLoading: state.data.isReportLoading,
          onTap: onReport,
        ),
      ],
    );
  }

  String _statusTitle(bool? value) {
    if (value == true) return 'فعال';
    if (value == false) return 'غیرفعال';
    return 'وضعیت';
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.s8),
      onTap: onTap,
      child: Container(
        height: AppSize.s48,
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p14,
        ),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            Icon(
              icon,
              size: AppSize.s22,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportButton extends StatelessWidget {
  const _ReportButton({
    required this.isLoading,
    required this.onTap,
  });

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        side: BorderSide(color: theme.colorScheme.onSurfaceVariant.withOpacity(0.65)),
      ),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: SizedBox(
          height: AppSize.s42,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: AppSize.s22,
                    height: AppSize.s22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'گزارش‌گیری',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Space.w8,
                      Icon(Icons.receipt_long_outlined, color: theme.colorScheme.onSurfaceVariant),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _VehicleStatusSheet extends StatelessWidget {
  const _VehicleStatusSheet({
    required this.value,
    required this.onChanged,
  });

  final bool? value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'وضعیت',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            Space.h12,
            _StatusOption(title: 'همه', selected: value == null, value: null, onChanged: onChanged),
            _StatusOption(title: 'فعال', selected: value == true, value: true, onChanged: onChanged),
            _StatusOption(title: 'غیرفعال', selected: value == false, value: false, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

class _StatusOption extends StatelessWidget {
  const _StatusOption({
    required this.title,
    required this.selected,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool selected;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: selected ? const Icon(Icons.check_rounded) : null,
      onTap: () {
        Navigator.of(context).pop();
        onChanged(value);
      },
    );
  }
}
