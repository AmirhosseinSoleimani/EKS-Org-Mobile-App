import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/evaluation_invoice_page/evaluation_invoice_page.dart';
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
import 'package:go_router/go_router.dart';

import '../../domain/entity/evaluation_service_entity.dart';

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

              onButtonTap:(){
                final cubit = context.read<HomeServiceEvaluationSecondStepCubit>();
                context.pop();
                cubit.retryLastAction();
              }
            );
          },
          submitError: (message) {
            BottomSheetMessage.showError(
              context: context,
              data: message,
              isDismissible: true,
              enableDrag: true,
              onButtonTap: (){
                final cubit = context.read<HomeServiceEvaluationSecondStepCubit>();
                cubit.retryLastAction();
                context.pop();
              }
            );
          },
          submitSuccess: () {
            Navigator.of(context).pop();
            context.push(EvaluationInvoicePage.path, extra: context.read<HomeServiceEvaluationSecondStepCubit>().id);
          },
          submitNeedPhotoSuccess: () {
            // TODO:

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
                  onTap: isSubmitting ? () {}: cubit.postEvaluation,
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

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [

        // ===================== CUSTOMER SERVICES =====================
        FormSectionContainer(
          hasBorder: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const TitleLargeText(
                text: 'جزئیات سرویس',
                fontSize: 16,
                textAlign: TextAlign.start,
              ),

              Space.h32,

              BlocBuilder<HomeServiceEvaluationSecondStepCubit,
                  HomeServiceEvaluationSecondStepState>(
                builder: (context, state) {
                  final customerServices =
                      HomeServiceEvaluationSecondStepCubit
                          .customerServiceList ??
                          [];

                  if (customerServices.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: HomeServiceEvaluationSecondStepCubit.customerServiceList?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ServiceCustomerContainerWidget(
                            evaluationServiceEntity: HomeServiceEvaluationSecondStepCubit.customerServiceList?[index] ?? EvaluationServiceEntity(),
                            onTapDelete: () =>
                                cubit.deleteCustomerEvaluationService(
                                  evaluationServiceEntity: HomeServiceEvaluationSecondStepCubit.customerServiceList?[index],
                                ),
                            serviceIndex: index,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),

              Space.h16,
              InkwellButtonWidget(
                title: 'افزودن سرویس',
                prefixIcon: Icon(
                  Icons.add,
                  color: ServiceType.homeService.serviceColor,
                ),
                backgroundColor: colorScheme.onPrimary,
                borderColor: ServiceType.homeService.serviceColor,
                titleColor: ServiceType.homeService.serviceColor,
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                      const InsertHomeServiceServiceInfoPage(),
                    ),
                  );

                  cubit.refresh();
                },
              ),
            ],
          ),
        ),

        Space.h16,

        // ===================== OTHER SERVICES SECTION =====================
        BlocBuilder<HomeServiceEvaluationSecondStepCubit,
            HomeServiceEvaluationSecondStepState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              otherServiceLoading: () => true,
              orElse: () => false,
            );

            final hasOtherService =
                HomeServiceEvaluationSecondStepCubit.selectedServiceList
                    ?.any((e) => e.serviceCode == '99') ==
                    true;

            // ===================== LOADING =====================
            if (isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: ServiceType.homeService.serviceColor,
                ),
              );
            }

            // ===================== OTHER SERVICE FORM =====================
            if (hasOtherService) {
              return FormSectionContainer(
                hasBorder: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleLargeText(
                      text: 'سایر خدمات',
                      fontSize: 16,
                    ),

                    Space.h16,

                    Column(
                      children: HomeServiceEvaluationSecondStepCubit
                          .selectedServiceList!
                          .where((e) => e.serviceCode == '99')
                          .map((service) {
                        return ServiceAddedContainerWidget(
                          entity: service,
                          index: HomeServiceEvaluationSecondStepCubit
                              .selectedServiceList!
                              .indexOf(service),
                          onTapDelete: () {
                            cubit.deleteSelectedEvaluationService(
                              evaluationServiceEntity: service,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }

            // ===================== ONLY BUTTON =====================
            return Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => cubit.fetchOtherService(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      size: 20,
                      color: ServiceType.homeService.serviceColor,
                    ),
                    Space.w8,
                    Text(
                      'افزودن سایر خدمات',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ServiceType.homeService.serviceColor,
                          fontSize: 14
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}