import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/cubit/imei_cubit.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/cubit/imei_state.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/pages/imei_form_page.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/widgets/imei_filters_row.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/widgets/imei_info_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/report_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ImeiPage extends StatelessWidget {
  static const path = '/imei-page';
  static const name = 'imei-page';

  const ImeiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ImeiCubit>()..init(),
      child: const _ImeiView(),
    );
  }
}

class _ImeiView extends StatelessWidget {
  const _ImeiView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ImeiCubit>();
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ImeiCubit, ImeiState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage ||
            previous.reportPath != current.reportPath,
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
            appBar: const SimpleActionBar(title: 'IMEI'),
            floatingActionButton: FloatingActionButtonWidget(
              title: 'IMEI جدید',
              onPressed: () => _openAddPage(context, cubit),
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
                      ImeiFiltersRow(cubit: cubit),
                      Space.h12,
                      ReportButtonWidget(
                        isLoading: state.isReporting,
                        onTap: () {
                          if (state.isReporting) return;
                          cubit.exportReport();
                        },
                      ),
                      Space.h24,
                      Expanded(
                        child: _ImeiList(
                          state: state,
                          onRetry: () => cubit.fetchList(refresh: true),
                          onLoadMore: cubit.loadMore,
                          onEdit: (item) => _openEditPage(
                            context,
                            cubit,
                            item,
                          ),
                          onDelete: (item) => _confirmDelete(
                            context,
                            cubit,
                            item,
                          ),
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

  Future<void> _openAddPage(BuildContext context, ImeiCubit cubit) async {
    final result = await context.pushNamed<bool>(ImeiFormPage.addName);
    if (result == true) {
      await cubit.fetchList(refresh: true);
    }
  }

  Future<void> _openEditPage(
    BuildContext context,
    ImeiCubit cubit,
    ImeiInfoEntity item,
  ) async {
    final result = await context.pushNamed<bool>(
      ImeiFormPage.editName,
      extra: item,
    );
    if (result == true) {
      await cubit.fetchList(refresh: true);
    }
  }

  void _confirmDelete(
    BuildContext context,
    ImeiCubit cubit,
    ImeiInfoEntity item,
  ) {
    BottomSheetMessage.showNoticeWithAction(
      context: context,
      data: const BottomSheetMessageModel(
        title: 'حذف IMEI',
        message: 'آیا از حذف این IMEI اطمینان دارید؟',
      ),
      positiveText: 'حذف',
      cancelTxt: 'انصراف',
      buttonColor: Theme.of(context).colorScheme.error,
      onPositive: () {
        context.pop();
        cubit.deleteItem(item);
      },
    );
  }
}

class _ImeiList extends StatelessWidget {
  const _ImeiList({
    required this.state,
    required this.onRetry,
    required this.onLoadMore,
    required this.onEdit,
    required this.onDelete,
  });

  final ImeiState state;
  final VoidCallback onRetry;
  final VoidCallback onLoadMore;
  final ValueChanged<ImeiInfoEntity> onEdit;
  final ValueChanged<ImeiInfoEntity> onDelete;

  @override
  Widget build(BuildContext context) {
    if (state.isInitialLoading) {
      return const Center(child: LoadingWidget());
    }

    if (state.status == ImeiViewStatus.connectionError ||
        state.status == ImeiViewStatus.failure) {
      return const SizedBox.expand(
        child: Center(child: EmptyListWidget()),
      );
    }

    final records = state.visibleRecords;
    if (records.isEmpty) {
      return const Center(child: EmptyListWidget());
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        if (metrics.pixels >= metrics.maxScrollExtent - AppSize.s80) {
          onLoadMore();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async => onRetry(),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: AppPadding.p100),
          itemCount: records.length + (state.isLoadingMore ? 1 : 0),
          separatorBuilder: (_, __) => Space.h12,
          itemBuilder: (context, index) {
            if (index >= records.length) {
              return const Padding(
                padding: EdgeInsets.all(AppPadding.p16),
                child: Center(child: LoadingWidget()),
              );
            }

            final item = records[index];
            return ImeiInfoCard(
              item: item,
              onEdit: () => onEdit(item),
              onDelete: () => onDelete(item),
            );
          },
        ),
      ),
    );
  }
}
