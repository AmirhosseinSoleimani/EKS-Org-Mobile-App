import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/enums/emdadgar_invoice_stage.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/use_cases/get_initial_emdadgar_invoice_details_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoice_details/cubit/emdadgar_invoice_details_cubit.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoice_details/cubit/emdadgar_invoice_details_state.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoice_details/models/emdadgar_invoice_details_args.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoice_details/widgets/emdadgar_invoice_details_status_row.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/enums/invoice_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/use_case/get_emdadgar_invoice_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/widgets/invoice_viewer_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmdadgarInvoiceDetailsPage extends StatelessWidget {
  const EmdadgarInvoiceDetailsPage({
    super.key,
    required this.args,
  });

  static const path = '/emdadgar-invoice-details';
  static const name = 'emdadgar-invoice-details';

  final EmdadgarInvoiceDetailsArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmdadgarInvoiceDetailsCubit(
        getIt<GetInitialEmdadgarInvoiceDetailsUseCase>(),
        getIt<GetEmdadgarInvoiceUseCase>(),
      )..load(args),
      child: _EmdadgarInvoiceDetailsView(args: args),
    );
  }
}

class _EmdadgarInvoiceDetailsView extends StatelessWidget {
  const _EmdadgarInvoiceDetailsView({required this.args});

  final EmdadgarInvoiceDetailsArgs args;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmdadgarInvoiceDetailsCubit>();

    return BlocListener<EmdadgarInvoiceDetailsCubit, EmdadgarInvoiceDetailsState>(
      listener: (context, state) {
        switch (state.status) {
          case EmdadgarInvoiceDetailsStatus.error:
            final message = state.message;
            if (message == null) return;
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: () {
                context.pop();
                cubit.retry();
              },
            );
            break;
          case EmdadgarInvoiceDetailsStatus.connectionError:
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(onRetry: cubit.retry),
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
        appBar: SimpleAppBar(title: args.pageTitle),
        body: _EmdadgarInvoiceDetailsBody(args: args),
      ),
    );
  }
}

class _EmdadgarInvoiceDetailsBody extends StatelessWidget {
  const _EmdadgarInvoiceDetailsBody({required this.args});

  final EmdadgarInvoiceDetailsArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmdadgarInvoiceDetailsCubit, EmdadgarInvoiceDetailsState>(
      builder: (context, state) {
        if (state.status == EmdadgarInvoiceDetailsStatus.idle) {
          return const SizedBox.shrink();
        }

        if (state.status == EmdadgarInvoiceDetailsStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: args.serviceType?.serviceColor,
            ),
          );
        }

        return _LoadedContent(
          args: args,
          state: state,
        );
      },
    );
  }
}

class _LoadedContent extends StatelessWidget {
  const _LoadedContent({
    required this.args,
    required this.state,
  });

  final EmdadgarInvoiceDetailsArgs args;
  final EmdadgarInvoiceDetailsState state;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: const {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmdadgarInvoiceDetailsStatusRow(args: args),
            Space.h16,
            if (state.invoice == null)
              SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                child: const Center(child: EmptyListWidget()),
              )
            else
              InvoiceViewerWidget(
                type: args.serviceType!,
                invoice: state.invoice,
                invoiceType: args.stage == EmdadgarInvoiceStage.initial
                    ? InvoiceType.preInvoice
                    : InvoiceType.invoice,
              ),
          ],
        ),
      ),
    );
  }
}
