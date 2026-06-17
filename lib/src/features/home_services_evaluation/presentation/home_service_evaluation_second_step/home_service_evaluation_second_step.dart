import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/page/home_service_evaluation_packages_page.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/widgets/service_added_container_widget.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/widgets/service_customer_container_widget.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';

import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeServiceEvaluationSecondStep extends StatelessWidget {
  const HomeServiceEvaluationSecondStep({super.key});

  static const path = '/home-service-evaluation-second-step';
  static const name = 'home-service-evaluation-second-step';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeServiceEvaluationSecondStepCubit>()..initState(),
      child: const _HomeServiceEvaluationSecondStepView(),
    );
  }
}

class _HomeServiceEvaluationSecondStepView extends StatelessWidget {
  const _HomeServiceEvaluationSecondStepView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
        HomeServiceEvaluationSecondStepCubit,
        HomeServiceEvaluationSecondStepState
    >(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            BottomSheetMessage.showError(
              context: context,
              data: message,
              isDismissible: true,
              enableDrag: true,
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
          submitSuccess: () {
            // TODO:
            // اینجا باید به صفحه فاکتور پروژه فعلی وصل شود.
            // فعلاً اگر InvoicePage در پروژه فعلی آماده نیست،
            // فقط pop یا route مناسب خودت را بگذار.
            Navigator.of(context).pop();
          },
          submitNeedPhotoSuccess: () {
            // TODO:
            // اینجا باید به صفحه AddPhotoHomeServicePage پروژه فعلی وصل شود.
            // اگر صفحه عکس هنوز migrate نشده، بعداً این navigation را وصل کن.
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        final cubit = context.read<HomeServiceEvaluationSecondStepCubit>();

        return Scaffold(
          appBar: const SimpleAppBar(title: 'ثبت ارزیابی'),
          body: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: isLoading
                ?  Center(child: CircularProgressIndicator(color: ServiceType.homeService.serviceColor))
                : const _HomeServiceEvaluationSecondStepBody(),
          ),
          bottomNavigationBar: BlocBuilder<
              HomeServiceEvaluationSecondStepCubit,
              HomeServiceEvaluationSecondStepState
          >(
            builder: (context, state) {
              final isSubmitting = state.maybeWhen(
                submitLoading: () => true,
                orElse: () => false,
              );

              return Padding(
                padding: const EdgeInsets.all(16),
                child: InkwellButtonWidget(
                  title: 'ذخیره و ادامه',
                  showLoading: isSubmitting,
                  onTap: isSubmitting ? null : cubit.postEvaluation,
                  backgroundColor: ServiceType.homeService.serviceColor,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _HomeServiceEvaluationSecondStepBody extends StatelessWidget {
  const _HomeServiceEvaluationSecondStepBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationSecondStepCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return FormSectionContainer(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const TitleLargeText(
            text: 'جزئیات سرویس',
            fontSize: 16,
            textAlign: TextAlign.start,
          ),

          Space.h32,

          BlocBuilder<
              HomeServiceEvaluationSecondStepCubit,
              HomeServiceEvaluationSecondStepState
          >(
            builder: (context, state) {
              final customerServices =
                  HomeServiceEvaluationSecondStepCubit.customerServiceList ?? [];

              if (customerServices.isEmpty) {
                return const SizedBox.shrink();
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: customerServices.length,
                itemBuilder: (context, index) {
                  final service = customerServices[index];

                  return ServiceCustomerContainerWidget(
                    evaluationServiceEntity: service,
                    serviceIndex: index,
                    onTapDelete: () {
                      cubit.deleteCustomerEvaluationService(
                        evaluationServiceEntity: service,
                      );
                    },
                  );
                },
              );
            },
          ),

          if (HomeServiceEvaluationSecondStepCubit
              .selectedServiceList
              ?.isNotEmpty ==
              true) ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: HomeServiceEvaluationSecondStepCubit
                  .selectedServiceList
                  ?.length ??
                  0,
              itemBuilder: (context, index) {
                final service = HomeServiceEvaluationSecondStepCubit
                    .selectedServiceList?[index] ??
                    EvaluationServiceEntity();

                return ServiceAddedContainerWidget(
                  entity: service,
                  index: index,
                  onTapDelete: () {
                    cubit.deleteSelectedEvaluationService(
                      evaluationServiceEntity: service,
                    );
                  },
                );
              },
            ),
          ],

          Space.h16,

          InkwellButtonWidget(
            title: 'افزودن سرویس',
            backgroundColor: colorScheme.onPrimary,
            borderColor: ServiceType.homeService.serviceColor,
            titleColor: ServiceType.homeService.serviceColor,
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const InsertHomeServiceServiceInfoPage(),
                ),
              );

              cubit.refresh();
            },
          ),
          Space.h16,
          StreamBuilder<bool?>(
            stream: cubit.addOtherServiceSubject.stream,
            initialData: cubit.addOtherServiceSubject.valueOrNull,
            builder: (context, snapshot) {
              final hasOtherService = snapshot.data == true;

              if (hasOtherService) {
                return const SizedBox.shrink();
              }

              return BlocBuilder<
                  HomeServiceEvaluationSecondStepCubit,
                  HomeServiceEvaluationSecondStepState
              >(
                builder: (context, state) {
                  final isOtherServiceLoading = state.maybeWhen(
                    otherServiceLoading: () => true,
                    orElse: () => false,
                  );

                  if (isOtherServiceLoading) {
                    return  Center(child: CircularProgressIndicator(color: ServiceType.homeService.serviceColor));
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(AppSize.s8),
                        onTap: cubit.fetchOtherService,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p8,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: AppSize.s20,
                                color: ServiceType.homeService.serviceColor,
                              ),
                              Space.w8,
                              TitleLargeText(text:
                                'افزودن سایر خدمات',
                                color: ServiceType.homeService.serviceColor,
                                fontSize: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),

        ],
      ),
    );
  }
}