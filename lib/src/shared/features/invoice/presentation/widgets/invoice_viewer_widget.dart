import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/enums/invoice_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/widgets/details_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/widgets/labor_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/widgets/other_cost_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/widgets/part_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/widgets/sum_all_invoice_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class InvoiceViewerWidget extends StatefulWidget {
  const InvoiceViewerWidget({
    super.key,
    required this.type,
    required this.invoice,
    required this.invoiceType,
    this.onOpenDocument,
  });

  final ServiceType type;
  final InvoiceEntity? invoice;
  final InvoiceType invoiceType;
  final Future<void> Function()? onOpenDocument;

  @override
  State<InvoiceViewerWidget> createState() => _InvoiceViewerWidgetState();
}

class _InvoiceViewerWidgetState extends State<InvoiceViewerWidget> {
  bool _isOpeningDocument = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.onOpenDocument != null) ...[
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: IconButton(
              tooltip: 'چاپ فاکتور',
              onPressed: _isOpeningDocument ? null : _openDocument,
              icon: _isOpeningDocument
                  ? SizedBox.square(
                      dimension: AppSize.s20,
                      child: CircularProgressIndicator(
                        strokeWidth: AppSize.s2,
                        color: widget.type.serviceColor,
                      ),
                    )
                  : Icon(
                      Icons.download_rounded,
                      color: widget.type.serviceColor,
                    ),
            ),
          ),
          Space.h8,
        ],
        SumAllInvoiceWidget.homeService(entity: widget.invoice?.sumAllInvoice),
        Space.h16,
        TextButton(
          onPressed: () => _showDetailsBottomSheet(context),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BodyMediumText(
                text: widget.invoiceType.detailsTitle,
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

  Future<void> _openDocument() async {
    final callback = widget.onOpenDocument;
    if (callback == null || _isOpeningDocument) return;

    setState(() => _isOpeningDocument = true);
    try {
      await callback();
    } finally {
      if (mounted) {
        setState(() => _isOpeningDocument = false);
      }
    }
  }

  void _showDetailsBottomSheet(BuildContext context) {
    BottomSheetMessage.showCustom(
      context: context,
      isDismissible: true,
      enableDrag: true,
      actionWidget: InkwellButtonWidget(
        backgroundColor: widget.type.serviceColor,
        title: 'بستن',
        onTap: () => Navigator.pop(context),
      ),
      content: _InvoiceDetailsBottomSheetContent(invoice: widget.invoice),
    );
  }
}

class _InvoiceDetailsBottomSheetContent extends StatelessWidget {
  const _InvoiceDetailsBottomSheetContent({required this.invoice});

  final InvoiceEntity? invoice;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          DetailsInvoiceWidget.homeService(entity: invoice?.detailsInvoice),
          const SizedBox(height: 16),
          if (invoice?.laborInvoice?.laborReception?.isNotEmpty ?? false)
            LaborInvoiceWidget.homeService(entity: invoice?.laborInvoice),
          const SizedBox(height: 16),
          if (invoice?.partInvoice?.partReception?.isNotEmpty ?? false)
            PartInvoiceWidget.homeService(entity: invoice?.partInvoice),
          const SizedBox(height: 16),
          if (invoice?.otherCosts?.otherCostReceptions?.isNotEmpty ?? false)
            OtherCostInvoiceWidget.homeService(entity: invoice?.otherCosts),
        ],
      ),
    );
  }
}
