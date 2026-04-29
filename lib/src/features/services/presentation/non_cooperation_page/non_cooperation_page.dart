import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/non_cooperation_page/cubit/non_cooperation_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/non_cooperation_page/widgets/non_cooperation_list_view.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_status_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NonCooperationPage extends StatelessWidget {
  static const path = "/non-cooperation-page";
  static const name = "non-cooperation-page";

  const NonCooperationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NonCooperationCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

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
          loadMoreError: (message) =>
              SnakeBarWidget.showError(context: context, message: message),
        );
      },
      child: const Scaffold(
        appBar: SimpleAppBar(title: "لیست عدم همکاری"),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NonCooperationCubit, NonCooperationState>(
      builder: (context, state) {
        final cubit = context.read<NonCooperationCubit>();
        return state.maybeWhen(
          idle: () => const SizedBox.shrink(),
          loading: () =>  Center(
            child: CircularProgressIndicator(
                color: cubit.selectedBaseRequest?.serviceType?.serviceColor
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
    final cubit = context.read<NonCooperationCubit>();

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
              header: _buildRequestStatusSection(cubit),
              child: RequestDetailSection(
                selectedRequest: cubit.selectedBaseRequest,
                showCustomerInfo: true,
              ),
            ),
            Space.h8,
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
      ),
    );
  }

  RequestStatusSection _buildRequestStatusSection(NonCooperationCubit cubit) {
    return RequestStatusSection(
      trackCode: cubit.selectedBaseRequest?.trackCode.toString() ?? '-',
      requestDateJalali:
          cubit.selectedBaseRequest?.requestDateJalali.toString() ?? '-',
      requestTime: cubit.selectedBaseRequest?.requestTime.toString() ?? '-',
      requestStatusTitle: cubit.selectedBaseRequest?.requestStatusTitle,
      isGuaranty: cubit.selectedBaseRequest?.isGuaranty ?? false,
      isSubscription: cubit.selectedBaseRequest?.isSubscription ?? false,
    );
  }
}
