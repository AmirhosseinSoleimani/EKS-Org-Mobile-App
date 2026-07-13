import 'dart:ui';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/car_covers_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cancel_request_page/widgets/action_text_field.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/complete_urgent_request_page/cubit/complete_urgent_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/two_text_fields_row.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/widget_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/car_license_plate_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/gender_selector_widget.dart';

class CompleteUrgentRequestPage extends StatelessWidget {
  static const path = "/complete-urgent-request-page";
  static const name = "complete-urgent-request-page";

  const CompleteUrgentRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CompleteUrgentRequestCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CompleteUrgentRequestCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<CompleteUrgentRequestCubit, CompleteUrgentRequestState>(
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
              content: NoInternetBottomSheet(onRetry: cubit.retryLastAction),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
          submitSuccess: (data) {
            BottomSheetMessage.showNoticeWithAction(
              context: context,
              data: BottomSheetMessageModel(
                title: '',
                message: data.message ?? 'درخواست با موفقیت ثبت شد',
              ),
              onPositive: (){
                context.pop;
                context.pop;
              },
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: WidgetAppBar(
          title: Row(
            children: [
              TitleMediumText(text: 'تکمیل درخواست اضطراری'),
              Space.w8,
              StatusLabel(
                color: colorScheme.error,
                text: 'اضطراری',
                variant: StatusLabelVariant.outlined,
              ),
            ],
          ),
        ),
        body: _Body(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child:
              BlocBuilder<
                CompleteUrgentRequestCubit,
                CompleteUrgentRequestState
              >(
                builder: (context, state) {
                  final cubit = context.read<CompleteUrgentRequestCubit>();
                  final isLoading = state.maybeWhen(
                    submitLoading: () => true,
                    orElse: () => false,
                  );
                  return state.maybeWhen(
                    idle: () => const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                    orElse: () => SubmitCancelButtons(
                      submitButtonColor:
                          cubit.selectedRequest?.serviceType?.serviceColor ??
                          ServiceType.reliefService.serviceColor,
                      onSubmit: cubit.submit,
                      onCancel: () => Navigator.pop(context),
                      submitTitle: 'ثبت درخواست',
                      isLoading: isLoading,
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
    return BlocBuilder<CompleteUrgentRequestCubit, CompleteUrgentRequestState>(
      builder: (context, state) {
        final cubit = context.read<CompleteUrgentRequestCubit>();
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
    final cubit = context.read<CompleteUrgentRequestCubit>();

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.s16),
        child: Column(
          children: [
            FormSectionContainer(
              hasBorder: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleLargeText(text: "اطلاعات خودرو", fontSize: 16),
                  Space.h32,
                  ActionTextField(
                    controller: cubit.chassisNumberController,
                    onActionTap: cubit.getReferenceCar,
                    labelText: "شماره شاسی",
                    loadingListenable: cubit.isGettingReferenceCar,
                    hintText: "",
                  ),
                  _formElementGap(),
                  DropdownSelector<CoverCarEntity>(
                    label: "نوع خودرو",
                    placeholder: "انتخاب کنید",
                    selectedNotifier: cubit.selectedCoverCars,
                    items: cubit.baseData?.coverCars ?? [],
                    enabled: cubit.baseData?.coverCars?.isNotEmpty ?? false,
                    itemTitleBuilder: (item) => item.label,
                    onSelect: (item) => cubit.setSelectedCoverCar(item),
                  ),
                  _formElementGap(),
                  TextFormFieldWidget(
                    controller: cubit.engineNumberController,
                    labelText: 'شماره موتور',
                  ),
                  _formElementGap(),

                  DropdownSelector<CarColorEntity>(
                    label: "رنگ",
                    placeholder: "انتخاب کنید",
                    selectedNotifier: cubit.selectedColorCar,
                    items: cubit.baseData?.carColors ?? [],
                    enabled: cubit.baseData?.carColors?.isNotEmpty ?? false,
                    itemTitleBuilder: (item) => item.label,
                    onSelect: (item) => cubit.setSelectedColorCar(item),
                  ),
                  _formElementGap(),

                  TwoTextFieldsRow(
                    firstController: cubit.buildYearController,
                    secondController: cubit.kilometerController,
                    firstLabel: 'سال ساخت',
                    secondLabel: 'کیلومتر خودرو',
                    firstKeyboardType: TextInputType.number,
                    secondKeyboardType: TextInputType.number,
                  ),
                  _formElementGap(),
                  LicensePlateTextFormFieldWidget(
                    mandatory: true,
                    controller: cubit.licensePlateController,
                  ),
                ],
              ),
            ),
            FormSectionContainer(
              hasBorder: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleLargeText(text: "اطلاعات شخصی", fontSize: 16),
                  Space.h32,
                  ActionTextField(
                    controller: cubit.nationalCodeController,
                    loadingListenable: cubit.isGettingCustomerInfo,
                    onActionTap: cubit.getUserInfo,
                    labelText: "کد ملی",
                    hintText: "",
                  ),

                  _formElementGap(),
                  TextFormFieldWidget(
                    controller: cubit.nameController,
                    labelText: 'نام',
                  ),
                  _formElementGap(),
                  TextFormFieldWidget(
                    controller: cubit.familyNameController,
                    labelText: 'نام خانوادگی',
                  ),

                  _formElementGap(),
                  GenderSelectorWidget(
                    selectedListenable: cubit.genderNotifier,
                    onChanged: (gender) => cubit.genderNotifier.value = gender,
                  ),

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
