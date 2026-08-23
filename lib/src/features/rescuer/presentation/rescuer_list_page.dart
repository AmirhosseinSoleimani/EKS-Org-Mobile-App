import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/add_rescuer_page.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/list/rescuer_list_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/rescuer_detail_page.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/rescuer_history_page.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/filter/rescuer_filters_box.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/list/rescuer_actions_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/list/rescuer_list_viewer.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/list/rescuer_skill_certificates_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RescuerListPage extends StatelessWidget {
  static const path = '/rescuers';
  static const name = 'rescuers';

  const RescuerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RescuerListCubit>()..fetchRescuers(),
      child: const _RescuerListView(),
    );
  }
}

class _RescuerListView extends StatelessWidget {
  const _RescuerListView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RescuerListCubit>();

    return BlocListener<RescuerListCubit, RescuerListState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (data, message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: () {
                context.pop();
                cubit.retryLastAction();
              },
            );
          },
          actionError: (data, message) {
            SnakeBarWidget.showError(context: context, message: message);
          },
          connectionError: (data) {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(onRetry: cubit.retryLastAction),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: const SimpleAppBar(title: 'امدادرسان'),
        floatingActionButton: FloatingActionButtonWidget(
          title: 'افزودن امدادرسان',
          onPressed: () => _openAddRescuer(context, cubit),
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: ValueListenableBuilder<bool>(
                  valueListenable: cubit.reportLoadingNotifier,
                  builder: (context, isReportLoading, _) {
                    return RescuerFiltersBox(
                      cubit: cubit,
                      isReportLoading: isReportLoading,
                      onReportTap: () => _loadReport(context, cubit),
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<RescuerListCubit, RescuerListState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      idle: (_) => const SizedBox.shrink(),
                      loading: (_) => const LoadingWidget(),
                      loaded: (_) => _buildList(context, cubit),
                      actionLoading: (_) => _buildList(context, cubit),
                      orElse: () => _buildList(context, cubit),
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

  Future<void> _openAddRescuer(
    BuildContext context,
    RescuerListCubit cubit,
  ) async {
    final result =
        await BottomSheetMessage.showFullScreenCustom<AddRescuerResult>(
          context: context,
          content: const AddRescuerPage(),
        );

    if (result == null || !context.mounted) return;
    await cubit.fetchRescuers();
    if (!context.mounted) return;

    SnakeBarWidget.showSuccess(
      context: context,
      message: 'امدادرسان با موفقیت ثبت شد',
    );

    if (result.viewProfile) {
      await BottomSheetMessage.showFullScreenCustom<void>(
        context: context,
        content: RescuerDetailPage(rescuerId: result.rescuerId),
      );
    }
  }

  Widget _buildList(BuildContext context, RescuerListCubit cubit) {
    return RescuerListViewer(
      items: cubit.filteredItems,
      deletingRescuerId: cubit.deletingRescuerId,
      onViewDetails: (item) => _openDetails(context, cubit, item),
      onOperations: (item) => _showOperations(context, cubit, item),
    );
  }

  Future<void> _openDetails(
    BuildContext context,
    RescuerListCubit cubit,
    RescuerEntity item,
  ) async {
    final id = item.id;
    if (id == null) return;

    final wasDeleted = await BottomSheetMessage.showFullScreenCustom<bool>(
      context: context,
      content: RescuerDetailPage(rescuerId: id),
    );

    if (wasDeleted == true) {
      await cubit.fetchRescuers();
    }
  }

  void _showOperations(
    BuildContext context,
    RescuerListCubit cubit,
    RescuerEntity item,
  ) {
    final id = item.id;
    if (id == null) return;

    BottomSheetMessage.showCustom(
      context: context,
      content: RescuerActionsBottomSheet(
        onSkillCertificates: () async {
          final result = await cubit.loadSkillCertificates(id);
          if (context.mounted) Navigator.of(context).pop();
          if (result == null || !context.mounted) return false;

          await BottomSheetMessage.showFullScreenCustom<void>(
            context: context,
            content: RescuerSkillCertificatesSheet(
              rescuer: item,
              items: result,
            ),
          );
          return true;
        },
        onHistory: () async {
          final result = await cubit.loadHistory(id);
          if (context.mounted) Navigator.of(context).pop();
          if (result == null || !context.mounted) return false;

          await BottomSheetMessage.showFullScreenCustom<void>(
            context: context,
            content: RescuerHistoryPage(rescuer: item, histories: result),
          );
          return true;
        },
        onDelete: () async {
          if (context.mounted) Navigator.of(context).pop();
          await Future<void>.delayed(Duration.zero);
          if (!context.mounted) return false;

          await _confirmDelete(context, cubit, item);
          return true;
        },
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    RescuerListCubit cubit,
    RescuerEntity item,
  ) async {
    final id = item.id;
    if (id == null) return;

    final rescuerName = item.fullName.trim();
    var isSubmitting = false;

    await BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      actionWidget: const SizedBox.shrink(),
      isDismissible: false,
      enableDrag: false,
      content: StatefulBuilder(
        builder: (sheetContext, setSheetState) {
          return DeleteConfirmSheet(
            title: 'حذف امدادرسان',
            message:
                'آیا از حذف «${rescuerName.isNotEmpty ? rescuerName : 'این امدادرسان'}» مطمئن هستید؟',
            confirmTitle: 'حذف',
            isSubmitting: isSubmitting,
            onConfirm: () async {
              if (isSubmitting) return;
              setSheetState(() => isSubmitting = true);

              final deleted = await cubit.deleteRescuer(id);
              if (!sheetContext.mounted) return;

              if (deleted) {
                Navigator.of(sheetContext).pop();
                if (context.mounted) {
                  SnakeBarWidget.showSuccess(
                    context: context,
                    message: 'امدادرسان با موفقیت حذف شد',
                  );
                }
                return;
              }

              setSheetState(() => isSubmitting = false);
            },
          );
        },
      ),
    );
  }

  Future<void> _loadReport(BuildContext context, RescuerListCubit cubit) async {
    final filePath = await cubit.loadReport();
    if (!context.mounted || filePath == null) return;

    SnakeBarWidget.showSuccess(
      context: context,
      message: 'فایل اکسل گزارش امدادرسان‌ها آماده شد',
    );
  }
}
