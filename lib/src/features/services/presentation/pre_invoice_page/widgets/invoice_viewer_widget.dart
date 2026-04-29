import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/pre_invoice_page/cubit/pre_invoice_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/pre_invoice_page/widgets/details_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/pre_invoice_page/widgets/labor_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/pre_invoice_page/widgets/sum_all_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'other_cost_invoice_widget.dart';
import 'part_invoice_widget.dart';

class InvoiceViewerWidget extends StatelessWidget {
  const InvoiceViewerWidget({super.key, required this.type});

  final ServiceType type;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PreInvoiceCubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SumAllInvoiceWidget.homeService(
            entity: cubit.invoiceEntity?.sumAllInvoice),
        Space.h16,
        TextButton(
          onPressed: () => _showDetailsBottomSheet(context, cubit),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BodyMediumText(
                text: 'مشاهده جزئیات پیش‌فاکتور',
                color: Theme.of(context).colorScheme.secondary,
              ),
              Space.w4,
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDetailsBottomSheet(BuildContext context, PreInvoiceCubit cubit) {
    BottomSheetMessage.showCustom(
      context: context,
      isDismissible: true,
      enableDrag: true,
      actionWidget: InkwellButtonWidget(
        backgroundColor: cubit.selectedRequest?.serviceType?.serviceColor,
        title: 'بستن',
        onTap: () => Navigator.pop(context),
      ),
      content: _InvoiceDetailsBottomSheetContent(cubit: cubit),
    );
  }
}

class _InvoiceDetailsBottomSheetContent extends StatelessWidget {
  const _InvoiceDetailsBottomSheetContent({required this.cubit});

  final PreInvoiceCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          DetailsInvoiceWidget.homeService(
            entity: cubit.invoiceEntity?.detailsInvoice,
          ),
          const SizedBox(height: 16),
          if (cubit.invoiceEntity?.laborInvoice?.laborReception?.isNotEmpty ??
              false)
            LaborInvoiceWidget.homeService(
              entity: cubit.invoiceEntity?.laborInvoice,
            ),
          const SizedBox(height: 16),
          if (cubit.invoiceEntity?.partInvoice?.partReception?.isNotEmpty ??
              false)
            PartInvoiceWidget.homeService(
              entity: cubit.invoiceEntity?.partInvoice,
            ),
          const SizedBox(height: 16),
          if (cubit
              .invoiceEntity?.otherCosts?.otherCostReceptions?.isNotEmpty ??
              false)
            OtherCostInvoiceWidget.homeService(
              entity: cubit.invoiceEntity?.otherCosts,
            ),
        ],
      ),
    );
  }
}
