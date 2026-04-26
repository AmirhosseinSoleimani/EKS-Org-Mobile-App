import 'dart:ui';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/pre_invoice_page/cubit/pre_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/expandable_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/request_detail_section.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/resources/value_manager.dart';
import 'widgets/invoice_viewer_widget.dart';

class PreInvoicePage extends StatelessWidget {
  static const path = "/pre-invoice-page";
  static const name = "pre-invoice-page";

  const PreInvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PreInvoiceCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PreInvoiceCubit>();

    return BlocListener<PreInvoiceCubit, PreInvoiceState>(
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
        appBar: SimpleAppBar(title: "پیش فاکتور"),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreInvoiceCubit, PreInvoiceState>(
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
    final cubit = context.read<PreInvoiceCubit>();

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
            buildRequestStatusRow(cubit),
            Space.h16,
            InvoiceViewerWidget(
              type:
                  cubit.selectedRequest?.serviceType ?? ServiceType.homeService,
            ),
          ],
        ),
      ),
    );
  }

  Row buildRequestStatusRow(PreInvoiceCubit cubit) {
    return Row(
      children: [
        StatusLabel(
          text: cubit.selectedRequest?.requestStatusTitle ?? '-',
          color: Colors.purple,
        ),
        Space.w8,
        StatusLabel(
          text: cubit.isGuaranty ? "گارانتی دارد" : "گارانتی ندارد",
          color: cubit.isGuaranty ? Colors.greenAccent : Colors.red,
        ),
        Space.w8,
        StatusLabel(
          text: cubit.isSubscription ? "مشترک" : "غیر مشترک",
          color: cubit.isSubscription ? Colors.greenAccent : Colors.red,
        ),
      ],
    );
  }
}
