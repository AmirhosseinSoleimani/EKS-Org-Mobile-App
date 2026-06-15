import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/change_home_service_request_address_page/cubit/change_home_service_request_address_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/address_location_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeHomeServiceRequestAddressPage extends StatelessWidget {
  static const path = "/change-home-service-request-address-page";
  static const name = "change-home-service-request-address-page";

  const ChangeHomeServiceRequestAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      getIt<ChangeHomeServiceRequestAddressCubit>()
        ..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChangeHomeServiceRequestAddressCubit>();
    return BlocListener<
        ChangeHomeServiceRequestAddressCubit,
        ChangeHomeServiceRequestAddressState>(
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
          submitSuccess: (data) {
            BottomSheetMessage.showNotice(
              isDismissible: false,
              context: context,
              data: data,
              buttonColor: ServiceType.homeService.serviceColor,
            );
          },
        );
      },
      child: Scaffold(

        appBar: SimpleAppBar(title: 'ویرایش ادرس درخواست'),
        body: _Body(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<
              ChangeHomeServiceRequestAddressCubit,
              ChangeHomeServiceRequestAddressState>(
            builder: (context, state) {
              final cubit = context.read<ChangeHomeServiceRequestAddressCubit>();
              final isLoading = state.maybeWhen(
                submitLoading: () => true,
                orElse: () => false,
              );
              return state.maybeWhen(
                idle: () => const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                orElse: () =>
                    InkwellButtonWidget(
                      backgroundColor: ServiceType.homeService.serviceColor,
                      title: 'ویرایش آدرس',
                      showLoading: isLoading,
                      onTap: cubit.changeRequestAddress,
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
    return BlocBuilder<
        ChangeHomeServiceRequestAddressCubit,
        ChangeHomeServiceRequestAddressState>(
      builder: (context, state) {
        return state.maybeWhen(
          idle: () => const SizedBox.shrink(),
          loading: () =>
              Center(
                child: CircularProgressIndicator(
                  color: ServiceType.homeService.serviceColor,
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
    final cubit = context.read<ChangeHomeServiceRequestAddressCubit>();

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
                  "${cubit.emdadgarInfo?.agencyName ?? ''} | ${cubit
                      .emdadgarInfo?.mobile ?? ""}",
                ),
                isExpanded: false,
                header: const BodyMediumText(text: "اطلاعات امداد رسان"),
                child: AgentInfoDetailSection(agentInfo: cubit.emdadgarInfo!),
              ),
            ],
            Space.h8,
            AddressLocationSection(
              latitude: cubit.selectedRequest?.latitude ?? 0,
              longitude: cubit.selectedRequest?.longitude ?? 0,
              selectedProvince: cubit.selectedProvince,
              provinceList: cubit.provinceList,
              addressController: cubit.addressController,

              onProvinceSelected: cubit.setSelectedProvince,
              onLocationSelected: cubit.setSelectedLocation,
              serviceType: ServiceType.homeService,
            ),

          ],
        ),
      ),
    );
  }
}