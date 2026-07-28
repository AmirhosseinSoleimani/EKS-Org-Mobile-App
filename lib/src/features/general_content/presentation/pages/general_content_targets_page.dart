import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_cubit.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_state.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/general_content_target_card.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/general_content_target_header_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralContentTargetsPage extends StatelessWidget {
  static const path = '/general-content-targets-page';
  static const name = 'general-content-targets-page';

  const GeneralContentTargetsPage({
    super.key,
    required this.content,
  });

  final GeneralContentEntity content;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GeneralContentCubit>()..initTargets(content),
      child: _GeneralContentTargetsView(content: content),
    );
  }
}

class _GeneralContentTargetsView extends StatelessWidget {
  const _GeneralContentTargetsView({required this.content});

  final GeneralContentEntity content;

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
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: const SimpleActionBar(title: 'گیرندگان بخشنامه'),
            floatingActionButton: FloatingActionButtonWidget(
              title: 'گیرنده جدید',
              onPressed: () => SnakeBarWidget.showError(
                context: context,
                message: 'فرم ثبت گیرنده در محدوده این پیاده‌سازی نیست.',
              ),
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
                child: RefreshIndicator(
                  onRefresh: () async => cubit.fetchTargets(content),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      AppPadding.p16,
                      AppPadding.p16,
                      AppPadding.p16,
                      AppPadding.p100,
                    ),
                    children: [
                      GeneralContentTargetHeaderCard(item: content),
                      Space.h24,
                      const TitleLargeText(
                        text: 'شرایط گیرندگان',
                        textAlign: TextAlign.start,
                      ),
                      Space.h16,
                      _TargetsBody(
                        state: state,
                        onRetry: () => cubit.fetchTargets(content),
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
}

class _TargetsBody extends StatelessWidget {
  const _TargetsBody({
    required this.state,
    required this.onRetry,
  });

  final GeneralContentState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (state.targetStatus == GeneralContentViewStatus.loading) {
      return const Padding(
        padding: EdgeInsets.only(top: AppSize.s64),
        child: Center(child: LoadingWidget()),
      );
    }

    if (state.targetStatus == GeneralContentViewStatus.connectionError ||
        state.targetStatus == GeneralContentViewStatus.failure) {
      return Padding(
        padding: const EdgeInsets.only(top: AppSize.s64),
        child: Center(
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
        ),
      );
    }

    if (state.targets.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: AppSize.s64),
        child: Center(child: EmptyListWidget()),
      );
    }

    return Column(
      children: [
        for (final item in state.targets) ...[
          GeneralContentTargetCard(item: item),
          Space.h16,
        ],
      ],
    );
  }
}
