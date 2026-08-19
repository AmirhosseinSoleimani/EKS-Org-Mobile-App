import 'dart:ui';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/emdadgar_invoice_page/cubit/emdadgar_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/emdadgar_invoice_page/widgets/invoice_viewer_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmdadgarInvoicePage extends StatelessWidget {
  static const path = "/pre-agent-invoice-page";
  static const name = "pre-agent-invoice-page";

  const EmdadgarInvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EmdadgarInvoiceCubit>()..init(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmdadgarInvoiceCubit>();

    return BlocListener<EmdadgarInvoiceCubit, EmdadgarInvoiceState>(
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
        appBar: SimpleAppBar(title: "صورت وضعیت نماینده"),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmdadgarInvoiceCubit, EmdadgarInvoiceState>(
      builder: (context, state) {
        final cubit = context.read<EmdadgarInvoiceCubit>();
        return state.maybeWhen(
          idle: () => const SizedBox.shrink(),
          loading: () => Center(
            child: CircularProgressIndicator(
                color: cubit.selectedRequest?.serviceType?.serviceColor),
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
    final cubit = context.read<EmdadgarInvoiceCubit>();

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
            if (cubit.invoiceEntity == null)
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: const Center(child: EmptyListWidget()))
            else
              EmdadgarInvoiceViewerWidget(
                type: cubit.selectedRequest?.serviceType ??
                    ServiceType.homeService,
              ),
          ],
        ),
      ),
    );
  }

  Row buildRequestStatusRow(EmdadgarInvoiceCubit cubit) {
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
