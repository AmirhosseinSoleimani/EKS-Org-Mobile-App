import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cartable_cycle_page/cubit/cartable_cycle_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/agent_info_detail_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/request_status_section.dart';
import 'widgets/cartable_cycle_list_view.dart';

class CartableCyclePage extends StatelessWidget {
  static const path = "/cartable-cycle-page";
  static const name = "cartable-cycle-page";

  const CartableCyclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartableCycleCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartableCycleCubit>();

    return BlocListener<CartableCycleCubit, CartableCycleState>(
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
        appBar:  SimpleAppBar(title: "چرخه کارتابل"),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartableCycleCubit, CartableCycleState>(
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
    final cubit = context.read<CartableCycleCubit>();

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
            if (cubit.emdadgarInfo != null) ...[
              ExpandableSection(
                brief: BodySmallText(
                  text:
                  "${cubit.emdadgarInfo?.agencyName ?? ''} | ${cubit.emdadgarInfo?.mobile ?? ""}",
                ),
                isExpanded: false,
                header: const BodyMediumText(text: "اطلاعات امداد رسان"),
                child: AgentInfoDetailSection(
                  agentInfo: cubit.emdadgarInfo!,
                ),
              ),
            ],
            Space.h8,
            CartableCycleListView(
              items: cubit.items,
              icon: const Icon(
                Icons.autorenew_sharp,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  RequestStatusSection _buildRequestStatusSection(
      CartableCycleCubit cubit) {
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
