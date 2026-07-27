import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_cubit.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/cubit/navgan_state.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/widgets/navgan_action_sheet.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/widgets/navgan_card.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/widgets/navgan_defect_sheet.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/widgets/navgan_grade_sheet.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/widgets/navgan_service_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NavganPage extends StatelessWidget {
  static const path = '/navgan-page';
  static const name = 'navgan-page';

  const NavganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NavganCubit>()..init(),
      child: const _NavganView(),
    );
  }
}

class _NavganView extends StatelessWidget {
  const _NavganView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavganCubit>();
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<NavganCubit, NavganState>(
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
            appBar: const SimpleActionBar(title: 'ناوگان'),
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
                  child: _NavganList(
                    state: state,
                    onRetry: cubit.fetchList,
                    onActions: (item) => _openActions(context, cubit, item),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openActions(
    BuildContext context,
    NavganCubit cubit,
    NavganEntity item,
  ) {
    final theme = Theme.of(context);
    BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: theme.colorScheme.onPrimary,
      content: NavganActionSheet(
        onAddGrade: () {
          context.pop();
          _openGradeSheet(context, cubit, item);
        },
        onAssignServices: () {
          context.pop();
          _openServicesSheet(context, cubit, item);
        },
        onVehicleServices: () {
          context.pop();
          _openDefectsSheet(context, cubit, item);
        },
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }

  Future<void> _openGradeSheet(
    BuildContext context,
    NavganCubit cubit,
    NavganEntity item,
  ) async {
    await cubit.prepareGradeSheet(item);
    if (!context.mounted) return;

    await BottomSheetMessage.showFullScreenCustom<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: NavganGradeSheet(
        onSubmit: () async {
          final success = await cubit.submitGradeReference();
          if (success && context.mounted) context.pop();
        },
        onCancel: () => context.pop(),
      ),
    );
  }

  Future<void> _openServicesSheet(
    BuildContext context,
    NavganCubit cubit,
    NavganEntity item,
  ) async {
    await cubit.prepareServiceSheet(item);
    if (!context.mounted) return;

    await BottomSheetMessage.showFullScreenCustom<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: NavganServiceSheet(
        title: 'اختصاص سرویس‌ها',
        onSubmit: () async {
          final success = await cubit.submitServiceCategories();
          if (success && context.mounted) context.pop();
        },
        onCancel: () => context.pop(),
      ),
    );
  }

  Future<void> _openDefectsSheet(
    BuildContext context,
    NavganCubit cubit,
    NavganEntity item,
  ) async {
    await cubit.prepareDefectSheet(item);
    if (!context.mounted) return;

    await BottomSheetMessage.showFullScreenCustom<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: NavganDefectSheet(
        onSubmit: () async {
          final success = await cubit.submitDefects();
          if (success && context.mounted) context.pop();
        },
        onCancel: () => context.pop(),
      ),
    );
  }
}

class _NavganList extends StatelessWidget {
  const _NavganList({
    required this.state,
    required this.onRetry,
    required this.onActions,
  });

  final NavganState state;
  final VoidCallback onRetry;
  final ValueChanged<NavganEntity> onActions;

  @override
  Widget build(BuildContext context) {
    if (state.isInitialLoading) {
      return const Center(child: LoadingWidget());
    }

    if (state.status == NavganViewStatus.connectionError ||
        state.status == NavganViewStatus.failure) {
      return _ErrorView(onRetry: onRetry);
    }

    final records = state.records;
    if (records.isEmpty) {
      return const Center(child: EmptyListWidget());
    }

    return RefreshIndicator(
      onRefresh: () async => onRetry(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: AppPadding.p100),
        itemCount: records.length,
        separatorBuilder: (_, __) => Space.h12,
        itemBuilder: (context, index) {
          final item = records[index];
          return NavganCard(
            item: item,
            onActions: () => onActions(item),
          );
        },
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
          EmptyListWidget(),
          Space.h12,
          TextButton(
            onPressed: onRetry,
            child: BodyMediumText(text: 'تلاش مجدد'),
          ),
        ],
      ),
    );
  }
}
