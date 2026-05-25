import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/bottom_sheet/add_part_and_labor_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/cubit/evaluation_aid_service_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/labeled_check_box_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/time_distance_form_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
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
              isDismissible: false,
              enableDrag: false,
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
                ValueListenableBuilder<ServiceCategoryEntity?>(
                  valueListenable: cubit.selectedServiceCategory,
                  builder: (_, selectedDefect, _) {
                    return SizedBox(
                      height: 52,
                      child: FilterButton(
                        title: selectedDefect?.title ?? "انتخاب نوع امداد",
                        label: 'نوع امداد',
                        hasFloatingLabel: true,
                        expand: true,
                        overlayBuilder: (context, position, width, dismiss) {
                          return OverlayDropdownMenu<ServiceCategoryEntity>(
                            position: position,
                            width: width,
                            items: cubit.serviceCategoryList,
                            onDismiss: dismiss,
                            onSelect: (item) {
                              cubit.setSelectedServiceCategory(item);
                              dismiss();
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                Space.h16,
                TextFormFieldWidget(
                  controller: cubit.serviceController,
                  labelText: 'سرویس',
                  textInputType: TextInputType.text,
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

              ],)),
          ],
        ),
      ),
    );
  }

  FormSectionContainer buildServiceDetailSection(EvaluationAidServiceRequestCubit cubit) {
    return FormSectionContainer(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleLargeText(
                text: 'جزئیات سرویس',
                fontSize: 16,
                textAlign: TextAlign.start,),
              Space.h32,
              ValueListenableBuilder<DefectEntity?>(
                valueListenable: cubit.selectedDefect,
                builder: (_, selectedDefect, _) {
                  return SizedBox(
                    height: 52,
                    child: FilterButton(
                      title: selectedDefect?.title ?? "انتخاب ایراد خودرو",
                      label: 'ایراد خودرو',
                      hasFloatingLabel: true,
                      expand: true,
                      overlayBuilder: (context, position, width, dismiss) {
                        return OverlayDropdownMenu<DefectEntity>(
                          position: position,
                          width: width,
                          items: cubit.defectList,
                          onDismiss: dismiss,
                          onSelect: (item) {
                            cubit.setSelectedDefect(item);
                            dismiss();
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              Space.h16,
              ValueListenableBuilder<ServiceCategoryEntity?>(
                valueListenable: cubit.selectedServiceCategory,
                builder: (_, selectedDefect, _) {
                  return SizedBox(
                    height: 52,
                    child: FilterButton(
                      title: selectedDefect?.title ?? "انتخاب نوع امداد",
                      label: 'نوع امداد',
                      hasFloatingLabel: true,
                      expand: true,
                      overlayBuilder: (context, position, width, dismiss) {
                        return OverlayDropdownMenu<ServiceCategoryEntity>(
                          position: position,
                          width: width,
                          items: cubit.serviceCategoryList,
                          onDismiss: dismiss,
                          onSelect: (item) {
                            cubit.setSelectedServiceCategory(item);
                            dismiss();
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              Space.h16,
              TextFormFieldWidget(
                controller: cubit.serviceController,
                labelText: 'سرویس',
                textInputType: TextInputType.text,
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

            ],));
  }

  SizedBox _formElementGap() => Space.h8;
}
