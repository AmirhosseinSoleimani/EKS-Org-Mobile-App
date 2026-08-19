import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_state.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/plan_info_create_page.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/plan_info_history_page.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/widgets/plan_card.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/widgets/plan_info_bottom_sheets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/report_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_filter_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
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
        if (state.status == PlanInfoStatus.error ||
            state.status == PlanInfoStatus.connectionError) {
          SnakeBarWidget.showError(context: context, message: message);
        } else if (state.status == PlanInfoStatus.loaded) {
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
              if (context.mounted) {
                SnakeBarWidget.showSuccess(
                  context: context,
                  message: 'برنامه‌ریزی با موفقیت ثبت شد',
                );
              }
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
                  return previous.activeFilter != current.activeFilter ||
                      previous.isReportLoading != current.isReportLoading;
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: _PlanToolbar(
                      cubit: cubit,
                      activeFilter: state.activeFilter,
                      isReportLoading: state.isReportLoading,
                    ),
                  );
                },
              ),
              Expanded(
                child: BlocBuilder<PlanInfoCubit, PlanInfoState>(
                  builder: (context, state) {
                    if (state.status == PlanInfoStatus.connectionError &&
                        state.items.isEmpty) {
                      return const SizedBox.expand(
                        child: Center(child: EmptyListWidget()),
                      );
                    }

                    if (state.isFirstLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final items = state.visibleItems;
                    if (items.isEmpty) {
                      return const EmptyListWidget();
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
                        itemCount: items.length + (state.hasMore ? 1 : 0),
                        separatorBuilder: (_, __) => Space.h12,
                        itemBuilder: (context, index) {
                          if (index == items.length) {
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

                          final item = items[index];

                          return PlanCard(
                            item: item,
                            onEdit: () => _openPlanForm(
                              context: context,
                              cubit: cubit,
                              item: item,
                              mode: PlanInfoCreateMode.edit,
                            ),
                            onCopy: () => _openPlanForm(
                              context: context,
                              cubit: cubit,
                              item: item,
                              mode: PlanInfoCreateMode.copy,
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
                            onHistory: () {
                              context.pushNamed(
                                PlanInfoHistoryPage.name,
                                extra: item,
                              );
                            },
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

  Future<void> _openPlanForm({
    required BuildContext context,
    required PlanInfoCubit cubit,
    required PlanInfoEntity item,
    required PlanInfoCreateMode mode,
  }) async {
    final saved = await context.pushNamed<bool>(
      PlanInfoCreatePage.name,
      extra: PlanInfoCreateArgs(
        mode: mode,
        plan: item,
      ),
    );

    if (saved == true && context.mounted) {
      await cubit.fetchPlans();
      if (context.mounted) {
        SnakeBarWidget.showSuccess(
          context: context,
          message: _successMessage(mode),
        );
      }
    }
  }

  String _successMessage(PlanInfoCreateMode mode) {
    return switch (mode) {
      PlanInfoCreateMode.create => 'برنامه‌ریزی با موفقیت ثبت شد',
      PlanInfoCreateMode.edit => 'برنامه‌ریزی با موفقیت ویرایش شد',
      PlanInfoCreateMode.copy => 'کپی برنامه‌ریزی با موفقیت ثبت شد',
    };
  }


  Future<void> _confirmDelete(
      BuildContext context,
      PlanInfoCubit cubit,
      PlanInfoEntity plan,) async {
    if (plan.id == null) return;
    await showModalBottomSheet<bool>(
      context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSize.s20)),
      ),
        builder: (_) =>
            BlocProvider.value(
                value: cubit,
                child: BlocBuilder<PlanInfoCubit, PlanInfoState>(

                  builder: (context, state) {
                    return DeleteConfirmSheet(
                      title: 'حذف برنامه ریزی',
                      message: 'آیا از حذف این مورد مطمئن هستید؟ این عمل غیرقابل بازگشت است.',
                      confirmTitle: 'حذف',
                      isSubmitting: state.status == PlanInfoStatus.submitting,
                      onConfirm: () async {
                        Navigator.of(context).pop();
                        final id = plan.resolvedId;
                        if (id != null) cubit.deletePlan(id);
                      },
                    );
                  },
                )
            )
    );
  }
}
class _PlanToolbar extends StatelessWidget {
  const _PlanToolbar({
    required this.cubit,
    required this.activeFilter,
    required this.isReportLoading,
  });

  final PlanInfoCubit cubit;
  final bool? activeFilter;
  final bool isReportLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FiltersRow(
          filters: [
            StatusFilterDropdown<bool?>(
              value: activeFilter,
              options: const [
                StatusFilterOption(value: null, label: 'همه'),
                StatusFilterOption(value: true, label: 'فعال'),
                StatusFilterOption(value: false, label: 'غیرفعال'),
              ],
              onChanged: cubit.changeActiveFilter,
            ),
            FilterButton(
              title: 'فیلترها',
              onTap: () => PlanInfoBottomSheets.showFilterSheet(
                context: context,
                cubit: cubit,
              ),
            ),
          ],
        ),
        Space.h16,
        ReportButtonWidget(
          isLoading: isReportLoading,
          onTap: () {
            if (isReportLoading) return;
            cubit.loadPlanReport();
          },
        ),
      ],
    );
  }
}
