import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_history/cubit/evaluation_history_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_history/widgets/filter_box.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/evaluation_history_list_view.dart';

class EvaluationHistoryPage extends StatelessWidget {
  static const path = "/evaluation-history-page";
  static const name = "evaluation-history-page";

  const EvaluationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EvaluationHistoryCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EvaluationHistoryCubit>();

    return BlocListener<EvaluationHistoryCubit, EvaluationHistoryState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: () {
                context.pop();
                cubit.init();
              },
            );
          },
          connectionError: () {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: cubit.init,
              ),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      child: const Scaffold(
        appBar: SimpleAppBar(title: "تاریخچه ارزیابی"),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvaluationHistoryCubit, EvaluationHistoryState>(
      builder: (context, state) {
        final cubit = context.read<EvaluationHistoryCubit>();
        return state.maybeWhen(
          idle: () => const SizedBox.shrink(),
          loading: () =>  Center(
            child: CircularProgressIndicator(
                color: cubit.selectedBaseRequest?.serviceType?.serviceColor
            ),
          ),
          loaded: () => const _LoadedView(),
          error: (_) => cubit.items.isEmpty
              ? const SizedBox.expand(
                  child: Center(child: EmptyListWidget()),
                )
              : const _LoadedView(),
          connectionError: () => cubit.items.isEmpty
              ? const SizedBox.expand(
                  child: Center(child: EmptyListWidget()),
                )
              : const _LoadedView(),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EvaluationHistoryCubit>();

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.s16),
        child: Column(
          children: [
            FilterBox(cubit: cubit),
            ExpandableSection(
              isExpanded: false,
              header: RequestStatusSection(
                request: cubit.selectedBaseRequest,
                showTitle: true,
              ),
              child: RequestDetailSection(
                selectedRequest: cubit.selectedBaseRequest,
                showCustomerInfo: true,
              ),
            ),
            if (cubit.emdadgarInfo != null) ...[
              ExpandableSection(
                brief: BodySmallText(
                  text:
                  "${cubit.emdadgarInfo?.agencyName ?? ''} | ${cubit.emdadgarInfo?.mobile ?? ""}",
                ),
                isExpanded: false,
                header: const BodyMediumText(text: "اطلاعات امداد رسان"),
                child: AgentInfoDetailSection(
                  agentInfo: cubit.emdadgarInfo!,
                  selectedRequest: cubit.selectedBaseRequest,
                ),
              ),
            ],
            Space.h8,
            ValueListenableBuilder(
              valueListenable: cubit.selectedEvaluationIsisAcceptedNotifier,
              builder: (context, _, __) {
                return EvaluationListView(
                  items: cubit.items,
                  icon: const Icon(
                    Icons.date_range_rounded,
                    color: Colors.grey,
                    size: 20,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
