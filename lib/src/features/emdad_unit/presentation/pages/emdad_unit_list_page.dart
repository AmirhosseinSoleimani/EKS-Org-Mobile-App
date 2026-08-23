import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/emdad_unit_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/cubit/emdad_unit_cubit.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_form_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_grade_pattern_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_image_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_location_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_persons_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_action_sheet.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_filter_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/gestures.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmdadUnitListPage extends StatelessWidget {
  static const path = '/emdad-unit-page';
  static const name = 'emdad-unit-page';

  const EmdadUnitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EmdadUnitCubit>()..fetchList(refresh: true),
      child: const _EmdadUnitListView(),
    );
  }
}

class _EmdadUnitListView extends StatelessWidget {
  const _EmdadUnitListView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmdadUnitCubit>();
    final theme = Theme.of(context);

    return BlocListener<EmdadUnitCubit, EmdadUnitState>(
      listener: (context, state) {
        if (state.status == EmdadUnitViewStatus.failure && state.message != null) {
          SnakeBarWidget.showError(context: context, message: state.message!);
        }
        if (state.status == EmdadUnitViewStatus.success && state.message != null) {
          SnakeBarWidget.showSuccess(context: context, message: state.message!);
        }
        if (state.status == EmdadUnitViewStatus.connectionError) {
          BottomSheetMessage.showCustom(
            context: context,
            content: NoInternetBottomSheet(onRetry: cubit.retryLastAction),
            actionWidget: const SizedBox.shrink(),
            isDismissible: false,
            enableDrag: false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const SimpleAppBar(title: 'واحد امدادی'),
     /*   floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final changed = await context.pushNamed<bool>(EmdadUnitFormPage.name);
            if (changed == true && context.mounted) {
              cubit.fetchList(refresh: true);
            }
          },
          child: const Icon(Icons.add_rounded),
        ),*/
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
                child: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
                  builder: (context, state) {
                    return FiltersRow(
                      spacing: AppSize.s12,
                      filters: [
                        StatusFilterDropdown<bool?>(
                          value: cubit.pageStatusFilter,
                          options: const [
                            StatusFilterOption(value: null, label: 'همه'),
                            StatusFilterOption(value: true, label: 'فعال'),
                            StatusFilterOption(value: false, label: 'غیرفعال'),
                          ],
                          onChanged: cubit.setPageStatusFilter,
                        ),
                        FilterButton(
                          title: 'فیلترها',
                                      onTap: () => _showFilters(context, cubit),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
                  builder: (context, state) {
                    if (state.status == EmdadUnitViewStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final hasInitialLoadError =
                        (state.status == EmdadUnitViewStatus.failure ||
                            state.status == EmdadUnitViewStatus.connectionError) &&
                        state.items.isEmpty;
                    if (hasInitialLoadError) {
                      return const SizedBox.expand(
                        child: Center(child: EmptyListWidget()),
                      );
                    }
                    final items = cubit.visibleItems;
                    if (state.items.isEmpty) {
                      return _MessageState(
                        icon: Icons.inbox_outlined,
                        title: state.filter.isActiveFilter
                            ? 'نتیجه‌ای برای فیلترهای انتخابی یافت نشد'
                            : 'رکوردی یافت نشد',
                        actionTitle: state.filter.isActiveFilter ? 'پاک کردن فیلترها' : 'تلاش مجدد',
                        onAction: state.filter.isActiveFilter
                            ? cubit.clearFilter
                            : () => cubit.fetchList(refresh: true),
                      );
                    }

                    if (items.isEmpty) {
                      return _MessageState(
                        icon: Icons.inbox_outlined,
                        title: 'رکوردی با وضعیت انتخاب‌شده یافت نشد',
                        actionTitle: 'نمایش همه',
                        onAction: () => cubit.setPageStatusFilter(null),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => cubit.fetchList(refresh: true),
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.pixels >=
                                  notification.metrics.maxScrollExtent - AppSize.s80 &&
                              state.hasMore &&
                              state.status != EmdadUnitViewStatus.loadingMore) {
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
                          itemCount: items.length +
                              (state.status == EmdadUnitViewStatus.loadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= items.length) {
                              return const Padding(
                                padding: EdgeInsets.all(AppPadding.p16),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                            final item = items[index];
                            return EmdadUnitCard(
                              item: item,
                              onAction: () => _showActionSheet(context, item, cubit),
                            );
                          },
                        ),
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

  void _showFilters(BuildContext context, EmdadUnitCubit cubit) {
    showFilterBottomSheet<void>(
      context: context,
      builder: (_) => EmdadUnitFilterSheet(
        initialFilter: cubit.state.filter,
        onApply: cubit.applyFilter,
        onClear: cubit.clearFilter,
      ),
    );
  }

  void _showActionSheet(
    BuildContext context,
    EmdadUnitEntity item,
    EmdadUnitCubit cubit,
  ) {
    BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      topRadius: AppSize.s20,
      content: Builder(
        builder: (sheetContext) => EmdadUnitActionSheet(
          onEditImage: () {
            Navigator.of(sheetContext).pop();
            _openImagePage(context, item, cubit);
          },
          onChangeLocation: () {
            Navigator.of(sheetContext).pop();
            _openLocationPage(context, item, cubit);
          },
          onPersons: () {
            Navigator.of(sheetContext).pop();
            _openPersonsPage(context, item, cubit);
          },
          onGradePatterns: () {
            Navigator.of(sheetContext).pop();
            _openGradePatternPage(context, item, cubit);
          },
          onDelete: () {
            Navigator.of(sheetContext).pop();
            _confirmDelete(context, item, cubit);
          },
        ),
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }

  Future<void> _openImagePage(
    BuildContext context,
    EmdadUnitEntity item,
    EmdadUnitCubit cubit,
  ) async {
    final changed = await context.pushNamed<bool>(EmdadUnitImagePage.name, extra: item);
    if (changed == true && context.mounted) {
      cubit.fetchList(refresh: true);
    }
  }

  Future<void> _openLocationPage(
    BuildContext context,
    EmdadUnitEntity item,
    EmdadUnitCubit cubit,
  ) async {
    final changed = await context.pushNamed<bool>(EmdadUnitLocationPage.name, extra: item);
    if (changed == true && context.mounted) {
      cubit.fetchList(refresh: true);
    }
  }

  Future<void> _openPersonsPage(
    BuildContext context,
    EmdadUnitEntity item,
    EmdadUnitCubit cubit,
  ) async {
    final changed = await context.pushNamed<bool>(EmdadUnitPersonsPage.name, extra: item);
    if (changed == true && context.mounted) {
      cubit.fetchList(refresh: true);
    }
  }

  Future<void> _openGradePatternPage(
    BuildContext context,
    EmdadUnitEntity item,
    EmdadUnitCubit cubit,
  ) async {
    final changed = await context.pushNamed<bool>(EmdadUnitGradePatternPage.name, extra: item);
    if (changed == true && context.mounted) {
      cubit.fetchList(refresh: true);
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    EmdadUnitEntity item,
    EmdadUnitCubit cubit,
  ) async {
    if (item.id == null) return;
    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
          builder: (context, state) => DeleteConfirmSheet(
            title: 'حذف واحد امدادی',
            message: 'آیا از حذف این مورد مطمئن هستید؟ این عمل غیرقابل بازگشت است.',
            confirmTitle: 'حذف',
            isSubmitting: state.status == EmdadUnitViewStatus.submitting,
            onConfirm: () async {
              final ok = await cubit.deleteItem(item.id!);
              if (ok && context.mounted) Navigator.of(context).pop(true);
            },
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
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EmptyListWidget(),
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

extension _EmdadUnitFilterStateX on EmdadUnitFilterParamEntity {
  bool get hasTextFilters {
    return [
      name,
      agencyInfoName,
      vehicleInfoTitle,
      personInfoFullName,
      locationTitle,
    ].any((item) => item?.trim().isNotEmpty == true) ||
        seatType != null ||
        grade != null;
  }

  bool get isActiveFilter => hasTextFilters || isActive != null;
}
