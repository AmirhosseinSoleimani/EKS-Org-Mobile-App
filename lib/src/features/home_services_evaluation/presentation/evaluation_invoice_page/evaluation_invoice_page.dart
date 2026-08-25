import 'dart:ui';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/evaluation_invoice_page/cubit/evaluation_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/evaluation_invoice_page/widgets/invoice_viewer_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/request_status_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EvaluationInvoicePage extends StatelessWidget {
  static const path = "/evaluation-invoice-page";
  static const name = "evaluation-invoice-page";
  final String emdadgarEvaluationId;
  final EvaluationInvoiceFlow flow;

  const EvaluationInvoicePage({
    super.key,
    required this.emdadgarEvaluationId,
    this.flow = EvaluationInvoiceFlow.customer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<EvaluationInvoiceCubit>()..init(emdadgarEvaluationId, flow: flow),
      child: _View(emdadgarEvaluationId, flow),
    );
  }
}

class EvaluationInvoicePageArgs {
  const EvaluationInvoicePageArgs({
    required this.emdadgarEvaluationId,
    this.flow = EvaluationInvoiceFlow.customer,
  });

  final String emdadgarEvaluationId;
  final EvaluationInvoiceFlow flow;
}

class _View extends StatelessWidget {
  final String emdadgarEvaluationId;
  final EvaluationInvoiceFlow flow;

  const _View(this.emdadgarEvaluationId, this.flow);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EvaluationInvoiceCubit>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocListener<EvaluationInvoiceCubit, EvaluationInvoiceState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              BottomSheetMessage.showErrorWithAction(
                context: context,
                data: message,
                onPositive: () {
                  context.pop();
                  cubit.retryLastAction();
                },
              );
            },
            submitSuccess: () {
              BottomSheetMessage.showNotice(
                context: context,
                isDismissible: false,
                buttonColor: cubit.selectedRequest?.serviceType?.serviceColor,
                data: BottomSheetMessageModel(
                  title: '',
                  message: cubit.flow.successMessage,
                ),
                onPositive: () {
                  context.pop();
                  context.pop(true);
                },
              );
            },
            connectionError: () {
              BottomSheetMessage.showCustom(
                context: context,
                content: NoInternetBottomSheet(
                  onRetry: () => cubit.init(emdadgarEvaluationId, flow: flow),
                ),
                actionWidget: const SizedBox.shrink(),
                isDismissible: false,
                enableDrag: false,
              );
            },
          );
        },
        child: Scaffold(
          appBar: SimpleAppBar(title: flow.pageTitle),
          body: _Body(),
          bottomNavigationBar:
              BlocBuilder<EvaluationInvoiceCubit, EvaluationInvoiceState>(
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    submitLoading: () => true,
                    orElse: () => false,
                  );
                  return SubmitCancelButtons(
                    submitButtonColor:
                        context
                            .read<EvaluationInvoiceCubit>()
                            .selectedRequest
                            ?.serviceType
                            ?.serviceColor ??
                        ServiceType.reliefService.serviceColor,
                    onSubmit: context
                        .read<EvaluationInvoiceCubit>()
                        .acceptEvaluation,
                    onCancel: () => Navigator.pop(context),
                    submitTitle: 'تایید نهایی',
                    isLoading: isLoading,
                  );
                },
              ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EvaluationInvoiceCubit>();
    return BlocBuilder<EvaluationInvoiceCubit, EvaluationInvoiceState>(
      builder: (context, state) {
        return state.maybeWhen(
          idle: () => const SizedBox.shrink(),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: cubit.selectedRequest?.serviceType?.serviceColor,
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
    final cubit = context.read<EvaluationInvoiceCubit>();

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.s16),
        child: Column(
          children: [
            RequestStatusSection(request: cubit.selectedRequest),
            Space.h16,
            if (cubit.invoiceEntity == null)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: const Center(child: EmptyListWidget()),
              )
            else
              InvoiceViewerWidget(
                type:
                    cubit.selectedRequest?.serviceType ??
                    ServiceType.homeService,
                detailsTitle: cubit.flow.usesEmdadgarPreInvoice
                    ? 'مشاهده جزئیات پیش صورت وضعیت'
                    : 'مشاهده جزئیات پیش‌فاکتور',
              ),
          ],
        ),
      ),
    );
  }
}
