import 'package:emdadgar_saipa/generated/l10n.dart';
import 'package:eks_sana_plus_org/src/config/themes/app_theme.dart';
import 'package:eks_sana_plus_org/src/core/presentation/pages/base_stateless_page.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_widgets.dart';
import 'package:eks_sana_plus_org/src/core/uikit/spacing.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_button/ek_button.dart';
import 'package:eks_sana_plus_org/src/core/uikit/widget/ek_loading/ek_loading.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/add__home_service_image/page/add_photo_home_service_page.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_packages/page/home_service_evaluation_packages_page.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/widgets/service_added_container_widget.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/widgets/service_customer_container_widget.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/service_list/service_list_widget.dart';
import 'package:eks_sana_plus_org/src/features/invoice/domain/entity/invoice_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice/presentation/pre_invoice/pages/invoice_page.dart';
import 'package:eks_sana_plus_org/src/features/request/domain/entity/get_request_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/home_service_evaluation_second_step_cubit.dart';
import 'cubit/home_service_evaluation_second_step_state.dart';

class HomeServiceEvaluationSecondStep extends BaseStatelessPage {
  const HomeServiceEvaluationSecondStep({Key? key}) : super(key: key);

  @override
  bool? showAppBarDetails(BuildContext context) {
    return true;
  }

  @override
  String? screenName(BuildContext context) {
    return 'ثبت ارزیابی';
  }

  @override
  Widget body(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        var bloc = getIt<HomeServiceEvaluationSecondStepCubit>();
        bloc.initState();
        return bloc;
      },
      child: const Padding(
        padding: EdgeInsets.all(Space.defaultPadding),
        child: _BuildBody(),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeServiceEvaluationSecondStepCubit, HomeServiceEvaluationSecondStepState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (dialogDataModel) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialogWidget(
                  color: AppTheme.blue,
                  dismissible: false,
                  title: '',
                  body: dialogDataModel.description,
                  positiveFunc: () {
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
          submitError: (dialogDataModel) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MessageDialogWidget(
                  color: AppTheme.blue,
                  dismissible: false,
                  title: '',
                  body: dialogDataModel.description,
                );
              },
            );
          },
          submitSuccess: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => InvoicePage(
                preInvoiceRequestEntity: InvoiceRequestEntity(
                  serviceType: 2,
                  serviceRequestId: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.id ?? 0,
                  emdadgarEvaluationId: context.read<HomeServiceEvaluationSecondStepCubit>().id,
                ),
                /// TODO Improved GetRequestEntity
                requestEntity: GetRequestEntity(
                  firstName: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.firstName,
                  lastName: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.lastName,
                  defectTitle: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.defectTitle,
                  defectId: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.defectId,
                  serviceType: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.serviceType,
                  serviceTitles: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.serviceTitles,
                  carName: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.carName,
                  chassisNumber: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.chassisNumber,
                  trackCode: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.trackCode,
                  id: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.id,
                  serviceCategoryTitle: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.serviceCategoryTitle,
                  subscription: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.subscription,
                  garanty_IsGaranty: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull?.guaranty,
                ),
              ),
            ),
          ),
          submitNeedPhotoSuccess: () =>  Navigator.push(context, MaterialPageRoute(builder: (_) => AddPhotoHomeServicePage(
            lastEvaluationEntity: context.read<HomeServiceEvaluationSecondStepCubit>().lastEvaluationValue,
            emdadgarEvaluationId: context.read<HomeServiceEvaluationSecondStepCubit>().id,
            activeServiceRequestResponseEntity: context.read<HomeServiceEvaluationSecondStepCubit>().activeServiceRequestStream.valueOrNull,
          )))
        );
      },
      builder: (context, state) {
        final cubit = context.read<HomeServiceEvaluationSecondStepCubit>();
        return state.maybeWhen(
          loading: () => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EkLoading(),
            ],
          ),
          orElse: () {
            return ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                InkWell(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const InsertHomeServiceServiceInfoPage()));
                    cubit.refresh();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: AppTheme.blue),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      'افزودن سرویس',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.blue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Space.h16,
                BlocBuilder<HomeServiceEvaluationSecondStepCubit, HomeServiceEvaluationSecondStepState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          if(HomeServiceEvaluationSecondStepCubit.customerServiceList?.isNotEmpty ?? false) {
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
                          } else {
                            return const SizedBox();
                          }
                          },
                      );
                    },
                ),
                if (HomeServiceEvaluationSecondStepCubit.selectedServiceList?.isNotEmpty ?? false) ...[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: HomeServiceEvaluationSecondStepCubit
                        .selectedServiceList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ServiceAddedContainerWidget(
                        entity: HomeServiceEvaluationSecondStepCubit.selectedServiceList?[index] ?? EvaluationServiceEntity(),
                        onTapDelete: () => cubit.deleteSelectedEvaluationService(
                          evaluationServiceEntity: HomeServiceEvaluationSecondStepCubit.selectedServiceList?[index],
                        ),
                        index: index,
                      );
                    },
                  ),
                ],
                Space.h16,
                StreamBuilder<bool?>(
                  stream: cubit.addOtherServiceSubject.stream,
                  builder: (context,  snapshot) {
                    if(snapshot.data == true) {
                      return const SizedBox();
                    } else {
                      return BlocBuilder<HomeServiceEvaluationSecondStepCubit, HomeServiceEvaluationSecondStepState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                              otherServiceLoading: () => const Center(
                                child: EkLoading(),
                              ),
                              otherServiceSuccess: () => const SizedBox(),
                              orElse: () => InkWell(
                                onTap: () async {
                                  cubit.fetchOtherService();
                                  },
                                child: Row(
                                  children: [
                                    const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: AppTheme.blue,
                                ),
                                Space.w8,
                                Text(
                                  'افزودن سایر خدمات',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.blue,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          );
                        },
                      );
                    }
                  },
                ),
                Space.h24,
                //submit and continue button
                BlocBuilder<HomeServiceEvaluationSecondStepCubit, HomeServiceEvaluationSecondStepState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      submitLoading: () => EkButton(
                        backgroundColor: AppTheme.blue,
                        title: S.of(context).saveAndContinue,
                        onTap: () {},
                        showLoading: true,
                      ),
                      orElse: () => EkButton(
                          backgroundColor: AppTheme.blue,
                          title: S.of(context).saveAndContinue,
                          onTap: () {
                            cubit.postEvaluation();
                          }),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

