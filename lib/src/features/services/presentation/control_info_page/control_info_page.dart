import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/control_info_page/cubit/control_info_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/resources/value_manager.dart';
import 'widgets/control_time_line_section.dart';
import 'widgets/request_time_line_section.dart';

class ControlInfoPage extends StatelessWidget {
  static const path = "/control-info-page";
  static const name = "control-info-page";

  const ControlInfoPage({super.key});

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
              onPositive: () {
                context.pop();
                cubit.init();
              },
            );
          },
          connectionError: () {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: () {
                  context.pop();
                  cubit.init();
                },
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
        final cubit = context.read<ControlInfoCubit>();
        return state.maybeWhen(
          idle: () => const SizedBox.shrink(),
          loading: () =>  Center(
            child: CircularProgressIndicator(
                color: cubit.selectedRequest?.serviceType?.serviceColor
            ),
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
              isExpanded: true,
              header: RequestStatusSection(
                request: cubit.selectedRequest,
                showTitle: true,
              ),
              child: RequestDetailSection(
                selectedRequest: cubit.selectedRequest,
                showCustomerInfo: true,
              ),
            ),
            ExpandableSection(
              brief: BodySmallText(
                text:
                    "${cubit.selectedRequest?.emRepresentationName ?? cubit.emdadgarInfo?.agencyName ?? ''} | ${cubit.selectedRequest?.emMobileNumber1 ?? cubit.emdadgarInfo?.mobile ?? ''}",
              ),
              isExpanded: false,
              header: BodyMediumText(
                text: cubit.selectedRequest?.isHomeService == true
                    ? 'اطلاعات خدمت رسان'
                    : 'اطلاعات امدادرسان',
              ),
              child: AgentInfoDetailSection(
                agentInfo: cubit.emdadgarInfo,
                selectedRequest: cubit.selectedRequest,
              ),
            ),
            Space.h8,
            ExpandableSection(
              isExpanded: false,
              header: const BodyMediumText(text: "درخواست"),
              child: RequestTimelineSection(
                data: cubit.controlInfoEntity?.serviceRequest,
                activeColor: cubit.selectedRequest!.serviceType!.serviceColor,
              ),
            ),
            Space.h8,
            ExpandableSection(
              isExpanded: false,
              header: const BodyMediumText(text: "پیگیری کننده"),
              child: ControlTimelineSection(
                data: cubit.controlInfoEntity?.systemUser,
                activeColor: const Color(0xFF60C451),
              ),
            ),
            Space.h8,
            ExpandableSection(
              isExpanded: false,
              header: const BodyMediumText(text: 'امدادرسان'),
              child: ControlTimelineSection(
                data: cubit.controlInfoEntity?.emdadgar,
                activeColor: const Color(0xFFE4A321),
              ),
            ),
            Space.h8,
            ExpandableSection(
              isExpanded: false,
              header: const BodyMediumText(text: "سیستم"),
              child: ControlTimelineSection(
                data: cubit.controlInfoEntity?.system,
                activeColor: const Color(0xFF878787),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
