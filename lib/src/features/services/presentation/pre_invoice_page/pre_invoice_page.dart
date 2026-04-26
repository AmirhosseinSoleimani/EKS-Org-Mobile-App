import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/control_info_page/cubit/control_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/resources/value_manager.dart';

class PreInvoicePage extends StatelessWidget {
  static const path = "/pre-invoice-page";
  static const name = "pre-invoice-page";

  const PreInvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ControlInfoCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ControlInfoCubit>();

    return BlocListener<ControlInfoCubit, ControlInfoState>(
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
      child: const Scaffold(
        appBar: SimpleAppBar(title: "اطلاعات کنترلی"),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlInfoCubit, ControlInfoState>(
      builder: (context, state) {
        return state.maybeWhen(
          idle: () => const SizedBox.shrink(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: () => const _LoadedView(),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ControlInfoCubit>();

    return ScrollConfiguration(
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
            ExpandableSection(
              isExpanded: false,
              header: buildRequestStatusSection(cubit),
              child: RequestDetailSection(
                selectedRequest: cubit.selectedRequest,
                showCustomerInfo: true,
              ),
            ),
            Space.h8,

          ],
        ),
      ),
    );
  }

  RequestStatusSection buildRequestStatusSection(ControlInfoCubit cubit) {
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
