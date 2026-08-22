import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_status_history_section.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/request_widgets/agent_info_detail_section.dart';
import '../../../../shared/widgets/request_widgets/expandable_section.dart';
import 'widgets/car_info_detail_section.dart';
import 'widgets/customer_info_detail_section.dart';
import 'widgets/request_followup_history_section.dart';
import 'widgets/request_location_detail_section.dart';

class RequestDetailRouteArgs {
  const RequestDetailRouteArgs({
    required this.requestId,
    required this.serviceType,
  });

  final int requestId;
  final ServiceType serviceType;
}

class RequestDetailPage extends StatelessWidget {
  const RequestDetailPage({
    super.key,
    this.id,
    this.serviceType,
  });

  final int? id;
  final ServiceType? serviceType;

  static const path = '/request-detail-page';
  static const name = 'request-detail-page';

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<RequestDetailCubit>();

    Future<void> retry() => cubit.init(
          requestId: id,
          serviceType: serviceType,
        );

    return BlocProvider(
      create: (_) => cubit
        ..init(
          requestId: id,
          serviceType: serviceType,
        ),
      child: BlocListener<RequestDetailCubit, RequestDetailState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              BottomSheetMessage.showErrorWithAction(
                context: context,
                data: message,
                onPositive: () {
                  context.pop();
                  retry();
                },
              );
            },
            connectionError: () {
              BottomSheetMessage.showCustom(
                context: context,
                content: NoInternetBottomSheet(onRetry: retry),
                actionWidget: const SizedBox.shrink(),
                isDismissible: false,
                enableDrag: false,
              );
            },
          );
        },
        child: Scaffold(
          appBar: const SimpleAppBar(title: 'جزئیات درخواست'),
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSize.s16),
              child: BlocBuilder<RequestDetailCubit, RequestDetailState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    idle: () => const SizedBox.shrink(),
                    loading: () => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: cubit.selectedRequest?.serviceType?.serviceColor ??
                              serviceType?.serviceColor,
                        ),
                      ),
                    ),
                    orElse: () => _LoadedContent(cubit: cubit),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadedContent extends StatelessWidget {
  const _LoadedContent({required this.cubit});

  final RequestDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    final request = cubit.selectedRequest;
    final customerMobile =
        (request?.customerMobileNumber?.trim().isNotEmpty == true
                ? request?.customerMobileNumber
                : request?.callMobileNumber)
            ?.toLocalMobile() ??
        '-';
    final hasAgent = cubit.emdadgarInfo != null || (request?.planningId ?? 0) > 0;
    final agentSectionTitle = request?.isHomeService == true
        ? 'اطلاعات خدمت رسان'
        : 'اطلاعات امدادرسان';

    return Column(
      children: [
        ExpandableSection(
          isExpanded: false,
          header: RequestStatusSection(request: request),
          child: RequestDetailSection(selectedRequest: request),
        ),
        ExpandableSection(
          isExpanded: false,
          brief: BodySmallText(
            text:
                '${request?.firstName ?? ''} ${request?.lastName ?? ''} | $customerMobile',
          ),
          header: const BodyMediumText(text: 'اطلاعات مشتری'),
          child: CustomerInfoDetailSection(cubit: cubit),
        ),
        if (hasAgent)
          ExpandableSection(
            isExpanded: false,
            header: BodyMediumText(text: agentSectionTitle),
            child: AgentInfoDetailSection(
              agentInfo: cubit.emdadgarInfo,
              selectedRequest: request,
            ),
          ),
        ExpandableSection(
          isExpanded: false,
          header: const BodyMediumText(text: 'اطلاعات خودرو'),
          child: CarInfoDetailSection(cubit: cubit),
        ),
        ExpandableSection(
          isExpanded: false,
          header: const BodyMediumText(text: 'تاریخچه پیگیری'),
          child: RequestFollowupHistorySection(items: cubit.followups),
        ),
        ExpandableSection(
          isExpanded: true,
          header: const BodyMediumText(text: 'موقعیت درخواست روی نقشه'),
          child: RequestLocationDetailSection(
            latitude: request?.latitude,
            longitude: request?.longitude,
            city: request?.cityName,
            province: request?.provinceName,
            address: request?.aidAddress,
            serviceType: request?.serviceType ?? ServiceType.reliefService,
          ),
        ),
        ExpandableSection(
          isExpanded: false,
          header: const Text('تاریخچه وضعیت درخواست'),
          child: RequestStatusHistorySection(
            items: cubit.requestStatusHistory,
          ),
        ),
      ],
    );
  }
}
