import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/cubit/request_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/agent_info_detail_section.dart';
import 'widgets/car_info_detail_section.dart';
import 'widgets/customer_info_detail_section.dart';
import 'widgets/expandable_section.dart';
import 'widgets/request_followup_history_section.dart';
import 'widgets/request_location_detail_section.dart';
import 'widgets/status_label.dart';

class RequestDetailPage extends StatelessWidget {
  const RequestDetailPage({super.key});

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
                                      header: _buildStatusSection(cubit),
                                      child: RequestDetailSection(cubit: cubit),
                                    ),
                                    ExpandableSection(
                                      isExpanded: false,
                                      brief: BodySmallText(
                                        text:
                                            "${cubit.selectedRequest.firstName} ${cubit.selectedRequest.lastName} | ${cubit.selectedRequest.customerMobileNumber ?? "-"}",
                                      ),
                                      header: const BodyMediumText(
                                          text: "اطلاعات مشتری"),
                                      child: CustomerInfoDetailSection(
                                          cubit: cubit),
                                    ),
                                    ExpandableSection(
                                      isExpanded: false,
                                      header: const BodyMediumText(
                                          text: "اطلاعات امداد رسان"),
                                      child: AgentInfoDetailSection(
                                          selectedRequest:
                                              cubit.selectedRequest),
                                    ),
                                    ExpandableSection(
                                      isExpanded: false,
                                      header: const BodyMediumText(
                                          text: "اطلاعات خودرو"),
                                      child: CarInfoDetailSection(cubit: cubit),
                                    ),
                                    const ExpandableSection(
                                      isExpanded: false,
                                      header: const BodyMediumText(
                                          text: "تاریخچه پیگیری"),
                                      child: RequestFollowupHistorySection(
                                        items: []/*cubit.*/,
                                      ),
                                    ),
                                     ExpandableSection(
                                      isExpanded: true,
                                      header:
                                          const BodyMediumText(text: "موقعیت درخواست روی نقشه"),
                                      child:  RequestLocationDetailSection(
                                        latitude:
                                        cubit.selectedRequest.latitude,
                                        longitude:
                                        cubit.selectedRequest.longitude,
                                        city: cubit.selectedRequest.cityName,
                                        province: cubit
                                            .selectedRequest.provinceName,
                                        address:
                                        cubit.selectedRequest.aidAddress,
                                      ),
                                    ),
                                    const ExpandableSection(
                                      isExpanded: false,
                                      header:
                                          const Text("تاریخچه وضعیت درخواست"),
                                      child: SizedBox(
                                        height: 200,
                                        child: SizedBox(),
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

  Column _buildStatusSection(RequestDetailCubit cubit) {
    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BodySmallText(
                                          text:
                                              "${cubit.selectedRequest.trackCode} | ${cubit.selectedRequest.requestDateJalali} - ${cubit.selectedRequest.requestTime}",
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            StatusLabel(
                                              text: cubit.selectedRequest
                                                  .requestStatusTitle ?? '-',
                                              color: Colors.purple,
                                            ),
                                            Space.w8,
                                            StatusLabel(
                                              text: cubit.selectedRequest
                                                      .isGuaranty??false
                                                  ? "گارانتی دارد"
                                                  : "گارانتی ندارد",
                                              color: cubit.selectedRequest
                                                      .isGuaranty??false
                                                  ? Colors.greenAccent
                                                  : Colors.red,
                                            ),
                                            Space.w8,
                                            StatusLabel(
                                              text: cubit.selectedRequest
                                                      .isSubscription??false
                                                  ? "مشترک"
                                                  : "غیر مشترک",
                                              color: cubit.selectedRequest
                                                      .isSubscription??false
                                                  ? Colors.greenAccent
                                                  : Colors.red,
                                            )
                                          ],
                                        ),
                                      ],
                                    );
  }
}
