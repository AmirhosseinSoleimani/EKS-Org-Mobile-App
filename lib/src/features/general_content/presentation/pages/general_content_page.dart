import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_cubit.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_state.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/pages/general_content_form_page.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/pages/general_content_targets_page.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/general_content_action_sheet.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/general_content_card.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/general_content_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/general_content_status_filter.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';

import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/list_widgets/list_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/refresh_widgets/swipe_refresh_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GeneralContentPage extends StatelessWidget {
  static const path = '/general-content-page';
  static const name = 'general-content-page';

  const GeneralContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GeneralContentCubit>()..init(),
      child: const _GeneralContentView(),
    );
  }
}

class _GeneralContentView extends StatelessWidget {
  const _GeneralContentView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GeneralContentCubit>();
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<GeneralContentCubit, GeneralContentState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage,
        listener: (context, state) {
          final error = state.errorMessage;
          if (error?.trim().isNotEmpty == true) {
            SnakeBarWidget.showError(context: context, message: error!);
          }

          final success = state.successMessage;
          if (success?.trim().isNotEmpty == true) {
            SnakeBarWidget.showSuccess(context: context, message: success!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: const SimpleAppBar(title: 'بخشنامه‌ها'),
            floatingActionButton: FloatingActionButtonWidget(
              title: 'بخشنامه جدید',
              onPressed: () => _openCreateForm(context, cubit),
            ),
            body: SafeArea(
              top: false,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FiltersRow(
                        filters: [
                          GeneralContentStatusFilterDropDown(
                            value: state.statusFilter,
                            onChanged: cubit.changeStatusFilter,
                          ),
                          FilterButton(
                            title: 'فیلترها',
                            onTap: () => _openFilterSheet(context, state),
                          ),
                        ],
                      ),
                      Space.h24,
                      ListSectionHeader(
                        title: 'بخشنامه‌های فعلی',
                        countText: '${state.visibleRecords.length} مورد',
                        accentColor: theme.colorScheme.primary,
                      ),
                      Space.h16,
                      Expanded(
                        child: _GeneralContentList(
                          state: state,
                          onRetry: () => cubit.fetchList(reset: true),
                          onLoadMore: () => cubit.fetchList(),
                          onActions: (item) => _openActions(context, item),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openCreateForm(
    BuildContext context,
    GeneralContentCubit cubit,
  ) async {
    final changed = await context.pushNamed<bool>(GeneralContentFormPage.name);
    if (!context.mounted || changed != true) return;

    SnakeBarWidget.showSuccess(
      context: context,
      message: 'بخشنامه با موفقیت ثبت شد.',
    );
    await cubit.fetchList(reset: true);
  }

  Future<void> _openEditForm(
    BuildContext context,
    GeneralContentCubit cubit,
    GeneralContentEntity item,
  ) async {
    await Future<void>.delayed(Duration.zero);
    if (!context.mounted) return;

    final changed = await context.pushNamed<bool>(
      GeneralContentFormPage.name,
      extra: item,
    );
    if (!context.mounted || changed != true) return;

    SnakeBarWidget.showSuccess(
      context: context,
      message: 'بخشنامه با موفقیت ویرایش شد.',
    );
    await cubit.fetchList(reset: true);
  }

  void _openFilterSheet(BuildContext context, GeneralContentState state) {
    final cubit = context.read<GeneralContentCubit>();
    showFilterBottomSheet<void>(
      context: context,
      builder: (_) => GeneralContentFilterSheet(
        contentTypes: state.contentTypeOptions,
        initialTitle: state.titleFilter,
        initialContentType: state.contentTypeFilter,
        onSubmit: (title, type) => cubit.applyFilter(
          title: title,
          contentType: type,
        ),
      ),
    );
  }

  void _openActions(BuildContext context, GeneralContentEntity item) {
    final pageContext = context;
    final cubit = pageContext.read<GeneralContentCubit>();
    final theme = Theme.of(pageContext);

    BottomSheetMessage.showCustom(
      context: pageContext,
      backgroundColor: theme.colorScheme.onPrimary,
      content: BlocBuilder<GeneralContentCubit, GeneralContentState>(
        bloc: cubit,
        builder: (sheetContext, state) {
          return GeneralContentActionSheet(
            isDeleting: state.deletingId == item.id,
            onRecipients: () {
              sheetContext.pop();
              pageContext.pushNamed(
                GeneralContentTargetsPage.name,
                extra: item,
              );
            },
            onEdit: () {
              sheetContext.pop();
              _openEditForm(pageContext, cubit, item);
            },
            onDelete: () {
              sheetContext.pop();
              _confirmDelete(pageContext, item, cubit);
            },
          );
        },
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }

  void _confirmDelete(
    BuildContext context,
    GeneralContentEntity item,
    GeneralContentCubit cubit,
  ) {
    DeleteConfirmSheet.show(
      context: context,
      title: 'حذف بخشنامه',
      message: 'آیا از حذف «${item.title ?? 'این بخشنامه'}» مطمئن هستید؟',
      confirmTitle: 'حذف',
      onConfirm: () async {
        await cubit.deleteContent(item);
      },
    );
  }

}

class _GeneralContentList extends StatelessWidget {
  const _GeneralContentList({
    required this.state,
    required this.onRetry,
    required this.onLoadMore,
    required this.onActions,
  });

  final GeneralContentState state;
  final VoidCallback onRetry;
  final VoidCallback onLoadMore;
  final ValueChanged<GeneralContentEntity> onActions;

  @override
  Widget build(BuildContext context) {
    if (state.isInitialLoading) {
      return const Center(child: LoadingWidget());
    }

    if (state.status == GeneralContentViewStatus.connectionError ||
        state.status == GeneralContentViewStatus.failure) {
      return SwipeRefreshContainer(
        onRefresh: () async => onRetry(),
        child: _ErrorView(onRetry: onRetry),
      );
    }

    final records = state.visibleRecords;
    if (records.isEmpty) {
      return SwipeRefreshContainer(
        onRefresh: () async => onRetry(),
        child: const Center(child: EmptyListWidget()),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onRetry(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent - AppSize.s80 &&
              state.canLoadMore) {
            onLoadMore();
          }
          return false;
        },
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: AppPadding.p100),
          itemCount: records.length + (state.isLoadingMore ? 1 : 0),
          separatorBuilder: (_, __) => Space.h16,
          itemBuilder: (context, index) {
            if (index >= records.length) {
              return const Padding(
                padding: EdgeInsets.all(AppPadding.p16),
                child: Center(child: LoadingWidget()),
              );
            }

            final item = records[index];
            return GeneralContentCard(
              item: item,
              isActionLoading: state.deletingId == item.id,
              onActions: () => onActions(item),
            );
          },
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const EmptyListWidget(),
          Space.h12,
          TextButton(
            onPressed: onRetry,
            child: const BodyMediumText(text: 'تلاش مجدد'),
          ),
        ],
      ),
    );
  }
}
