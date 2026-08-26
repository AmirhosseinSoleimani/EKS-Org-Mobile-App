import 'package:eks_sana_plus_org/src/shared/utils/invoice_presentation_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/amount_row/amount_row.dart';
import 'package:flutter/material.dart';

class InvoicePreviewSheet extends StatelessWidget {
  const InvoicePreviewSheet({
    super.key,
    required this.invoice,
  });

  final InvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    final sum = invoice.sumAllInvoice;

    return SafeArea(
      child: Column(
        children: [
          FullScreenBottomSheetAppBar(
            title: invoice.invoiceTitle?.trim().isNotEmpty == true
                ? invoice.invoiceTitle!.trim()
                : 'پیش فاکتور مشتری',
            onClose: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppPadding.p16),
              children: [
                _Section(
                  title: 'خلاصه هزینه‌ها',
                  children: [
                    AmountRow(
                      label: 'پرداخت مشتری',
                      amount: sum?.customerPaymentPrice,
                      isEmphasized: true,
                    ),
                    AmountRow(
                      label: 'جمع اقلام مشتری',
                      amount: sum?.totalAllItemsCustomer,
                    ),
                    AmountRow(
                      label: 'جمع اقلام شرکت',
                      amount: sum?.totalAllItemsCompany,
                    ),
                    AmountRow(
                      label: 'اجرت مشتری',
                      amount: sum?.laborCustomerTotal,
                    ),
                    AmountRow(
                      label: 'قطعات مشتری',
                      amount: sum?.partCustomerTotal,
                    ),
                    AmountRow(
                      label: sum?.taxTotalCustomerText ?? 'مالیات مشتری',
                      amount: sum?.taxTotalCustomer,
                    ),
                  ],
                ),
                if (invoice.detailsInvoice?.invoiceItems?.isNotEmpty == true) ...[
                  Space.h16,
                  _Section(
                    title: invoice.detailsInvoice?.title ?? 'جزئیات هزینه‌ها',
                    children: invoice.detailsInvoice!.invoiceItems!
                        .map(
                          (item) => AmountRow(
                            label: InvoicePresentationFormatter.display(
                              item.aidItemTypeStr,
                            ),
                            amount: item.customerPrice ?? item.companyPrice,
                          ),
                        )
                        .toList(),
                  ),
                ],
                if (invoice.laborInvoice?.laborReception?.isNotEmpty == true) ...[
                  Space.h16,
                  _Section(
                    title: invoice.laborInvoice?.title ?? 'اجرت‌ها',
                    children: invoice.laborInvoice!.laborReception!
                        .map(
                          (item) => AmountRow(
                            label: InvoicePresentationFormatter.display(
                              item.laborDescription,
                            ),
                            amount: item.price,
                          ),
                        )
                        .toList(),
                  ),
                ],
                if (invoice.partInvoice?.partReception?.isNotEmpty == true) ...[
                  Space.h16,
                  _Section(
                    title: invoice.partInvoice?.title ?? 'قطعات',
                    children: invoice.partInvoice!.partReception!
                        .map(
                          (item) => AmountRow(
                            label: InvoicePresentationFormatter.display(
                              item.commodityDescription,
                            ),
                            amount: item.partPriceRial,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p14),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Space.h12,
          ...children,
        ],
      ),
    );
  }
}
