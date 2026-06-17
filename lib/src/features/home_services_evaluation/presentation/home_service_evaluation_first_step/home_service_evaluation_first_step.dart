import 'dart:ui';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/home_service_evaluation_second_step.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/time_distance_form_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_service_evaluation_first_step_cubit.dart';
import 'cubit/home_service_evaluation_first_step_state.dart';

class HomeServiceEvaluationFirstStep extends StatelessWidget {
  const HomeServiceEvaluationFirstStep({super.key});

  static const path = '/home-service-evaluation-first-step';
  static const name = 'home-service-evaluation-first-step';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeServiceEvaluationFirstStepCubit>()..initState(),
      child: const _HomeServiceEvaluationFirstStepView(),
    );
  }
}

class _HomeServiceEvaluationFirstStepView extends StatelessWidget {
  const _HomeServiceEvaluationFirstStepView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      HomeServiceEvaluationFirstStepCubit,
      HomeServiceEvaluationFirstStepState
    >(
      listener: (context, state) {
        state.whenOrNull(
          submitSuccess: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeServiceEvaluationSecondStep(),
              ),
            );
          },
          submitError: (message) {
            BottomSheetMessage.showError(
              context: context,
              data: message,
              isDismissible: true,
              enableDrag: true,
            );
          },
          error: (message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              positiveText: 'تلاش مجدد',
              onPositive: () {
                Navigator.of(context).pop();
                context.read<HomeServiceEvaluationFirstStepCubit>().initState();
              },
              isDismissible: true,
              enableDrag: true,
            );
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return Scaffold(
          appBar: const SimpleAppBar(title: 'ثبت فاکتور'),
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: isLoading
                ?  Center(child: CircularProgressIndicator(color: ServiceType.homeService.serviceColor))
                : const _HomeServiceEvaluationFirstStepBody(),
          ),
        );
      },
    );
  }
}

class _HomeServiceEvaluationFirstStepBody extends StatelessWidget {
  const _HomeServiceEvaluationFirstStepBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationFirstStepCubit>();


    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Space.h4,
          ExpandableSection(
            isExpanded: false,
            header: RequestStatusSection(request: cubit.requestEntity),
            child: RequestDetailSection(
              selectedRequest: cubit.requestEntity,
              showCustomerInfo: true,
            ),
          ),
          if (cubit.emdadgarInfo != null) ...[
            ExpandableSection(
              isExpanded: false,
              header: const BodyMediumText(text: "اطلاعات امداد رسان"),
              child: AgentInfoDetailSection(
                agentInfo: cubit.emdadgarInfo!,
                selectedRequest: cubit.requestEntity,
              ),
            ),
            _formElementGap(),
          ],
          Space.h8,
          if(cubit.mainForm != null)...[
            TimeDistanceFormSection(
              assignDateController: cubit.mainForm!.assignDateController,
              assignTimeController: cubit.mainForm!.assignTimeController,
              arriveDateController: cubit.mainForm!.arriveDateController,
              arriveTimeController: cubit.mainForm!.arriveTimeController,

              kilometerController: cubit.mainForm!.kilometerController,
              customerDistanceController: cubit.mainForm!
                  .customerDistanceController,

              onAssignDateChange: cubit.mainForm!.setAssignDate,
              onAssignTimeChange: cubit.mainForm!.setAssignTime,
              onArriveDateChange: cubit.mainForm!.setArriveDate,
              onArriveTimeChange: cubit.mainForm!.setArriveTime,
            ),
          ],
          BlocBuilder<
            HomeServiceEvaluationFirstStepCubit,
            HomeServiceEvaluationFirstStepState
          >(
            builder: (context, state) {
              final isSubmitting = state.maybeWhen(
                submitLoading: () => true,
                orElse: () => false,
              );

              return InkwellButtonWidget(
                title: 'ذخیره و ادامه',
                showLoading: isSubmitting,
                backgroundColor: ServiceType.homeService.serviceColor,
                onTap: isSubmitting ? null : cubit.submit,
              );
            },
          ),
        ],
      ),
    );
  }

  SizedBox _formElementGap() => Space.h8;
}
