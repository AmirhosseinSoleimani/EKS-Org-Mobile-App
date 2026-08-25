import 'dart:ui';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/enums/invoice_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/use_case/get_pre_invoice_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/cubit/invoice_details_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/invoice_request_context_loader.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/widgets/invoice_viewer_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InvoicePageArgs {
  const InvoicePageArgs({
    required this.invoiceType,
    this.emdadgarEvaluationId,
  });

  final InvoiceType invoiceType;
  final int? emdadgarEvaluationId;
}

class InvoicePage extends StatelessWidget {
  const InvoicePage({
    super.key,
    required this.requestContextLoader,
    required this.invoiceType,
    this.emdadgarEvaluationId,
  });

  static const path = '/invoice-page';
  static const name = 'invoice-page';

  final InvoiceRequestContextLoader requestContextLoader;
  final InvoiceType invoiceType;
  final int? emdadgarEvaluationId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InvoiceDetailsCubit(
        getIt<GetPreInvoiceUseCase>(),
        requestContextLoader,
        emdadgarEvaluationId: emdadgarEvaluationId,
      )..init(),
      child: _View(invoiceType: invoiceType),
    );
  }
}

class _View extends StatelessWidget {
  const _View({required this.invoiceType});

  final InvoiceType invoiceType;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InvoiceDetailsCubit>();

    return BlocListener<InvoiceDetailsCubit, InvoiceDetailsState>(
      listener: (context, state) {
        switch (state.status) {
          case InvoiceDetailsStatus.error:
            final message = state.message;
            if (message != null) {
              BottomSheetMessage.showErrorWithAction(
                context: context,
                data: message,
                onPositive: () {
                  context.pop();
                  cubit.init();
                },

              );
            }
            break;
          case InvoiceDetailsStatus.connectionError:
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(onRetry: cubit.init),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        appBar: SimpleAppBar(title: invoiceType.title),
        body: _Body(invoiceType: invoiceType),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.invoiceType});

  final InvoiceType invoiceType;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InvoiceDetailsCubit>();

    return BlocBuilder<InvoiceDetailsCubit, InvoiceDetailsState>(
      builder: (context, state) {
        if (state.status == InvoiceDetailsStatus.idle) {
          return const SizedBox.shrink();
        }

        if (state.status == InvoiceDetailsStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: cubit.selectedRequest?.serviceType?.serviceColor,
            ),
          );
        }

        return _LoadedView(invoiceType: invoiceType);
      },
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({required this.invoiceType});

  final InvoiceType invoiceType;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InvoiceDetailsCubit>();
    final request = cubit.selectedRequest;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: const {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.s16),
        child: Column(
          children: [
            Row(
              children: [
                StatusLabel(
                  text: request?.requestStatusTitle ?? '-',
                  color: Colors.purple,
                ),
                Space.w8,
                StatusLabel(
                  text: request?.isGuaranty == true
                      ? 'گارانتی دارد'
                      : 'گارانتی ندارد',
                  color: request?.isGuaranty == true
                      ? Colors.greenAccent
                      : Colors.red,
                ),
                Space.w8,
                StatusLabel(
                  text: request?.isSubscription == true ? 'مشترک' : 'غیر مشترک',
                  color: request?.isSubscription == true
                      ? Colors.greenAccent
                      : Colors.red,
                ),
              ],
            ),
            Space.h16,
            if (cubit.invoiceEntity == null)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: const Center(child: EmptyListWidget()),
              )
            else
              InvoiceViewerWidget(
                invoice: cubit.invoiceEntity,
                type: request?.serviceType ?? ServiceType.homeService,
                invoiceType: invoiceType,
              ),
          ],
        ),
      ),
    );
  }
}
