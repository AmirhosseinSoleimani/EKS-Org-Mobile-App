import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_state.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/widgets/plan_info_bottom_sheets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanInfoPage extends StatelessWidget {
  static const path = '/plan-info';
  static const name = 'plan-info';

  const PlanInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PlanInfoCubit>()..init(),
      child: const _PlanInfoView(),
    );
  }
}

class _PlanInfoView extends StatelessWidget {
  const _PlanInfoView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlanInfoCubit>();

    return BlocListener<PlanInfoCubit, PlanInfoState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        final message = state.message;
        if (message == null || message.trim().isEmpty) return;

        if (state.status == PlanInfoStatus.error) {
          SnakeBarWidget.showError(context: context, message: message);
        } else {
          SnakeBarWidget.showSuccess(context: context, message: message);
        }
      },
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'مدیریت برنامه‌ریزی'),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: _PlanToolbar(cubit: cubit),
              ),
              Expanded(
                child: BlocBuilder<PlanInfoCubit, PlanInfoState>(
                  builder: (context, state) {
                    if (state.status == PlanInfoStatus.connectionError) {
                      return NoInternetBottomSheet(onRetry: cubit.fetchPlans);
                    }

                    if (state.isFirstLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.items.isEmpty) {
                      return const _EmptyPlans();
                    }

                    return RefreshIndicator(
                      onRefresh: cubit.fetchPlans,
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          AppPadding.p16,
                          AppPadding.p0,
                          AppPadding.p16,
                          AppPadding.p24,
                        ),
                        itemCount: state.items.length + (state.hasMore ? 1 : 0),
                        separatorBuilder: (_, __) => Space.h12,
                        itemBuilder: (context, index) {
                          if (index == state.items.length) {
                            return Padding(
                              padding: const EdgeInsets.all(AppPadding.p16),
                              child: state.status == PlanInfoStatus.loadingMore
                                  ? const Center(
                                child: CircularProgressIndicator(),
                              )
                                  : OutlinedButton.icon(
                                onPressed: cubit.loadMore,
                                icon: const Icon(Icons.expand_more),
                                label: const Text('نمایش موارد بیشتر'),
                              ),
                            );
                          }

                          final item = state.items[index];

                          return _PlanCard(
                            item: item,
                            onEdit: () => PlanInfoBottomSheets.showPlanForm(
                              context: context,
                              cubit: cubit,
                              plan: item,
                            ),
                            onCopy: () => PlanInfoBottomSheets.showPlanForm(
                              context: context,
                              cubit: cubit,
                              plan: item,
                              isCopy: true,
                            ),
                            onDelete: () => _confirmDelete(context, cubit, item),
                            onStatus: () => PlanInfoBottomSheets.showStatusSheet(
                              context: context,
                              cubit: cubit,
                              plan: item,
                            ),
                            onCancelRequests: () =>
                                PlanInfoBottomSheets.showCancelationSheet(
                                  context: context,
                                  cubit: cubit,
                                  plan: item,
                                ),
                            onLocation: () =>
                                PlanInfoBottomSheets.showLocationInfo(
                                  context: context,
                                  plan: item,
                                ),
                            onHistory: () => _showHistoryUnavailable(context),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(
      BuildContext context,
      PlanInfoCubit cubit,
      PlanInfoEntity plan,
      ) {
    BottomSheetMessage.showCustom(
      context: context,
      content: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Text(
          'آیا برنامه‌ریزی ${plan.title ?? '---'} حذف شود؟',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      actionWidget: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('انصراف'),
            ),
          ),
          Space.w12,
          Expanded(
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                final id = plan.resolvedId;
                if (id != null) cubit.deletePlan(id);
              },
              child: const Text('حذف'),
            ),
          ),
        ],
      ),
    );
  }

  void _showHistoryUnavailable(BuildContext context) {
    SnakeBarWidget.showNotice(
      context: context,
      message: 'تاریخچه این موجودیت بعد از اتصال مسیر تاریخچه نمایش داده می‌شود',
    );
  }
}

class _PlanToolbar extends StatelessWidget {
  final PlanInfoCubit cubit;

  const _PlanToolbar({required this.cubit});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkwellButtonWidget(
                title: 'افزودن برنامه‌ریزی',
                prefixIcon: const Icon(Icons.add, color: Colors.white),
                backgroundColor: colorScheme.primary,
                onTap: () => PlanInfoBottomSheets.showPlanForm(
                  context: context,
                  cubit: cubit,
                ),
              ),
            ),
          ],
        ),
        Space.h8,
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => PlanInfoBottomSheets.showFilterSheet(
                  context: context,
                  cubit: cubit,
                ),
                icon: const Icon(Icons.filter_alt_outlined),
                label: const Text('جستجو و فیلتر'),
              ),
            ),
            Space.w8,
            Expanded(
              child: OutlinedButton.icon(
                onPressed: cubit.loadPlanReport,
                icon: const Icon(Icons.file_download_outlined),
                label: const Text('گزارش‌گیری'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  final PlanInfoEntity item;
  final VoidCallback onEdit;
  final VoidCallback onCopy;
  final VoidCallback onDelete;
  final VoidCallback onStatus;
  final VoidCallback onCancelRequests;
  final VoidCallback onLocation;
  final VoidCallback onHistory;

  const _PlanCard({
    required this.item,
    required this.onEdit,
    required this.onCopy,
    required this.onDelete,
    required this.onStatus,
    required this.onCancelRequests,
    required this.onLocation,
    required this.onHistory,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = item.isActive;

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    item.title ?? 'بدون عنوان',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                _StatusChip(
                  title: isActive ? 'فعال' : 'غیرفعال',
                  color: isActive ? Colors.green : colorScheme.error,
                ),
              ],
            ),
            Space.h12,
            _InfoLine(
              icon: Icons.date_range,
              text: item.dateRangeText,
            ),
            _InfoLine(
              icon: Icons.home_repair_service_outlined,
              text: item.emdadUnitName ?? '---',
            ),
            _InfoLine(
              icon: Icons.schedule,
              text: item.shiftTitle ?? '---',
            ),
            _InfoLine(
              icon: Icons.flag_outlined,
              text: item.specialPlanTitle ?? '---',
            ),
            _InfoLine(
              icon: Icons.event_seat_outlined,
              text: item.seatTypeTitle ?? '---',
            ),
            _InfoLine(
              icon: Icons.location_on_outlined,
              text: item.locationTitle ?? item.address ?? '---',
            ),
            _InfoLine(
              icon: Icons.people_outline,
              text: item.personsText,
            ),
            if ((item.reasonTitle ?? item.description) != null) ...[
              Space.h8,
              Text(
                'دلیل تغییر وضعیت: ${item.reasonTitle ?? '---'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'توضیحات: ${item.description ?? '---'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            Space.h8,
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.more_vert),
                tooltip: 'عملیات',
                onPressed: () => _showActionsSheet(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showActionsSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'عملیات برنامه‌ریزی',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Space.h16,
                _ActionTile(
                  icon: Icons.edit,
                  title: 'ویرایش',
                  onTap: onEdit,
                ),
                _ActionTile(
                  icon: Icons.copy,
                  title: 'کپی',
                  onTap: onCopy,
                ),
                _ActionTile(
                  icon: Icons.list_alt,
                  title: 'تغییر وضعیت',
                  onTap: onStatus,
                ),
                _ActionTile(
                  icon: Icons.location_on,
                  title: 'تغییر / مشاهده محل استقرار',
                  onTap: onLocation,
                ),
                _ActionTile(
                  icon: Icons.history,
                  title: 'تاریخچه',
                  onTap: onHistory,
                ),
                _ActionTile(
                  icon: Icons.cancel_outlined,
                  title: 'لغو ماموریت',
                  onTap: onCancelRequests,
                ),
                _ActionTile(
                  icon: Icons.delete_outline,
                  title: 'حذف',
                  onTap: onDelete,
                  isDestructive: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.onSurface;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoLine({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: AppSize.s18,
            color: Theme.of(context).colorScheme.primary,
          ),
          Space.w8,
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String title;
  final Color color;

  const _StatusChip({
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: color),
      ),
    );
  }
}

class _EmptyPlans extends StatelessWidget {
  const _EmptyPlans();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Text(
          'برنامه‌ریزی‌ای برای نمایش وجود ندارد.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}