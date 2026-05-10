import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cancel_request_page/cubit/cancel_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cancel_request_page/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cancel_request_page/widgets/action_text_field.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cancel_request_page/widgets/invoice_bottom_sheet_content.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/submit_cancel_buttons.dart';
import 'widgets/date_time_picker_section.dart';

class CancelRequestPage extends StatelessWidget {
  static const path = "/cancel-request-page";
  static const name = "cancel-request-page";

  const CancelRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CancelRequestCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CancelRequestCubit>();

    return BlocListener<CancelRequestCubit, CancelRequestState>(
      listener: (context, state) {
        state.whenOrNull(
          showPreInvoice: (invoice) {
            _showInvoiceBottomSheet(context, invoice);
          },

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
          submitSuccess: () => context.pop(),
        );
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: SimpleAppBar(title: "لغو درخواست"),
        body: _Body(),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<CancelRequestCubit, CancelRequestState>(
              builder: (context, state) {
                final cubit = context.read<CancelRequestCubit>();
                final isLoading = state.maybeWhen(
                  submitLoading: () => true,
                  orElse: () => false,
                );
                return state.maybeWhen(
                  idle: () => const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                  orElse: () =>
                      SubmitCancelButtons(
                        onSubmit: cubit.submit,
                        onCancel: () => Navigator.pop(context),
                        submitTitle: 'لغو درخواست',
                        isLoading: isLoading,
                      ),
                );
              },
            )
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CancelRequestCubit, CancelRequestState>(
      builder: (context, state) {
        final cubit = context.read<CancelRequestCubit>();
        return state.maybeWhen(
          idle: () => const SizedBox.shrink(),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: cubit.selectedRequest?.serviceType?.serviceColor,
            ),
          ),
          orElse: () =>
              _LoadedView(
                  showSecondDropDown: cubit.isSecondDropDownVisible,
                  showDateTimeSection: cubit.isDateTimeSectionVisible),
        );
      },
    );
  }
}

class _LoadedView extends StatelessWidget {
  final bool showSecondDropDown;
  final bool showDateTimeSection;

  const _LoadedView({
    required this.showSecondDropDown,
    required this.showDateTimeSection,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CancelRequestCubit>();

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
              hasBorder: true,
              header: RequestStatusSection(request: cubit.selectedRequest),
              child: RequestDetailSection(
                selectedRequest: cubit.selectedRequest,
                showCustomerInfo: true,
              ),
            ),
            if (cubit.emdadgarInfo != null) ...[
              ExpandableSection(
                hasBorder: true,
                brief: BodySmallText(
                  text:
                      "${cubit.emdadgarInfo?.agencyName ?? ''} | ${cubit.emdadgarInfo?.mobile ?? ""}",
                ),
                isExpanded: false,
                header: const BodyMediumText(text: "اطلاعات امداد رسان"),
                child: AgentInfoDetailSection(agentInfo: cubit.emdadgarInfo!),
              ),
            ],
            Space.h8,
            FormSectionContainer(
              hasBorder: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownSelector<CancelRequestReasonEntity>(
                    label: "نوع لغو",
                    placeholder: "انتخاب نوع کنسلی",
                    selectedNotifier: cubit.selectedCancelType,
                    items: cubit.cancelRequestType,
                    itemTitleBuilder: (item) => item.title ?? "",
                    onSelect: (item) => cubit.setSelectedCancelType(item),
                  ),
                  Space.h16,
                  if (showSecondDropDown) ...[
                    DropdownSelector<CancelRequestReasonEntity>(
                      label: "دلیل لغو",
                      placeholder: "انتخاب دلیل کنسلی",
                      selectedNotifier: cubit.selectedCancelReason,
                      items: cubit.cancelRequestReasonNotifier.value,
                      enabled: cubit.cancelRequestReasonNotifier.value
                          .isNotEmpty,
                      isLoading: cubit.cancelRequestReasonNotifier.value
                          .isEmpty &&
                          cubit.selectedCancelType.value != null,
                      itemTitleBuilder: (item) => item.title ?? "",
                      onSelect: (item) => cubit.setSelectedCancelReason(item),
                    ),
                    Space.h16,
                  ],
                  if (showDateTimeSection) ...[
                    DateTimePickerSection(
                      dateLabel: 'تاریخ اعزام',
                      timeLabel: 'ساعت اعزام',
                      dateNotifier: cubit.dispatchDateTimeNotifier,
                      onDateChange: cubit.setDispatchDate,
                      onTimeChange: cubit.setDispatchTime,
                    ),
                    Space.h24,
                    DateTimePickerSection(
                      dateLabel: 'تاریخ کنسلی',
                      timeLabel: 'ساعت کنسلی',
                      dateNotifier: cubit.cancelDateTimeNotifier,
                      onDateChange: cubit.setCancelDate,
                      onTimeChange: cubit.setCancelTime,
                    ),
                    Space.h24,
                    ActionTextField(
                      controller: cubit.kilometerController,
                      readOnlyListenable: cubit.isDistanceKilometerEditable,
                      loadingListenable: cubit.isGettingDistanceKilometer,
                      onActionTap: cubit.getDistanceKilometer,
                      labelText: "کیلومتر طی شده",
                      hintText: "مقدار کیلومتر",
                    ),
                    Space.h24,
                  ],
                  TextFormFieldWidget(
                    labelText: "توضیحات",
                    controller: cubit.descriptionController,
                    autofocus: false,
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showInvoiceBottomSheet(BuildContext context, InvoiceEntity invoice) {
  BottomSheetMessage.showCustom(
    context: context,
    isDismissible: true,
    enableDrag: true,
    actionWidget: BlocBuilder<CancelRequestCubit, CancelRequestState>(
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          submitLoading: () => true,
          orElse: () => false,
        );
        return SubmitCancelButtons(
      onSubmit: context
          .read<CancelRequestCubit>()
          .acceptEvaluation,
      onCancel: () => Navigator.pop(context),
          submitTitle: 'تایید نهایی',
          isLoading: isLoading,
        );
      },
    ),
    content: InvoiceBottomSheetContent(invoiceEntity: invoice),

  );
}

