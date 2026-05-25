import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/bottom_sheet/add_part_and_labor_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/cubit/evaluation_aid_service_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/time_distance_form_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EvaluationAidServiceRequestPage extends StatelessWidget {
  static const path = "/evaluation-aid-service-request-page";
  static const name = "evaluation-aid-service-request-page";

  const EvaluationAidServiceRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EvaluationAidServiceRequestCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EvaluationAidServiceRequestCubit>();
    return BlocListener<
      EvaluationAidServiceRequestCubit,
      EvaluationAidServiceRequestState
    >(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: cubit.init,
            );
          },
          connectionError: () {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(onRetry: cubit.init),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },

          showAddPartAndLaborBottomSheet: () {
            cubit.markBottomSheetOpen();

            showAddPartAndLaborBottomSheet(context).whenComplete(() {
              cubit.markBottomSheetClosed();
            });
          },
        );
      },
      child: Scaffold(
        appBar: SimpleAppBar(title: 'ثبت فاکتور'),
        body:
            BlocBuilder<
              EvaluationAidServiceRequestCubit,
              EvaluationAidServiceRequestState
            >(
              builder: (context, state) {
                return state.maybeWhen(
                  idle: () => const SizedBox.shrink(),
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color:
                          cubit.selectedRequest?.serviceType?.serviceColor ??
                          ServiceType.reliefService.serviceColor,
                    ),
                  ),
                  orElse: () => _LoadedView(),
                );
              },
            ),
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EvaluationAidServiceRequestCubit>();

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.s16),
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
            Space.h8,
            if (cubit.emdadgarInfo != null) ...[
              ExpandableSection(
                isExpanded: false,
                header: const BodyMediumText(text: "اطلاعات امداد رسان"),
                child: AgentInfoDetailSection(
                  agentInfo: cubit.emdadgarInfo!,
                  selectedRequest: cubit.selectedRequest,
                ),
              ),
            ],
            TimeDistanceFormSection(
              assignDateController: cubit.assignDateController,
              assignTimeController: cubit.assignTimeController,
              arriveDateController: cubit.arriveDateController,
              arriveTimeController: cubit.arriveTimeController,
              kilometerController: cubit.kilometerController,
              customerDistanceController: cubit.customerDistanceController,
              onAssignDateChange: cubit.setAssignDate,
              onAssignTimeChange: cubit.setAssignTime,
              onArriveDateChange: cubit.setArriveDate,
              onArriveTimeChange: cubit.setArriveTime,
            )
          ],
        ),
      ),
    );
  }

  SizedBox _formElementGap() => Space.h16;
}
