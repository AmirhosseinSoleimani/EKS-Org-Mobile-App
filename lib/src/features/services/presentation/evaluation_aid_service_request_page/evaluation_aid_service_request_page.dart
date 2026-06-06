import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/bottom_sheet/add_part_and_labor_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/cubit/evaluation_aid_service_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/labeled_check_box_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/time_distance_form_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/focus_node/always_disabled_focus_node.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
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
                          onTap: cubit.submit,
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
    final colorScheme = Theme.of(context).colorScheme;
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
            _formElementGap(),
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
            ),
            _formElementGap(),
            buildServiceDetailSection(cubit),
            _formElementGap(),
            FormSectionContainer(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleLargeText(
                  text: 'اجرت و قطعه', fontSize: 16,
                  textAlign: TextAlign.start,),
                Space.h32,
               InkwellButtonWidget(
                 title: 'افزودن اجرت',
                 prefixIcon: Icon(Icons.add, color: colorScheme.primary),
               titleColor: colorScheme.primary,
               borderColor: colorScheme.primary,
               backgroundColor: Colors.transparent,
               onTap: () {
                 cubit.markBottomSheetOpen();

                 showAddPartAndLaborBottomSheet(context).whenComplete(() {
                   cubit.markBottomSheetClosed();
                 });
               },),
                Space.h16,

              ],)),
          ],
        ),
      ),
    );
  }

  FormSectionContainer buildServiceDetailSection(
      EvaluationAidServiceRequestCubit cubit,) {
    return FormSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleLargeText(
            text: 'جزئیات سرویس',
            fontSize: 16,
            textAlign: TextAlign.start,
          ),

          Space.h32,

          DropdownSelector<DefectEntity>(
            label: 'ایراد خودرو',
            placeholder: 'انتخاب ایراد خودرو',
            selectedNotifier: cubit.selectedDefect,
            items: cubit.defectList,
            itemTitleBuilder: (item) => item.title ?? '',
            onSelect: (item) => cubit.selectDefect(item),
          ),

          Space.h16,

          ValueListenableBuilder<List<ServiceCategoryEntity>>(
            valueListenable: cubit.serviceCategoryList,
            builder: (_, serviceCategories, __) {
              final isLoading = cubit.categoriesLoading.value;
              return DropdownSelector<ServiceCategoryEntity>(
                label: 'نوع امداد',
                placeholder: isLoading
                    ? 'در حال بارگذاری...'
                    : 'انتخاب نوع امداد',
                selectedNotifier: cubit.selectedServiceCategory,
                items: serviceCategories,
                enabled: serviceCategories.isNotEmpty,
                isLoading: isLoading,
                itemTitleBuilder: (item) => item.title ?? '',
                onSelect: (item) => cubit.setSelectedServiceCategory(item),
              );
            },
          ),

          Space.h16,

          TextFormFieldWidget(
            controller: cubit.serviceController,
            labelText: 'سرویس',
            textInputType: TextInputType.none,
            focusNode: AlwaysDisabledFocusNode(),
            readOnly: true,
            borderColor: Colors.grey.shade400,
            backgroundColor: Colors.grey.shade100,

          ),

          Space.h16,

          TextFormFieldWidget(
            labelText: 'توضیحات',
            controller: cubit.descriptionController,
            autofocus: false,
            textInputType: TextInputType.text,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.done,
            maxLines: 3,
          ),

          Space.h16,

          LabeledCheckboxRow(
            title: 'عوارض آزاد راهی پرداخت شد',
            notifier: cubit.isFreewayTollPaid,
            activeColor: ServiceType.reliefService.serviceColor,
          ),
        ],
      ),
    );
  }

  SizedBox _formElementGap() => Space.h8;
}
