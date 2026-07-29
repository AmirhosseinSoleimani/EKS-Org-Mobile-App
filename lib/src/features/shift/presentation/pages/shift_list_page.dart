import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/params/shift_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/cubit/shift_list_cubit.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/pages/shift_form_page.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/widgets/shift_action_sheet.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/widgets/shift_card.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/widgets/shift_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/widgets/shift_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShiftListPage extends StatelessWidget {
  static const path = '/shift-page';
  static const name = 'shift-page';

  const ShiftListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ShiftListCubit>()..fetchList(refresh: true),
      child: const _ShiftListView(),
    );
  }
}

class _ShiftListView extends StatelessWidget {
  const _ShiftListView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShiftListCubit>();

    return BlocListener<ShiftListCubit, ShiftListState>(
      listener: (context, state) {
        state.whenOrNull(
          failure: (message, items) {
            SnakeBarWidget.showError(context: context, message: message);
          },
          success: (action, message) {
            SnakeBarWidget.showSuccess(context: context, message: message);
          },
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F7F7),
        appBar: const SimpleAppBar(title: 'شیفت'),
        floatingActionButton: FloatingActionButtonWidget(
          title: 'شیفت جدید',
          onPressed: () async {
            final changed = await context.pushNamed<bool>(ShiftFormPage.name);
            if (changed == true && context.mounted) {
              cubit.fetchList(refresh: true);
            }
          },
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p16,
                  AppPadding.p16,
                  AppPadding.p16,
                  AppPadding.p8,
                ),
                child: BlocBuilder<ShiftListCubit, ShiftListState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: _TopFilterButton(
                            title: 'فیلترها',
                            isActive: cubit.filter.hasSearchFilters,
                            onTap: () => _showFilters(context, cubit),
                          ),
                        ),
                        Space.w12,
                        Expanded(
                          child: _TopFilterButton(
                            title: _statusTitle(cubit.filter.isActive),
                            isActive: cubit.filter.isActive != null,
                            onTap: () => _showStatusSheet(
                              context,
                              cubit,
                              cubit.filter,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: BlocBuilder<ShiftListCubit, ShiftListState>(
                  builder: (context, state) {
                    return _ReportButton(
                      isLoading: cubit.isExporting,
                      onTap: cubit.exportReport,
                    );
                  },
                ),
              ),
              Space.h12,
              Expanded(
                child: BlocBuilder<ShiftListCubit, ShiftListState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: (_) =>
                          const Center(child: CircularProgressIndicator()),
                      connectionError: (_, __) => _MessageState(
                        title: 'اتصال به اینترنت برقرار نیست',
                        actionTitle: 'تلاش مجدد',
                        onAction: () => cubit.fetchList(refresh: true),
                      ),
                      empty: (filter) => _MessageState(
                        title: filter.hasActiveFilters
                            ? 'نتیجه‌ای برای فیلترهای انتخابی یافت نشد'
                            : 'شیفتی یافت نشد',
                        actionTitle:
                            filter.hasActiveFilters ? 'پاک کردن فیلترها' : 'بازخوانی',
                        onAction: filter.hasActiveFilters
                            ? cubit.clearFilter
                            : () => cubit.fetchList(refresh: true),
                      ),
                      orElse: () {
                        final items = cubit.items;
                        if (items.isEmpty) {
                          return _MessageState(
                            title: 'شیفتی یافت نشد',
                            actionTitle: 'بازخوانی',
                            onAction: () => cubit.fetchList(refresh: true),
                          );
                        }

                        final isLoadingMore = state.maybeWhen(
                          loadingMore: (_, __, ___) => true,
                          orElse: () => false,
                        );

                        return RefreshIndicator(
                          onRefresh: () => cubit.fetchList(refresh: true),
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification.metrics.pixels >=
                                      notification.metrics.maxScrollExtent -
                                          AppSize.s80 &&
                                  cubit.hasMore &&
                                  !isLoadingMore) {
                                cubit.fetchList();
                              }
                              return false;
                            },
                            child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(
                                AppPadding.p16,
                                AppPadding.p8,
                                AppPadding.p16,
                                AppPadding.p100,
                              ),
                              itemCount: items.length + (isLoadingMore ? 1 : 0),
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
                                return ShiftCard(
                                  item: item,
                                  onOperations: () => _showOperationSheet(
                                    context,
                                    cubit,
                                    item,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
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

  void _showFilters(BuildContext context, ShiftListCubit cubit) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => ShiftFilterSheet(
        initialFilter: cubit.filter,
        shiftTypes: cubit.shiftTypes,
        onApply: cubit.applyFilter,
        onClear: cubit.clearFilter,
      ),
    );
  }

  void _showStatusSheet(
    BuildContext context,
    ShiftListCubit cubit,
    ShiftFilterParamEntity filter,
  ) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StatusTile(
                title: 'همه',
                onTap: () {
                  Navigator.of(context).pop();
                  cubit.applyFilter(filter.copyWith(
                    clearIsActive: true,
                    skip: 0,
                  ));
                },
              ),
              _StatusTile(
                title: 'فعال',
                onTap: () {
                  Navigator.of(context).pop();
                  cubit.applyFilter(filter.copyWith(isActive: true, skip: 0));
                },
              ),
              _StatusTile(
                title: 'غیرفعال',
                onTap: () {
                  Navigator.of(context).pop();
                  cubit.applyFilter(filter.copyWith(isActive: false, skip: 0));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOperationSheet(
    BuildContext context,
    ShiftListCubit cubit,
    ShiftEntity item,
  ) {
    final pageContext = context;
    BottomSheetMessage.showCustom(
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: BlocBuilder<ShiftListCubit, ShiftListState>(
          builder: (sheetContext, state) {
            return ShiftActionSheet(
              loadingAction: cubit.deletingItemId == item.id
                  ? ShiftOperation.delete
                  : null,
              onActionSelected: (operation) => _handleOperationSelected(
                pageContext,
                sheetContext,
                cubit,
                item,
                operation,
              ),
            );
          },
        ),
      ),
      actionWidget: const SizedBox.shrink(),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }

  Future<void> _handleOperationSelected(
    BuildContext pageContext,
    BuildContext sheetContext,
    ShiftListCubit cubit,
    ShiftEntity item,
    ShiftOperation operation,
  ) async {
    switch (operation) {
      case ShiftOperation.edit:
        Navigator.of(sheetContext).pop();
        await Future<void>.delayed(Duration.zero);
        if (!pageContext.mounted) return;
        final changed = await pageContext.pushNamed<bool>(
          ShiftFormPage.name,
          extra: item.id,
        );
        if (changed == true && pageContext.mounted) {
          cubit.fetchList(refresh: true);
        }
        return;
      case ShiftOperation.delete:
        Navigator.of(sheetContext).pop();
        await Future<void>.delayed(Duration.zero);
        if (!pageContext.mounted) return;
        _showDeleteSheet(pageContext, cubit, item);
        return;
    }
  }

  void _showDeleteSheet(
    BuildContext context,
    ShiftListCubit cubit,
    ShiftEntity item,
  ) {
    final id = item.id;
    if (id == null) return;

    BottomSheetMessage.showCustom(
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: BlocBuilder<ShiftListCubit, ShiftListState>(
          builder: (context, state) {
            return ShiftConfirmSheet(
              title: 'حذف شیفت',
              message: 'آیا از حذف این شیفت مطمئن هستید؟',
              confirmTitle: 'حذف',
              isLoading: cubit.deletingItemId == id,
              onConfirm: () => cubit.deleteItem(id),
            );
          },
        ),
      ),
      actionWidget: const SizedBox.shrink(),
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      maxHeight: 0.45,
    );
  }

  String _statusTitle(bool? value) {
    if (value == true) return 'فعال';
    if (value == false) return 'غیرفعال';
    return 'وضعیت';
  }
}

class _TopFilterButton extends StatelessWidget {
  const _TopFilterButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.s8),
      onTap: onTap,
      child: Container(
        height: AppSize.s48,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(AppSize.s8),
          border: Border.all(
            color: isActive
                ? theme.colorScheme.primary.withValues(alpha: 0.45)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isActive
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: theme.colorScheme.onSurfaceVariant,
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
    return InkWell(
      onTap: () {
        if (isLoading) return;
        onTap();
      },
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Container(
        height: AppSize.s40,
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimaryFixed.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppSize.s8),
          border: Border.all(color: theme.colorScheme.onPrimaryFixed),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.onPrimaryFixed,
                ),
              )
            else ...[
              SvgWidget(src: SvgAsset(SvgManager.exportNotes)),
              Space.w8,
              Text(
                'گزارش‌گیری',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryFixed,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BodyMediumText(text: title),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.title,
    required this.actionTitle,
    required this.onAction,
  });

  final String title;
  final String actionTitle;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmptyListWidget(),
            Space.h12,
            BodyMediumText(text: title, textAlign: TextAlign.center),
            Space.h16,
            OutlinedButton(
              onPressed: onAction,
              child: BodyMediumText(text: actionTitle),
            ),
          ],
        ),
      ),
    );
  }
}
