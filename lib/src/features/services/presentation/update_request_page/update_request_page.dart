import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/cubit/update_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/widgets/map_message_box.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/widgets/service_item_widget.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/widgets/submit_button.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/car_license_plate_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateRequestPage extends StatelessWidget {
  static const path = "/update-request-page";
  static const name = "update-request-page";

  const UpdateRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UpdateRequestCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateRequestCubit>();

    return BlocListener<UpdateRequestCubit, UpdateRequestState>(
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
          loadMoreError: (message) =>
              SnakeBarWidget.showError(context: context, message: message),
        );
      },
      child: const Scaffold(
        appBar: SimpleAppBar(title: "ویرایش درخواست"),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateRequestCubit, UpdateRequestState>(
      builder: (context, state) {
        final cubit = context.read<UpdateRequestCubit>();
        return state.maybeWhen(
          idle: () => const SizedBox.shrink(),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: cubit.selectedRequest?.serviceType?.serviceColor,
            ),
          ),
          orElse: () => const _LoadedView(),
        );
      },
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateRequestCubit>();

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
              header: _buildRequestStatusSection(cubit),
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
            //here
            FormSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyMediumText(text: "اطلاعات خودرو"),
                  Space.h12,
                  TextFormFieldWidget(
                    labelText: "شماره تماس",
                    controller: cubit.clientPhoneNumberController,
                    autofocus: false,
                    textInputType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,

                    //validator: (value) => cubit.phoneNumberValidate(value),
                  ),
                  Space.h12,
                  LicensePlateTextFormFieldWidget(
                    mandatory: true,
                    controller: cubit.licensePlateController,
                  ).animate().fade(duration: 500.ms),
                ],
              ),
            ),

            FormSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BodyMediumText(text: "سرویس خودرو"),
                  Space.h12,

                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (v) {
                          // call api
                        },
                      ),
                      const BodyMediumText(text: "همه سرویس ها"),
                    ],
                  ),

                  Space.h12,

                  ServiceItemWidget(
                    title: "تعویض باتری",
                    status: "فعال",
                    selected: true,
                    selectedColor: Colors.green,
                    onTap: () {}, labelColor: Colors.green,
                  ),

                  Space.h8,

                  ServiceItemWidget(
                    title: "پنچرگیری",
                    status: "غیرفعال",
                    selected: false,
                    selectedColor: Colors.green,
                    onTap: () {}, labelColor: Colors.green,
                  ),
                ],
              ),
            ),
            FormSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BodyMediumText(text: "موقعیت و آدرس"),
                  Space.h12,

                  // MAP
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.grey.shade300, // map placeholder
                        ),

                        Positioned(
                          bottom: 12,
                          left: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: const BodyMediumText(
                              text: "انتخاب روی نقشه",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Space.h12,

                  // message example
                  MapMessageBox(
                    message:
                        "این محدوده در طرح ترافیک قرار دارد و ممکن است محدودیت تردد داشته باشد.",
                  ),

                  Space.h12,

                  // dropdowns
                  /*  const _DropdownField(),
                  Space.h12,
                  const _DropdownField(),*/
                  Space.h12,

                  // address
                  TextFormFieldWidget(
                    labelText: "آدرس",
                    controller: cubit.addressController,
                    autofocus: false,
                    textInputType: TextInputType.streetAddress,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,

                    //validator: (value) => cubit.phoneNumberValidate(value),
                  ),

                  Space.h12,

                  // description
                  TextFormFieldWidget(
                    labelText: "توضیحات",
                    controller: cubit.descriptionController,
                    autofocus: false,
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,
                    //validator: (value) => cubit.phoneNumberValidate(value),
                  ),
                ],
              ),
            ),
            Space.h12,
            SubmitButtonWidget(formKey: cubit.formKey),
          ],
        ),
      ),
    );
  }

  RequestStatusSection _buildRequestStatusSection(UpdateRequestCubit cubit) {
    return RequestStatusSection(
      trackCode: cubit.selectedRequest?.trackCode.toString() ?? '-',
      requestDateJalali:
          cubit.selectedRequest?.requestDateJalali.toString() ?? '-',
      requestTime: cubit.selectedRequest?.requestTime.toString() ?? '-',
      requestStatusTitle: cubit.selectedRequest?.requestStatusTitle,
      isGuaranty: cubit.selectedRequest?.isGuaranty ?? false,
      isSubscription: cubit.selectedRequest?.isSubscription ?? false,
    );
  }
}
