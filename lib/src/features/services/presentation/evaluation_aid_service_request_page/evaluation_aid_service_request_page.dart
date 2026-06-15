import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/representation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/bottom_sheet/add_part_and_labor_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/cubit/evaluation_aid_service_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/widgets/evaluation_service_category_dynamic_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/widgets/selected_labor_and_part_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/widgets/service_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/widgets/transport_information_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/time_distance_form_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
              onPositive:(){
                context.pop();
                cubit.retryLastAction();
              },
            );
          },
          connectionError: () {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(onRetry: cubit.init),
              actionWidget: const SizedBox.shrink(),
              isDismissible: true,
              enableDrag: true,
            );
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
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<
                EvaluationAidServiceRequestCubit,
                EvaluationAidServiceRequestState>(
              builder: (context, state) {
                final cubit = context.read<EvaluationAidServiceRequestCubit>();
                final isLoading = state.maybeWhen(
                  submitLoading: () => true,
                  orElse: () => false,
                );
                return state.maybeWhen(
                    idle: () => const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                    orElse: () =>
                        InkwellButtonWidget(
                          title: 'ثبت فاکتور',
                          backgroundColor: ServiceType.reliefService
                              .serviceColor,
                          showLoading: isLoading,
                          onTap: cubit.submitEvaluationForAidService,
                        )
                );
              },
            )
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
            if (cubit.emdadgarInfo != null) ...[
              ExpandableSection(
                isExpanded: false,
                header: const BodyMediumText(text: "اطلاعات امداد رسان"),
                child: AgentInfoDetailSection(
                  agentInfo: cubit.emdadgarInfo!,
                  selectedRequest: cubit.selectedRequest,
                ),
              ),
              _formElementGap(),
            ],
            TimeDistanceFormSection(
              assignDateController: cubit.mainForm.assignDateController,
              assignTimeController: cubit.mainForm.assignTimeController,
              arriveDateController: cubit.mainForm.arriveDateController,
              arriveTimeController: cubit.mainForm.arriveTimeController,
              kilometerController: cubit.mainForm.kilometerController,
              customerDistanceController: cubit.mainForm.customerDistanceController,
              onAssignDateChange: cubit.mainForm.setAssignDate,
              onAssignTimeChange: cubit.mainForm.setAssignTime,
              onArriveDateChange: cubit.mainForm.setArriveDate,
              onArriveTimeChange: cubit.mainForm.setArriveTime,
            ),
            _formElementGap(),
            ServiceDetailSection(cubit: cubit),
            _formElementGap(),
            ValueListenableBuilder<ServiceCategoryEntity?>(
              valueListenable: cubit.selectedServiceCategory,
              builder: (context, selectedServiceCategory, _) {
                return EvaluationServiceCategoryDynamicSection(
                  selectedServiceCategory: selectedServiceCategory,
                  transportSection:  TransportInformationSection<RepresentationEntity>(
                    controller: cubit.transportForm,
                    representationTitleBuilder: (item) => item.label,
                    onSelectRepresentation: cubit.transportForm.setSelectedRepresentation,
                  ),
                  laborAndPartSection: SelectedLaborAndPartSection(
                    selectedLaborsListenable: cubit.selectedLaborsNotifier,
                    expandedLaborIdsListenable: cubit
                        .expandedLaborPartListIdsNotifier,
                    onAddLabor: () {
                      cubit.prepareCreateLaborAndPartSheet();

                      cubit.markBottomSheetOpen();
                      showAddPartAndLaborBottomSheet(context).whenComplete(() {
                        cubit.markBottomSheetClosed();
                      });
                    },
                    onAddPart: (labor) async {
                      final canOpen = await cubit.addPartToSelectedLabor(labor);

                      if (!context.mounted) return;

                      if (canOpen) {
                        cubit.markBottomSheetOpen();
                        showAddPartAndLaborBottomSheet(context).whenComplete(() {
                          cubit.markBottomSheetClosed();
                        });
                      }
                    },
                    onEditLabor: (labor) async {
                      final canOpen = await cubit.editSelectedLabor(labor);

                      if (!context.mounted) return;

                      if (canOpen) {
                        cubit.markBottomSheetOpen();
                        showAddPartAndLaborBottomSheet(context).whenComplete(() {
                          cubit.markBottomSheetClosed();
                        });
                      }
                    },
                    onDeleteLabor: cubit.removeSelectedLabor,
                    onToggleShowMoreParts: cubit
                        .toggleSelectedLaborPartsVisibility,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _formElementGap() => Space.h8;
}
