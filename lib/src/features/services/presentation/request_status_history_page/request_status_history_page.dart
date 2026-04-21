import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/base/operation_result_base_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/cubit/request_status_history_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/request_status_history_list_view.dart';

class RequestStatusHistoryPage extends StatelessWidget {
  static const path = "/request-status-history-page";
  static const name = "request-status-history-page";

  const RequestStatusHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OperationResultBasePage<RequestStatusHistoryCubit,
        List<RequestStatusHistoryItemEntity>>(
      title: "تاریخچه وضعیت درخواست",
      createCubit: () => getIt<RequestStatusHistoryCubit>(),
      loadedBuilder: (context) {
        return const RequestStatusHistoryLoadedView();
      },

      // NEW ↓↓↓ adding error bottom sheets
      onError: (context, message) {
        BottomSheetMessage.showErrorWithAction(
          context: context,
          data: message,
          onPositive: () {
            context.read<RequestStatusHistoryCubit>().init();
          },
        );
      },
      onConnectionError: (context) {
        BottomSheetMessage.showCustom(
          context: context,
          content: NoInternetBottomSheet(
            onRetry: () {
              context.read<RequestStatusHistoryCubit>().init();
            },
          ),
          actionWidget: const SizedBox.shrink(),
          isDismissible: false,
          enableDrag: false,
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
              header: _buildRequestStatusSection(cubit.selectedRequest),
              child: RequestDetailSection(
                selectedRequest: cubit.selectedRequest,
                showCustomerInfo: true,
              ),
            ),
            if (_hasAgentInfo(cubit.selectedRequest)) ...[
              ExpandableSection(
                brief: BodySmallText(
                  text:
                      "${cubit.emdadgarInfo?.agencyName ?? ''} | ${cubit.emdadgarInfo?.mobile ?? ""}",
                ),
                isExpanded: false,
                header: const BodyMediumText(text: "اطلاعات امداد رسان"),
                child: AgentInfoDetailSection(
                  selectedRequest: cubit.selectedRequest!,
                ),
              ),
            ],
            const SizedBox(height: 12),
            RequestStatusHistoryListView(
              items: cubit.items,
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

  bool _hasAgentInfo(BaseRequestEntity? req) {
    return req?.hasEmdadgar ?? false;
  }

  RequestStatusSection _buildRequestStatusSection(BaseRequestEntity? request) {
    return RequestStatusSection(
      trackCode: request?.trackCode?.toString() ?? "-",
      requestDateJalali: request?.requestDateJalali ?? "-",
      requestTime: request?.requestTime ?? "-",
      requestStatusTitle: request?.requestStatusTitle,
      isGuaranty: request?.isGuaranty ?? false,
      isSubscription: request?.isSubscription ?? false,
    );
  }
}
