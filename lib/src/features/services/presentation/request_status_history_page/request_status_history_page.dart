import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/cubit/request_status_history_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/cubit/request_status_history_state.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/request_status_history_list_view.dart';

class RequestStatusHistoryPage extends StatelessWidget {
  static const path = "/request-status-history-page";
  static const name = "request-status-history-page";

  const RequestStatusHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RequestStatusHistoryCubit>()..init(),
      child: const _View(),
    );
  }
}
class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RequestStatusHistoryCubit>();

    return BlocListener<RequestStatusHistoryCubit, RequestStatusHistoryState>(
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
          loadMoreError: (message) =>
              SnakeBarWidget.showError(context: context, message: message),
        );
      },
      child: const Scaffold(
        appBar: SimpleAppBar(title:"تاریخچه وضعیت درخواست"),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestStatusHistoryCubit, RequestStatusHistoryState>(
      builder: (context, state) {
        final cubit = context.read<RequestStatusHistoryCubit>();
        return state.maybeWhen(
          idle: () => const SizedBox.shrink(),
          loading: () =>  Center(
            child: CircularProgressIndicator(
                color: cubit.selectedRequest?.serviceType?.serviceColor
            ),
          ),
          error: (_) => cubit.items.isEmpty
              ? const SizedBox.expand(
                  child: Center(child: EmptyListWidget()),
                )
              : const RequestStatusHistoryLoadedView(),
          connectionError: () => cubit.items.isEmpty
              ? const SizedBox.expand(
                  child: Center(child: EmptyListWidget()),
                )
              : const RequestStatusHistoryLoadedView(),
          orElse: () => const RequestStatusHistoryLoadedView(),
        );
      },
    );
  }
}


class RequestStatusHistoryLoadedView extends StatelessWidget {
  const RequestStatusHistoryLoadedView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RequestStatusHistoryCubit>();
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ExpandableSection(
              isExpanded: false,
              header: RequestStatusSection(request: cubit.selectedRequest),
              child: RequestDetailSection(
                selectedRequest: cubit.selectedRequest,
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
                ),
              ),
            ],
            const SizedBox(height: 12),
            RequestStatusHistoryListView(
              icon: const Icon(
                Icons.history,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
