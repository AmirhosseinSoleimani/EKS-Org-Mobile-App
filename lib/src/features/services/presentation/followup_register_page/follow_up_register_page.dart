import 'package:eks_sana_plus_org/src/common/constants/source.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/follow_up_status_type_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/followup_register_page/cubit/follow_up_register_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/followup_register_page/widgets/dispatch_time_diff_box.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/followup_register_page/widgets/request_followup_history_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/date_time_picker_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowUpRegisterPage extends StatelessWidget {
  static const path = "/follow-up-register-page";
  static const name = "follow-up-register-page";

  const FollowUpRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FollowUpRegisterCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FollowUpRegisterCubit>();
    return BlocListener<FollowUpRegisterCubit, FollowUpRegisterState>(
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
           submitSuccess:  (data) {
            BottomSheetMessage.showNotice(
              isDismissible: false,
              context: context,
              data: BottomSheetMessageModel(
                title: '',
                message: 'پیگیری ثبت گردید',
              ),
            );
           },
        );
      },
      child: Scaffold(

        appBar: SimpleAppBar(title: 'ثبت پیگیری'),
        body: _Body(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<FollowUpRegisterCubit, FollowUpRegisterState>(
            builder: (context, state) {
              final cubit = context.read<FollowUpRegisterCubit>();
              final isLoading = state.maybeWhen(
                submitLoading: () => true,
                orElse: () => false,
              );
              return state.maybeWhen(
                idle: () => const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                orElse: () => InkwellButtonWidget(
                  title: 'ثبت پیگیری',
                  showLoading: isLoading,
                  onTap: cubit.createFollowUp,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowUpRegisterCubit, FollowUpRegisterState>(
      builder: (context, state) {
        final cubit = context.read<FollowUpRegisterCubit>();
        return state.maybeWhen(
          idle: () => const SizedBox.shrink(),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: cubit.selectedRequest?.serviceType?.serviceColor,
            ),
          ),
          orElse: () => _LoadedView(),
        );
      },
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FollowUpRegisterCubit>();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleLargeText(text: "پیگیری جدید", fontSize: 16),
                  Space.h32,
                  DropdownSelector<Source>(
                    label: "نوع منبع پیگیری",
                    placeholder: "انتخاب",
                    selectedNotifier: cubit.selectedSource,
                    items: Source.values.toList(),
                    itemTitleBuilder: (item) => item.label,
                    onSelect: (item) => cubit.setSelectedSource(item),
                  ),
                  _formElementGap(),
                  ValueListenableBuilder<List<FollowUpStatusTypeEntity>>(
                    valueListenable: cubit.filteredStatusItems,
                    builder: (context, filteredList, _) {
                      return DropdownSelector<FollowUpStatusTypeEntity>(
                        label: "نتیجه",
                        placeholder: "انتخاب",
                        selectedNotifier: cubit.selectedFollowUpStatusType,
                        items: filteredList,
                        itemTitleBuilder: (item) => item.title ?? "",
                        onSelect: (item) =>
                            cubit.setSelectedFollowupStatus(item),
                      );
                    },
                  ),
                  _formElementGap(),
                  DateTimePickerSection(
                    dateLabel: 'تاریخ اعلام',
                    timeLabel: 'ساعت اعلام',
                    dateController: cubit.announcementDateController,
                    timeController: cubit.announcementTimeController,
                    onDateChange: cubit.setAnnouncementDate,
                    onTimeChange: cubit.setAnnouncementTime,
                  ),
                  _formElementGap(),
                  ValueListenableBuilder<Duration?>(
                    valueListenable: cubit.announcementDiffNotifier,
                    builder: (_, diff, __) {
                      if (diff == null || diff.inMinutes == 0) return SizedBox.shrink();
                      return Column(
                        children: [
                          DispatchTimeDiffBox(timeDiff: diff),
                          _formElementGap(),
                        ],
                      );
                    },
                  ),
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
            FormSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleLargeText(text: "تاریخچه پیگیری", fontSize: 16),
                  Space.h32,
                  const RequestFollowupHistorySection(),
                  _formElementGap(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _formElementGap() => Space.h16;
}
