import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/cubit/grade_pattern_cubit.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/pages/grade_pattern_form_page.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_action_sheet.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_card.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_details_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/report_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_filter_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GradePatternListPage extends StatelessWidget {
  static const path = '/grade-pattern-page';
  static const name = 'grade-pattern-page';

  const GradePatternListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GradePatternCubit>()..fetchList(refresh: true),
      child: const _GradePatternListView(),
    );
  }
}

class _GradePatternListView extends StatelessWidget {
  const _GradePatternListView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GradePatternCubit>();

    return BlocListener<GradePatternCubit, GradePatternState>(
      listener: (context, state) {
        state.whenOrNull(
          failure: (message, items) {
            SnakeBarWidget.showError(context: context, message: message);
          },
          success: (action, message, items) {
            SnakeBarWidget.showSuccess(context: context, message: message);
          },
          connectionError: (_, __) {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: () => cubit.fetchList(refresh: true),
              ),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      child: ValueListenableBuilder<bool?>(
        valueListenable: cubit.pageStatusFilter,
        builder: (context, pageStatusFilter, _) {
          return Scaffold(
            backgroundColor: const Color(0xFFF6F6F6),
            appBar: const SimpleAppBar(title: 'الگوی گرید'),
            floatingActionButton: FloatingActionButtonWidget(
              title: 'افزودن الگوی گرید',
              onPressed: () async {
                final changed = await context.pushNamed<bool>(
                  GradePatternFormPage.name,
                  extra: _draftTemplate(cubit),
                );
                if (changed == true && context.mounted) {
                  cubit.fetchList(refresh: true);
                }
              },
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppPadding.p16,
                    AppPadding.p16,
                    AppPadding.p16,
                    AppPadding.p8,
                  ),
                  child: FiltersRow(
                    spacing: AppSize.s12,
                    filters: [
                      StatusFilterDropdown<bool?>(
                        value: pageStatusFilter,
                        options: const [
                          StatusFilterOption(value: null, label: 'همه'),
                          StatusFilterOption(value: true, label: 'فعال'),
                          StatusFilterOption(value: false, label: 'غیرفعال'),
                        ],
                        onChanged: cubit.setPageStatusFilter,
                      ),
                      FilterButton(
                        title: 'فیلترها',
                        onTap: () => _showSearchSheet(context, cubit),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16,
                  ),
                  child: BlocBuilder<GradePatternCubit, GradePatternState>(
                    builder: (context, state) {
                      return ReportButtonWidget(
                        isLoading: cubit.isExporting,
                        onTap: () {
                          if (cubit.isExporting) return;
                          cubit.exportReport();
                        },
                      );
                    },
                  ),
                ),
                Space.h12,
                Expanded(
                  child: BlocBuilder<GradePatternCubit, GradePatternState>(
                    builder: (context, state) {
                      final hasInitialLoadError = state.maybeWhen(
                        failure: (_, items) => items.isEmpty,
                        connectionError: (_, items) => items.isEmpty,
                        orElse: () => false,
                      );
                      if (hasInitialLoadError) {
                        return const SizedBox.expand(
                          child: Center(child: EmptyListWidget()),
                        );
                      }

                      return state.maybeWhen(
                        loading: (_) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        empty: (filter) => _MessageState(
                          icon: Icons.inbox_outlined,
                          title: filter.hasActiveFilters
                              ? 'نتیجه‌ای برای فیلترهای انتخابی یافت نشد'
                              : 'رکوردی یافت نشد',
                          actionTitle: filter.hasActiveFilters
                              ? 'پاک کردن فیلترها'
                              : 'تلاش مجدد',
                          onAction: filter.hasActiveFilters
                              ? cubit.clearFilter
                              : () => cubit.fetchList(refresh: true),
                        ),
                        orElse: () {
                          final items = cubit.visibleItems;
                          if (items.isEmpty) {
                            return _MessageState(
                              icon: Icons.inbox_outlined,
                              title: cubit.items.isEmpty
                                  ? 'رکوردی یافت نشد'
                                  : 'رکوردی با وضعیت انتخاب‌شده یافت نشد',
                              actionTitle: cubit.items.isEmpty
                                  ? 'بازخوانی'
                                  : 'نمایش همه',
                              onAction: cubit.items.isEmpty
                                  ? () => cubit.fetchList(refresh: true)
                                  : () => cubit.setPageStatusFilter(null),
                            );
                          }

                          final isLoadingMore = state.maybeWhen(
                            loadingMore: (_, __, ___) => true,
                            orElse: () => false,
                          );
                          return RefreshIndicator(
                            onRefresh: () => cubit.fetchList(refresh: true),
                            child: ScrollConfiguration(
                              behavior:
                                  ScrollConfiguration.of(context).copyWith(
                                dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse,
                                },
                              ),
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
                                  itemCount:
                                      items.length + (isLoadingMore ? 1 : 0),
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
                                    return GradePatternCard(
                                      item: item,
                                      isDetailsLoading:
                                          cubit.loadingDetailId == item.id,
                                      onDetails: () =>
                                          _showDetails(context, cubit, item),
                                      onOperations: () => _showOperationSheet(
                                        context,
                                        cubit,
                                        item,
                                      ),
                                    );
                                  },
                                ),
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
          );
        },
      ),
    );
  }

  GradePatternEntity? _draftTemplate(GradePatternCubit cubit) {
    for (final item in cubit.items) {
      if (item.details.isNotEmpty) {
        return item;
      }
    }
    return null;
  }

  void _showOperationSheet(
    BuildContext context,
    GradePatternCubit cubit,
    GradePatternEntity item,
  ) {
    final pageContext = context;

    BottomSheetMessage.showCustom(
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: BlocBuilder<GradePatternCubit, GradePatternState>(
          builder: (sheetContext, state) {
            final currentItem = _resolveItem(cubit, item);

            return GradePatternActionSheet(
              loadingAction: cubit.deletingItemId == currentItem.id
                  ? GradePatternOperation.delete
                  : null,
              onActionSelected: (operation) => _handleOperationSelected(
                pageContext,
                sheetContext,
                cubit,
                currentItem,
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
    GradePatternCubit cubit,
    GradePatternEntity item,
    GradePatternOperation operation,
  ) async {
    switch (operation) {
      case GradePatternOperation.edit:
        Navigator.of(sheetContext).pop();
        await Future<void>.delayed(Duration.zero);
        if (!pageContext.mounted) return;
        final changed = await pageContext.pushNamed<bool>(
          GradePatternFormPage.name,
          extra: item.id,
        );
        if (changed == true && pageContext.mounted) {
          cubit.fetchList(refresh: true);
        }
        return;
      case GradePatternOperation.delete:
        Navigator.of(sheetContext).pop();
        await Future<void>.delayed(Duration.zero);
        if (!pageContext.mounted) return;
        _showDeleteSheet(pageContext, cubit, item);
        return;
    }
  }

  void _showSearchSheet(BuildContext context, GradePatternCubit cubit) {
    final controller = TextEditingController(text: cubit.filter.name);

    showFilterBottomSheet<void>(
      context: context,
      builder: (sheetContext) => FilterBottomSheetScaffold(
        title: 'فیلترها',
        onApply: () {
          Navigator.of(sheetContext).pop();
          cubit.applyFilter(
            cubit.filter.copyWith(name: controller.text, skip: 0),
          );
        },
        onClear: () {
          Navigator.of(sheetContext).pop();
          cubit.applyFilter(cubit.filter.copyWith(name: '', skip: 0));
        },
        child: TextFormFieldWidget(
          controller: controller,
          labelText: 'نام الگوی گرید',
          hintText: 'جستجو بر اساس نام',
        ),
      ),
    ).whenComplete(controller.dispose);
  }

  Future<void> _showDetails(
    BuildContext context,
    GradePatternCubit cubit,
    GradePatternEntity item,
  ) async {
    final id = item.id;
    var loaded = item;
    if (id != null) {
      await cubit.loadDetail(id);
      final detail = cubit.state.whenOrNull(detailLoaded: (item) => item);
      if (detail?.id != id) return;
      loaded = detail!;
    }

    if (!context.mounted) return;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => GradePatternDetailsSheet(item: loaded),
    );
  }

  void _showDeleteSheet(
    BuildContext context,
    GradePatternCubit cubit,
    GradePatternEntity item,
  ) {
    final id = item.id;
    if (id == null) return;
    BottomSheetMessage.showCustom(
      context: context,
      content: BlocProvider.value(
        value: cubit,
        child: BlocBuilder<GradePatternCubit, GradePatternState>(
          builder: (context, state) {
            return GradePatternConfirmSheet(
              title: 'حذف الگوی گرید',
              message: 'آیا الگوی گرید ${item.name ?? ''} حذف شود؟',
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

  GradePatternEntity _resolveItem(
    GradePatternCubit cubit,
    GradePatternEntity fallback,
  ) {
    for (final item in cubit.items) {
      if (item.id == fallback.id) return item;
    }
    return fallback;
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.icon,
    required this.title,
    required this.actionTitle,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String actionTitle;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppSize.s48, color: theme.colorScheme.outline),
            Space.h12,
            Text(title, textAlign: TextAlign.center),
            Space.h16,
            TextButton(onPressed: onAction, child: Text(actionTitle)),
          ],
        ),
      ),
    );
  }
}
