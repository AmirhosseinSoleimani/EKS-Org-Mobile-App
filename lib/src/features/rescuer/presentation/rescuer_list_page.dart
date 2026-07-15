import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/list/rescuer_list_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/rescuer_detail_page.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/filter/rescuer_filters_box.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/list/rescuer_actions_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/list/rescuer_list_viewer.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
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
              onPositive: cubit.retryLastAction,
            );
          },
          actionError: (data, message) {
            SnakeBarWidget.showError(
              context: context,
              message: message,
            );
          },
          connectionError: (data) {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: cubit.retryLastAction,
              ),
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
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: RescuerFiltersBox(
                  cubit: cubit,
                  onReportTap: () => _showReportNotice(context),
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

    final wasDeleted = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => RescuerDetailPage(rescuerId: id),
      ),
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
        isDeleting: cubit.deletingRescuerId == id,
        onDelete: () => _confirmDelete(context, cubit, item),
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }

  void _confirmDelete(
    BuildContext context,
    RescuerListCubit cubit,
    RescuerEntity item,
  ) {
    final id = item.id;
    if (id == null) return;

    BottomSheetMessage.showNoticeWithAction(
      context: context,
      data: BottomSheetMessageModel(
        title: 'حذف امدادرسان',
        message:
            'آیا از حذف ${item.fullName.isEmpty ? 'امدادرسان انتخاب‌شده' : item.fullName} مطمئن هستید؟',
      ),
      positiveText: 'حذف',
      cancelTxt: 'انصراف',
      buttonColor: Theme.of(context).colorScheme.error,
      onPositive: () {
        context.pop();
        cubit.deleteRescuer(id);
      },
    );
  }

  void _showReportNotice(BuildContext context) {
    BottomSheetMessage.showNotice(
      context: context,
      data: const BottomSheetMessageModel(
        title: 'گزارش‌گیری',
        message:
            'برای گزارش‌گیری API جداگانه‌ای در اطلاعات این فیچر ارائه نشده است.',
      ),
    );
  }
}
