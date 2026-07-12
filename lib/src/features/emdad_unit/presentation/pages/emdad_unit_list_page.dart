import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/cubit/emdad_unit_cubit.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_form_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_image_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_location_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_persons_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_card.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/gestures.dart';
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

    return BlocListener<EmdadUnitCubit, EmdadUnitState>(
      listener: (context, state) {
        if (state.status == EmdadUnitViewStatus.failure && state.message != null) {
          SnakeBarWidget.showError(context: context, message: state.message!);
        }
        if (state.status == EmdadUnitViewStatus.success && state.message != null) {
          SnakeBarWidget.showSuccess(context: context, message: state.message!);
        }
      },
      child: Scaffold(
        appBar: const SimpleAppBar(title: 'واحدهای امدادی'),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final changed = await context.pushNamed<bool>(EmdadUnitFormPage.name);
            if (changed == true && context.mounted) {
              cubit.fetchList(refresh: true);
            }
          },
          child: const Icon(Icons.add_rounded),
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: cubit.nameController,
                        decoration: const InputDecoration(
                          labelText: 'جستجوی عنوان',
                          prefixIcon: Icon(Icons.search_rounded),
                        ),
                        onSubmitted: (value) {
                          cubit.applyFilter(cubit.state.filter.copyWith(name: value));
                        },
                      ),
                    ),
                    Space.w8,
                    IconButton.filledTonal(
                      tooltip: 'فیلتر',
                      onPressed: () => _showFilters(context, cubit),
                      icon: const Icon(Icons.tune_rounded),
                    ),
                    Space.w8,
                    IconButton.filledTonal(
                      tooltip: 'بازخوانی',
                      onPressed: () => cubit.fetchList(refresh: true),
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
                  builder: (context, state) {
                    if (state.status == EmdadUnitViewStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == EmdadUnitViewStatus.connectionError) {
                      return _MessageState(
                        icon: Icons.wifi_off_rounded,
                        title: 'اتصال به اینترنت برقرار نیست',
                        actionTitle: 'تلاش مجدد',
                        onAction: cubit.retryLastAction,
                      );
                    }
                    if (state.items.isEmpty) {
                      return _MessageState(
                        icon: Icons.inbox_outlined,
                        title: 'رکوردی یافت نشد',
                        actionTitle: 'بازخوانی',
                        onAction: () => cubit.fetchList(refresh: true),
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
                            AppPadding.p0,
                            AppPadding.p16,
                            AppPadding.p100,
                          ),
                          itemCount: state.items.length +
                              (state.status == EmdadUnitViewStatus.loadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= state.items.length) {
                              return const Padding(
                                padding: EdgeInsets.all(AppPadding.p16),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                            final item = state.items[index];
                            return EmdadUnitCard(
                              item: item,
                              onEditImage: () => _openImagePage(context, item, cubit),
                              onChangeLocation: () => _openLocationPage(context, item, cubit),
                              onPersons: () => _openPersonsPage(context, item, cubit),
                              onDelete: () => _confirmDelete(context, item, cubit),
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
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => EmdadUnitFilterSheet(
        initialFilter: cubit.state.filter,
        onApply: cubit.applyFilter,
        onClear: cubit.clearFilter,
      ),
    );
  }

  Future<void> _openImagePage(
    BuildContext context,
    EmdadUnitEntity item,
    EmdadUnitCubit cubit,
  ) async {
    final changed = await context.pushNamed<bool>(
      EmdadUnitImagePage.name,
      extra: item,
    );
    if (changed == true && context.mounted) {
      cubit.fetchList(refresh: true);
    }
  }

  Future<void> _openLocationPage(
    BuildContext context,
    EmdadUnitEntity item,
    EmdadUnitCubit cubit,
  ) async {
    final changed = await context.pushNamed<bool>(
      EmdadUnitLocationPage.name,
      extra: item,
    );
    if (changed == true && context.mounted) {
      cubit.fetchList(refresh: true);
    }
  }

  Future<void> _openPersonsPage(
    BuildContext context,
    EmdadUnitEntity item,
    EmdadUnitCubit cubit,
  ) async {
    final changed = await context.pushNamed<bool>(
      EmdadUnitPersonsPage.name,
      extra: item,
    );
    if (changed == true && context.mounted) {
      cubit.fetchList(refresh: true);
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    EmdadUnitEntity item,
    EmdadUnitCubit cubit,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('توجه'),
        content: Text('آیا واحد امدادی ${item.name ?? ''} حذف شود؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('انصراف'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (confirmed == true && item.id != null) {
      await cubit.deleteItem(item.id!);
    }
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
            Icon(icon, size: AppSize.s48, color: Theme.of(context).colorScheme.primary),
            Space.h16,
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            Space.h16,
            OutlinedButton(
              onPressed: onAction,
              child: Text(actionTitle),
            ),
          ],
        ),
      ),
    );
  }
}
