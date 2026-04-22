import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/agent_info_detail_section.dart';
import 'widgets/car_info_detail_section.dart';
import 'widgets/customer_info_detail_section.dart';
import 'widgets/expandable_section.dart';
import 'widgets/request_followup_history_section.dart';
import 'widgets/request_location_detail_section.dart';

class RequestDetailPage extends StatelessWidget {
  const RequestDetailPage({super.key, this.id});
  final int? id;
  static const path = "/request-detail-page";
  static const name = "request-detail-page";

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<RequestDetailCubit>();
    return BlocProvider(
      create: (_) => cubit..init(),
      child: BlocListener<RequestDetailCubit, RequestDetailState>(
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
                content: NoInternetBottomSheet(
                  onRetry: cubit.init,
                ),
                actionWidget: const SizedBox.shrink(),
                isDismissible: false,
                enableDrag: false,
              );
            },
          );
        },
        child: Scaffold(
            appBar: const MainAppBar(title: "جزئیات درخواست"),
            body: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSize.s16),
                child: Column(
                  children: [
                    BlocBuilder<RequestDetailCubit, RequestDetailState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                            idle: () => const SizedBox.shrink(),
                            loading: () => const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: AppSize.s40),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            loaded: () => Column(
                                  children: [
                                    ExpandableSection(
                                      isExpanded: false,
                                      header: RequestStatusSection(
                                        trackCode: cubit
                                                .selectedRequest?.trackCode
                                                .toString() ??
                                            '',
                                        requestDateJalali: cubit.selectedRequest
                                                ?.requestDateJalali
                                                .toString() ??
                                            '',
                                        requestTime: cubit
                                                .selectedRequest?.requestTime
                                                .toString() ??
                                            '',
                                        requestStatusTitle: cubit
                                            .selectedRequest
                                            ?.requestStatusTitle,
                                        isGuaranty:
                                            cubit.selectedRequest?.isGuaranty ??
                                                false,
                                        isSubscription: cubit.selectedRequest
                                                ?.isSubscription ??
                                            false,
                                      ),
                                      child: RequestDetailSection(selectedRequest: cubit.selectedRequest),
                                    ),
                                    ExpandableSection(
                                      isExpanded: false,
                                      brief: BodySmallText(
                                        text:
                                            "${cubit.selectedRequest?.firstName ?? ''} ${cubit.selectedRequest?.lastName ?? ''} "
                                            "| ${cubit.selectedRequest?.customerMobileNumber ?? "-"}",
                                      ),
                                      header: const BodyMediumText(
                                          text: "اطلاعات مشتری"),
                                      child: CustomerInfoDetailSection(
                                          cubit: cubit),
                                    ),
                                    if (cubit.emdadgarInfo != null) ...[
                                     ExpandableSection(
                                       isExpanded: false,
                                       header: const BodyMediumText(
                                           text: "اطلاعات امداد رسان"),
                                       child: AgentInfoDetailSection(
                                           agentInfo: cubit.emdadgarInfo!),
                                     ),
                                   ],
                                    ExpandableSection(
                                      isExpanded: false,
                                      header: const BodyMediumText(
                                          text: "اطلاعات خودرو"),
                                      child: CarInfoDetailSection(cubit: cubit),
                                    ),
                                    ExpandableSection(
                                      isExpanded: false,
                                      header: const BodyMediumText(
                                          text: "تاریخچه پیگیری"),
                                      child: RequestFollowupHistorySection(
                                        items: cubit.followups,
                                      ),
                                    ),
                                     ExpandableSection(
                                      isExpanded: true,
                                      header:
                                          const BodyMediumText(text: "موقعیت درخواست روی نقشه"),
                                      child:  RequestLocationDetailSection(
                                        latitude:
                                            cubit.selectedRequest?.latitude,
                                        longitude:
                                            cubit.selectedRequest?.longitude,
                                        city: cubit.selectedRequest?.cityName,
                                        province:
                                            cubit.selectedRequest?.provinceName,
                                        address:
                                            cubit.selectedRequest?.aidAddress,
                                      ),
                                    ),
                                  ],
                                ),
                            orElse: SizedBox.shrink);
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
