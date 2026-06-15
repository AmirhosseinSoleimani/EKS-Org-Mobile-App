import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_state.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeServiceEvaluationPage extends StatelessWidget {
  const HomeServiceEvaluationPage({
    super.key,
    required this.selectedRequest,
  });

  static const path = '/home-service-evaluation-page';
  static const name = 'home-service-evaluation-page';

  final HomeServiceRequestEntity selectedRequest;

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<HomeServiceEvaluationCubit>();

    return BlocProvider(
      create: (_) => cubit..init(),
      child: BlocListener<HomeServiceEvaluationCubit, HomeServiceEvaluationState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (data, message) {
              BottomSheetMessage.showErrorWithAction(
                context: context,
                data: message,
                onPositive: () => context
                    .read<HomeServiceEvaluationCubit>()
                    .init(),
              );
            },
            connectionError: (data) {
              BottomSheetMessage.showCustom(
                context: context,
                content: NoInternetBottomSheet(
                  onRetry: () => context
                      .read<HomeServiceEvaluationCubit>()
                      .init(),
                ),
                actionWidget: const SizedBox.shrink(),
                isDismissible: false,
                enableDrag: false,
              );
            },
            submitFailure: (data, message) {
              BottomSheetMessage.showErrorWithAction(
                context: context,
                data: message,
                onPositive: context
                    .read<HomeServiceEvaluationCubit>()
                    .submitEvaluation,
              );
            },
            sheetFailure: (data, sheetType, message) {
              BottomSheetMessage.showErrorWithAction(
                context: context,
                data: message,
                onPositive: () {},
              );
            },
          );
        },
        child: Scaffold(
          appBar: const MainAppBar(
            title: 'ثبت ارزیابی خدمت در محل',
          ),
          bottomNavigationBar: SafeArea(
            minimum: const EdgeInsets.all(AppSize.s16),
            child: BlocBuilder<HomeServiceEvaluationCubit,
                HomeServiceEvaluationState>(
              builder: (context, state) {
                final isSubmitting = state.maybeWhen(
                  submitLoading: (_) => true,
                  orElse: () => false,
                );

                return SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isSubmitting
                        ? null
                        : context
                        .read<HomeServiceEvaluationCubit>()
                        .submitEvaluation,
                    child: isSubmitting
                        ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                        : const Text('ثبت فاکتور'),
                  ),
                );
              },
            ),
          ),
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: BlocBuilder<HomeServiceEvaluationCubit,
                HomeServiceEvaluationState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: (_) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  orElse: () {
                    final pageData = state.data;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(AppSize.s16),
                      child: Column(
                        children: [
                          ExpandableSection(
                            isExpanded: true,
                            header: const BodyMediumText(
                              text: 'اطلاعات درخواست',
                            ),
                            child: RequestDetailSection(
                              selectedRequest: pageData.selectedRequest,
                              showCustomerInfo: true,
                            ),
                          ),

                          if (pageData.emdadgarInfo != null) ...[
                            const SizedBox(height: AppSize.s12),
                            ExpandableSection(
                              isExpanded: true,
                              header: const BodyMediumText(
                                text: 'اطلاعات امدادگر',
                              ),
                              child: AgentInfoDetailSection(
                                agentInfo: pageData.emdadgarInfo!,
                                selectedRequest: pageData.selectedRequest,
                              ),
                            ),
                          ],

                          const SizedBox(height: AppSize.s12),
                          ExpandableSection(
                            isExpanded: true,
                            header: const BodyMediumText(
                              text: 'زمان و مسافت',
                            ),
                            child: const SizedBox(
                              width: double.infinity,
                              child: Text('فرم زمان و مسافت اینجا اضافه می‌شود'),
                            ),
                          ),

                          const SizedBox(height: AppSize.s12),
                          ExpandableSection(
                            isExpanded: true,
                            header: const BodyMediumText(
                              text: 'جزئیات سرویس',
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: context
                                    .read<HomeServiceEvaluationCubit>()
                                    .openAddPackageSheet,
                                child: const Text('افزودن سرویس'),
                              ),
                            ),
                          ),

                          const SizedBox(height: AppSize.s12),
                          ExpandableSection(
                            isExpanded: false,
                            header: const BodyMediumText(
                              text: 'سایر خدمات',
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: context
                                    .read<HomeServiceEvaluationCubit>()
                                    .openExtraServiceSheet,
                                child: const Text('افزودن سایر خدمات'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}