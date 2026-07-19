import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/params/grade_pattern_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/cubit/grade_pattern_cubit.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/pages/grade_pattern_form_page.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_card.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_details_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
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
    final theme = Theme.of(context);

    return BlocListener<GradePatternCubit, GradePatternState>(
      listener: (context, state) {
        state.whenOrNull(
          failure: (message, items) {
            SnakeBarWidget.showError(context: context, message: message);
          },
          success: (action, message, items) {
            SnakeBarWidget.showSuccess(context: context, message: message);
          },
        );
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const SimpleAppBar(title: 'الگوی گرید'),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final changed = await context.pushNamed<bool>(GradePatternFormPage.name);
            if (changed == true && context.mounted) {
              cubit.fetchList(refresh: true);
            }
          },
          child: const Icon(Icons.add_rounded),
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
              child: Row(
                children: [
                  Expanded(
                    child: _TopFilterButton(
                      title: 'جستجو',
                      isActive: cubit.filter.name?.trim().isNotEmpty == true,
                      onTap: () => _showSearchSheet(context, cubit),
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: _TopFilterButton(
                      title: _statusTitle(cubit.filter.isActive),
                      isActive: cubit.filter.isActive != null,
                      onTap: () => _showStatusSheet(context, cubit),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<GradePatternCubit, GradePatternState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: (_) => const Center(child: CircularProgressIndicator()),
                    connectionError: (_, __) => _MessageState(
                      icon: Icons.wifi_off_rounded,
                      title: 'اتصال به اینترنت برقرار نیست',
                      actionTitle: 'تلاش مجدد',
                      onAction: () => cubit.fetchList(refresh: true),
                    ),
                    empty: (filter) => _MessageState(
                      icon: Icons.inbox_outlined,
                      title: filter.hasActiveFilters
                          ? 'نتیجه‌ای برای فیلترهای انتخابی یافت نشد'
                          : 'رکوردی یافت نشد',
                      actionTitle: filter.hasActiveFilters ? 'پاک کردن فیلترها' : 'تلاش مجدد',
                      onAction: filter.hasActiveFilters
                          ? cubit.clearFilter
                          : () => cubit.fetchList(refresh: true),
                    ),
                    orElse: () {
                      final items = cubit.items;
                      if (items.isEmpty) {
                        return _MessageState(
                          icon: Icons.inbox_outlined,
                          title: 'رکوردی یافت نشد',
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
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
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
                                return GradePatternCard(
                                  item: item,
                                  onDetails: () => _showDetails(context, cubit, item),
                                  onEdit: () async {
                                    final changed = await context.pushNamed<bool>(
                                      GradePatternFormPage.name,
                                      extra: item.id,
                                    );
                                    if (changed == true && context.mounted) {
                                      cubit.fetchList(refresh: true);
                                    }
                                  },
                                  onDelete: () => _showDeleteSheet(context, cubit, item),
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
      ),
    );
  }

  void _showSearchSheet(BuildContext context, GradePatternCubit cubit) {
    final controller = TextEditingController(text: cubit.filter.name);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppPadding.p16,
            AppPadding.p16,
            AppPadding.p16,
            MediaQuery.of(context).viewInsets.bottom + AppPadding.p16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormFieldWidget(
                controller: controller,
                labelText: 'نام الگوی گرید',
                hintText: 'جستجو بر اساس نام',
              ),
              Space.h16,
              Row(
                children: [
                  Expanded(
                    child: _SheetButton(
                      title: 'پاک کردن',
                      onTap: () {
                        Navigator.of(context).pop();
                        cubit.applyFilter(cubit.filter.copyWith(name: '', skip: 0));
                      },
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: _SheetButton(
                      title: 'اعمال',
                      filled: true,
                      onTap: () {
                        Navigator.of(context).pop();
                        cubit.applyFilter(
                          cubit.filter.copyWith(name: controller.text, skip: 0),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStatusSheet(BuildContext context, GradePatternCubit cubit) {
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
                  cubit.applyFilter(cubit.filter.copyWith(
                    clearIsActive: true,
                    skip: 0,
                  ));
                },
              ),
              _StatusTile(
                title: 'فعال',
                onTap: () {
                  Navigator.of(context).pop();
                  cubit.applyFilter(cubit.filter.copyWith(
                    isActive: true,
                    skip: 0,
                  ));
                },
              ),
              _StatusTile(
                title: 'غیرفعال',
                onTap: () {
                  Navigator.of(context).pop();
                  cubit.applyFilter(cubit.filter.copyWith(
                    isActive: false,
                    skip: 0,
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDetails(
    BuildContext context,
    GradePatternCubit cubit,
    GradePatternEntity item,
  ) async {
    final id = item.id;
    if (id != null) {
      await cubit.loadDetail(id);
    }
    final loaded = cubit.state.whenOrNull(detailLoaded: (item) => item) ?? item;
    if (!context.mounted) return;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
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
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => GradePatternConfirmSheet(
        title: 'حذف الگوی گرید',
        message: 'آیا الگوی گرید ${item.name ?? ''} حذف شود؟',
        onConfirm: () => cubit.deleteItem(id),
      ),
    );
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
    final color = isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Container(
        height: AppSize.s48,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(AppSize.s8),
          border: Border.all(
            color: isActive ? theme.colorScheme.primary : theme.dividerColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.filter_alt_outlined, size: AppSize.s18, color: color),
            Space.w8,
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
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
      title: Text(title),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8)),
    );
  }
}

class _SheetButton extends StatelessWidget {
  const _SheetButton({
    required this.title,
    required this.onTap,
    this.filled = false,
  });

  final String title;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Container(
        height: AppSize.s48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? theme.colorScheme.primary : theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(AppSize.s8),
          border: Border.all(
            color: filled ? theme.colorScheme.primary : theme.dividerColor,
          ),
        ),
        child: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: filled ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
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

String _statusTitle(bool? isActive) {
  if (isActive == true) return 'فعال';
  if (isActive == false) return 'غیرفعال';
  return 'همه';
}
