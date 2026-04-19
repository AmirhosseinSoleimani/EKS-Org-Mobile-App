import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/non_cooperation/cubit/non_cooperation_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/non_cooperation_list_view.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/request_status_section.dart';

class NonCooperationPage extends StatelessWidget {
  static const path = "/non_cooperation-page";
  static const name = "non_cooperation-page";

  const NonCooperationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NonCooperationCubit>()..init(),
      child: const _SelectedServicesView(),
    );
  }
}

class _SelectedServicesView extends StatelessWidget {
  const _SelectedServicesView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NonCooperationCubit>();
    return BlocListener<NonCooperationCubit, NonCooperationState>(
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
          appBar: const MainAppBar(title: "لیست عدم همکاری"),
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
                  BlocBuilder<NonCooperationCubit, NonCooperationState>(
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
                                    header: buildRequestStatusSection(cubit),
                                    child: RequestDetailSection(
                                      selectedRequest: cubit.selectedRequest,
                                      showCustomerInfo: true,
                                    ),
                                  ),
                                  Space.h16,
                                  NonCooperationListView(
                                    items: cubit.items,
                                    icon: const Icon(
                                      Icons.do_not_disturb_on,
                                      color: Colors.grey,
                                      size: 20,
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
    );
  }

  RequestStatusSection buildRequestStatusSection(NonCooperationCubit cubit) {
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
