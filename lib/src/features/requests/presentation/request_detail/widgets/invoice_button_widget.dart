import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/enums/invoice_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/service_invoice_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InvoiceButtonWidget extends StatelessWidget {
  final InvoiceType invoiceType;
  final dynamic selectedRequest;

  const InvoiceButtonWidget({
    super.key,
    required this.invoiceType,
    required this.selectedRequest,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHomeService =
        selectedRequest.type == RequestType.homeService.value;
    final buttonColor = isHomeService ? colorScheme.secondary : colorScheme.primary;
    return Center(
      child: InkwellButtonWidget(
        width: AppSize.s200,
        onTap: () {
          final invoiceRequestParam = ServiceInvoiceRequestEntity(
            serviceType: selectedRequest.type,
            serviceRequestId: selectedRequest.id,
            type: invoiceType,
          );
       /*   if(invoiceType == InvoiceType.invoice) {
            context.pushNamed(
              InvoiceHistoryPage.name,
              extra: invoiceRequestParam,
            );
          }else {
            context.pushNamed(
              PreInvoicePage.name,
              extra: invoiceRequestParam,
            );
          }*/
        },
        backgroundColor: colorScheme.onPrimary,
        borderColor: buttonColor,
        titleColor: buttonColor,
        title: invoiceType.title,
        prefixIcon: Icon(
          IconManager.receipt,
          size: AppSize.s24,
          color: isHomeService
              ? colorScheme.secondary
              : colorScheme.primary,
        ),
      ),
    );
  }
}
