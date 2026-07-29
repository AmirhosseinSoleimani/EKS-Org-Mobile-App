import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/cubit/special_plan_list_cubit.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/cubit/special_plan_list_state.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/cubit/special_plan_report_cubit.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/cubit/special_plan_report_state.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/pages/special_plan_form_page.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_action_sheet.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_card.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_filters_row.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_list_header.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SpecialPlanPage extends StatelessWidget {
  static const path = '/special-plan-page';
  static const name = 'special-plan-page';

  const SpecialPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<SpecialPlanListCubit>()..init(),
        ),
        BlocProvider(
          create: (_) => getIt<SpecialPlanReportCubit>(),
        ),
      ],
      child: const _SpecialPlanView(),
    );
  }
}

class _SpecialPlanView extends StatefulWidget {
  const _SpecialPlanView();

  @override
  State<_SpecialPlanView> createState() => _SpecialPlanViewState();
}

class _SpecialPlanViewState extends State<_SpecialPlanView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SpecialPlanListCubit>();
    return BlocListener<SpecialPlanReportCubit, SpecialPlanReportState>(
      listener: (context, state) {
        final cubit = context.read<SpecialPlanReportCubit>();
        final error = state.errorMessage;
        if (error?.trim().isNotEmpty == true) {
          SnakeBarWidget.showError(context: context, message: error!);
          cubit.clearErrorMessage();
        }
        final success = state.successMessage;
        if (success?.trim().isNotEmpty == true) {
          SnakeBarWidget.showSuccess(context: context, message: success!);
          cubit.clearSuccessMessage();
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<SpecialPlanListCubit, SpecialPlanListState>(
          listener: (context, state) {
            final error = state.errorMessage;
            if (error?.trim().isNotEmpty == true) {
              SnakeBarWidget.showError(context: context, message: error!);
              cubit.clearErrorMessage();
            }
            final success = state.successMessage;
            if (success?.trim().isNotEmpty == true) {
              SnakeBarWidget.showSuccess(context: context, message: success!);
              cubit.clearSuccessMessage();
            }
          },
          builder: (context, state) {
            final theme = Theme.of(context);
            return Scaffold(
              backgroundColor: theme.colorScheme.surface,
              appBar: const SimpleActionBar(title: 'طرح‌ها'),
              floatingActionButton: FloatingActionButtonWidget(
                title: 'طرح جدید',
                onPressed: () => _openCreateForm(context, cubit),
              ),
              body: Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SpecialPlanFiltersRow(cubit: cubit, state: state),
                    Space.h12,
                    BlocBuilder<SpecialPlanReportCubit,
                        SpecialPlanReportState>(
                      builder: (context, reportState) {
                        return InkwellButtonWidget(
                          title: 'گزارش گیری',
                          titleColor: theme.colorScheme.onPrimaryFixed,
                          showLoading: reportState.isLoading,
                          loadingColor: theme.colorScheme.onPrimaryFixed,
                          prefixIcon: SvgWidget(src: SvgAsset(SvgManager.exportNotes)),
                          backgroundColor: theme.colorScheme.secondaryContainer,
                          borderColor: theme.colorScheme.onPrimaryFixed,
                          borderWidth: 2,
                          onTap: () {
                            if (reportState.isLoading) return;
                            context.read<SpecialPlanReportCubit>().export(
                              filter: cubit.reportFilter,
                              cachedProducts: cubit.state.products,
                            );
                          },
                        );
                      },
                    ),
                    Space.h16,
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.stylus,
                          },
                        ),
                        child: _SpecialPlanList(
                          controller: _scrollController,
                          state: state,
                          onRetry: () => cubit.fetchList(reset: true),
                          onRefresh: cubit.refresh,
                          onLoadMore: () => cubit.fetchList(),
                          onActions: (item) => _openActions(context, item),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _openCreateForm(
    BuildContext context,
    SpecialPlanListCubit cubit,
  ) async {
    final changed = await context.pushNamed(SpecialPlanFormPage.name);
    if (changed != true || !context.mounted) return;
    await cubit.refresh();
    if (!context.mounted) return;
    SnakeBarWidget.showSuccess(context: context, message: 'طرح ثبت شد.');
  }

  void _openActions(BuildContext pageContext, SpecialPlanEntity item) {
    final cubit = pageContext.read<SpecialPlanListCubit>();
    BottomSheetMessage.showCustom(
      context: pageContext,
      backgroundColor: Theme.of(pageContext).colorScheme.onPrimary,
      actionWidget: const SizedBox.shrink(),
      content: BlocBuilder<SpecialPlanListCubit, SpecialPlanListState>(
        bloc: cubit,
        builder: (sheetContext, state) {
          final isDeleting = state.deletingId == item.id;
          return SpecialPlanActionSheet(
            isDeleting: isDeleting,
            onEdit: () async {
              if (isDeleting) return;
              Navigator.of(sheetContext).pop();
              final changed = await pageContext.pushNamed(
                SpecialPlanFormPage.name,
                extra: SpecialPlanFormPageArgs(plan: item),
              );
              if (changed != true || !pageContext.mounted) return;
              await cubit.refresh();
              if (!pageContext.mounted) return;
              SnakeBarWidget.showSuccess(
                context: pageContext,
                message: 'طرح ویرایش شد.',
              );
            },
            onDelete: () {
              if (isDeleting) return;
              Navigator.of(sheetContext).pop();
              _confirmDelete(pageContext, item, cubit);
            },
          );
        },
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    SpecialPlanEntity item,
    SpecialPlanListCubit cubit,
  ) {
    var isSubmitting = false;
    BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      actionWidget: const SizedBox.shrink(),
      content: StatefulBuilder(
        builder: (sheetContext, setSheetState) {
          return DeleteConfirmSheet(
            title: 'حذف طرح',
            message: 'آیا از حذف «${item.title ?? 'این طرح'}» مطمئن هستید؟',
            confirmTitle: 'حذف طرح',
            isSubmitting: isSubmitting,
            onConfirm: () async {
              if (isSubmitting) return;
              setSheetState(() => isSubmitting = true);
              final deleted = await cubit.deletePlan(item);
              if (sheetContext.mounted && deleted) {
                Navigator.of(sheetContext).pop(true);
                return;
              }
              if (sheetContext.mounted) {
                setSheetState(() => isSubmitting = false);
              }
            },
          );
        },
      ),
    );
  }
}

class _SpecialPlanList extends StatelessWidget {
  const _SpecialPlanList({
    required this.controller,
    required this.state,
    required this.onRetry,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onActions,
  });

  final ScrollController controller;
  final SpecialPlanListState state;
  final VoidCallback onRetry;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final ValueChanged<SpecialPlanEntity> onActions;

  @override
  Widget build(BuildContext context) {
    if (state.isInitialLoading) {
      return const Center(child: LoadingWidget());
    }
    if ((state.status == SpecialPlanViewStatus.failure ||
            state.status == SpecialPlanViewStatus.connectionError) &&
        state.records.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmptyListWidget(),
            Space.h12,
            TextButton(
              onPressed: onRetry,
              child: BodyMediumText(text: 'تلاش مجدد'),
            ),
          ],
        ),
      );
    }

    final records = state.visibleRecords;
    if (records.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: AppSize.s120),
            EmptyListWidget(),
          ],
        ),
      );
    }

    final itemCount = records.length + 1 + (state.isLoadingMore ? 1 : 0);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < AppSize.s200 &&
            state.canLoadMore) {
          onLoadMore();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.separated(
          key: const PageStorageKey('special-plan-list'),
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: AppPadding.p100),
          itemCount: itemCount,
          separatorBuilder: (_, __) => Space.h12,
          itemBuilder: (context, index) {
            if (index == 0) {
              return SpecialPlanListHeader(totalCount: state.totalCount);
            }
            final recordIndex = index - 1;
            if (recordIndex >= records.length) {
              return const Padding(
                padding: EdgeInsets.all(AppPadding.p16),
                child: Center(child: LoadingWidget()),
              );
            }
            final item = records[recordIndex];
            return SpecialPlanCard(
              item: item,
              productTitle: state.productTitle(
                item.productId,
                fallback: item.productTitle,
              ),
              isActionLoading: state.deletingId == item.id,
              onActions: () => onActions(item),
            );
          },
        ),
      ),
    );
  }
}
