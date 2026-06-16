import 'dart:ui';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/home_service_evaluation_second_step.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
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
              isDismissible: false,
              enableDrag: false,
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
          appBar: const SimpleAppBar(title: 'ثبت ارزیابی خدمت در محل'),
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

          StreamBuilder<bool>(
            stream: cubit.kmReadOnly$,
            initialData: cubit.kilometerFieldReadOnly,
            builder: (context, snap) {
              final readOnly = snap.data ?? true;
              final saipaKilometer =
                  cubit.activeServiceRequestStream.valueOrNull?.saipaKilometer;

              return TextFormFieldWidget(
                controller: cubit.customerCarKilometerController,
                readOnly: readOnly,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                textInputType: TextInputType.number,
                labelText: saipaKilometer != null
                    ? 'کیلومتر خودرو مشتری (کیلومتر سایپایدک: ${saipaKilometer.toString().convertNumberWithLanguage()})'
                    : 'کیلومتر خودرو مشتری',
                mandatory: true,
                maxLength: 6,
              );
            },
          ),

          Space.h16,

          Row(
            children: [
              Expanded(
                child: TextFormFieldWidget(
                  controller: cubit.startTimeController,
                  readOnly: true,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  textInputType: TextInputType.number,
                  labelText: 'زمان اعزام',
                ),
              ),
              Space.w8,
              Expanded(
                child: TextFormFieldWidget(
                  controller: cubit.arriveTimeController,
                  readOnly: true,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  textInputType: TextInputType.number,
                  labelText: 'زمان حضور',
                ),
              ),
            ],
          ),

          Space.h16,

          TextFormFieldWidget(
            controller: cubit.reliefDistanceController,
            readOnly: true,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
            textInputType: TextInputType.number,
            labelText:
                'مسافت طی شده تا مشتری (${cubit.assignTrackerNameController.text})',
            mandatory: true,
          ),

          Space.h16,

          TextFormFieldWidget(
            controller: cubit.addDescriptionController,
            maxLines: 5,
            maxLength: 500,
            labelText: 'توضیحات',
          ),

          Space.h24,

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
}
