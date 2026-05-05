import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdad_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/cubit/update_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/widgets/map_message_box.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/widgets/service_item_widget.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/widgets/submit_button.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/static_map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/car_license_plate_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../evaluation/domain/entities/defect_entity.dart';

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
            child: const CircularProgressIndicator(),
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
            FormSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleLargeText(text: "ویرایش اطلاعات خودرو", fontSize: 16,),
                  Space.h32,
                  TextFormFieldWidget(
                    labelText: "شماره تماس",
                    controller: cubit.clientPhoneNumberController,
                    autofocus: false,
                    textInputType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,
                  ),
                  Space.h32,
                  LicensePlateTextFormFieldWidget(
                    mandatory: true,
                    controller: cubit.licensePlateController,
                  ),
                  Space.h32,
                  ValueListenableBuilder<DefectEntity?>(
                    valueListenable: cubit.selectedDefect,
                    builder: (_, selectedDefect, __) {
                      return SizedBox(
                        height: 52,
                        child: FilterButton(
                          title: selectedDefect?.title ?? "انتخاب عیب",
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
                  )
                ],
              ),
            ),

            FormSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleLargeText(text: "سرویس خودرو"),
                  Space.h32,
                  ValueListenableBuilder<bool>(
                    valueListenable: context
                        .read<UpdateRequestCubit>()
                        .showAllServices,
                    builder: (context, value, _) {
                      final theme = Theme.of(context);

                      return Row(
                        children: [
                          Checkbox(
                            value: value,
                            onChanged: (v) {
                              context
                                  .read<UpdateRequestCubit>()
                                  .toggleShowAllServices(v ?? false);
                            },
                            checkColor: Colors.white,
                            activeColor: Colors.green,
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap,
                            side: BorderSide(
                              color: theme.colorScheme.onSecondaryFixed,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            visualDensity: const VisualDensity(
                                horizontal: -2, vertical: -2),
                          ),
                          const BodyMediumText(text: "همه سرویس ها"),
                        ],
                      );
                    },
                  ),
                  Space.h8,
                  ValueListenableBuilder<List<EmdadServiceEntity>>(
                    valueListenable: context
                        .read<UpdateRequestCubit>()
                        .filteredServices,
                    builder: (context, services, _) {
                      final cubit = context.read<UpdateRequestCubit>();
                      final colorScheme = Theme
                          .of(context)
                          .colorScheme;

                      return ValueListenableBuilder<EmdadServiceEntity?>(
                        valueListenable: cubit.selectedService,
                        builder: (context, selectedValue, __) {
                          return Column(
                            children: [
                              for (var service in services) ...[
                                ServiceItemWidget(
                                  title: service.serviceTitle,
                                  status: service.isSubscribedByNationalCode
                                      ? "مشترک"
                                      : "غیر مشترک",
                                  selected: selectedValue?.serviceId ==
                                      service.serviceId,
                                  selectedColor: colorScheme.primary,
                                  labelColor: service.isSubscribedByNationalCode
                                      ? colorScheme.onError
                                      : colorScheme.error,

                                  onTap: () {
                                    cubit.setSelectedService(service);
                                  },
                                  isSelectable: service.isSelectable,
                                ),
                                Space.h8,
                              ]
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            FormSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BodyMediumText(text: "موقعیت و آدرس"),
                  Space.h32,

                  // MAP
                  SizedBox(
                    height: 280,
                    child: Stack(
                      children: [
                        StaticMapWidget(
                          latitude: cubit.selectedRequest?.latitude ?? 0,
                          longitude: cubit.selectedRequest?.longitude ?? 0,
                        ),

                        Positioned(
                          bottom: 12,
                          left: 12,
                          right: 12,
                          child: Container(

                            margin: const EdgeInsets.symmetric(
                                horizontal: 94, vertical: 6),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(16),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
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

                  Space.h24,

                  // message example
                  MapMessageBox(
                    message:
                        "این محدوده در طرح ترافیک قرار دارد و ممکن است محدودیت تردد داشته باشد.",
                  ),

                  Space.h24,
                  ValueListenableBuilder<ProvinceEntity?>(
                    valueListenable: cubit.selectedProvince,
                    builder: (_, selectedDefect, __) {
                      return SizedBox(
                        height: 52,
                        child: FilterButton(
                          title: selectedDefect?.title ?? "انتخاب شهر و استان",
                          label: 'شهر و استان',
                          hasFloatingLabel: true,
                          expand: true,
                          overlayBuilder: (context, position, width, dismiss) {
                            return OverlayDropdownMenu<ProvinceEntity>(
                              position: position,
                              width: width,
                              items: cubit.provinceList,
                              onDismiss: dismiss,
                              onSelect: (item) {
                                cubit.setSelectedProvince(item);
                                dismiss();
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Space.h24,
                  TextFormFieldWidget(
                    labelText: "آدرس",
                    controller: cubit.addressController,
                    autofocus: false,
                    textInputType: TextInputType.streetAddress,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,
                    maxLines: 3,
                  ),

                  Space.h24,

                  TextFormFieldWidget(
                    labelText: "توضیحات",
                    controller: cubit.descriptionController,
                    autofocus: false,
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,
                    maxLines: 3,
                    //validator: (value) => cubit.phoneNumberValidate(value),
                  ),
                ],
              ),
            ),
            Space.h24,
            SubmitButtonWidget(formKey: cubit.formKey),
            Space.h16,
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
