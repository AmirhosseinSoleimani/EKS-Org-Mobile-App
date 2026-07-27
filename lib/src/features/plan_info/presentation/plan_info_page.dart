import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_state.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/plan_info_create_page.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/widgets/plan_card.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/widgets/plan_info_bottom_sheets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'plan_info_location_page.dart';

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
        floatingActionButton: FloatingActionButtonWidget(
          title: 'برنامه ریزی جدید',
          onPressed: () async {
            final created = await context.pushNamed<bool>(
              PlanInfoCreatePage.name,
            );
            if (created == true && context.mounted) {
              await cubit.fetchPlans();
            }
          },
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: Column(
            children: [
              BlocBuilder<PlanInfoCubit, PlanInfoState>(
                buildWhen: (previous, current) {
                  return previous.activeFilter != current.activeFilter;
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: _PlanToolbar(
                      cubit: cubit,
                      activeFilter: state.activeFilter,
                    ),
                  );
                },
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

                          return PlanCard(
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
                            onLocation: () async {
                              final changed = await context.pushNamed<bool>(
                                PlanInfoLocationPage.name, extra: item,);
                              if (changed == true && context.mounted) {
                                await cubit.fetchPlans();
                              }
                            },
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
  const _PlanToolbar({
    required this.cubit,
    required this.activeFilter,
  });

  final PlanInfoCubit cubit;
  final bool? activeFilter;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        FiltersRow(
          filters: [
            FilterButton(
              title: 'جستجو و فیلتر',
              onTap: () => PlanInfoBottomSheets.showFilterSheet(
                context: context,
                cubit: cubit,
              ),
            ),
            FilterButton(
              title: _getStatusTitle(activeFilter),
              overlayBuilder: (
                  overlayContext,
                  position,
                  width,
                  dismiss,
                  ) {
                return Positioned(
                  top: position.dy + 52,
                  left: position.dx,
                  width: width,
                  child: Material(
                    color: Colors.white,
                    elevation: 6,
                    borderRadius: BorderRadius.circular(8),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _StatusFilterItem(
                          title: 'همه',
                          isSelected: activeFilter == null,
                          onTap: () {
                            dismiss();
                            cubit.changeActiveFilter(null);
                          },
                        ),
                        _StatusFilterItem(
                          title: 'فعال',
                          isSelected: activeFilter == true,
                          onTap: () {
                            dismiss();
                            cubit.changeActiveFilter(true);
                          },
                        ),
                        _StatusFilterItem(
                          title: 'غیرفعال',
                          isSelected: activeFilter == false,
                          onTap: () {
                            dismiss();
                            cubit.changeActiveFilter(false);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        Space.h16,
        InkwellButtonWidget(
          title: 'گزارش گیری',
          titleColor: colorScheme.onPrimaryFixed,
          prefixIcon: SvgWidget(
            src: SvgAsset(SvgManager.exportNotes),
          ),
          backgroundColor: colorScheme.secondaryContainer,
          borderColor: colorScheme.onPrimaryFixed,
          borderWidth: 2,
          onTap: cubit.loadPlanReport,
        ),
      ],
    );
  }

  String _getStatusTitle(bool? status) {
    return switch (status) {
      true => 'فعال',
      false => 'غیرفعال',
      null => 'همه وضعیت‌ها',
    };
  }
}


class _StatusFilterItem extends StatelessWidget {
  const _StatusFilterItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                size: 18,
                color: colorScheme.primary,
              ),
          ],
        ),
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
