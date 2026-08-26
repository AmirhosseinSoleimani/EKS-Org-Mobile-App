import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/sum_all_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/amount_row/amount_row.dart';
import 'package:flutter/material.dart';

import 'invoice_row.dart';

class SumAllInvoiceWidget extends StatelessWidget {
  final SumAllInvoiceEntity? entity;
  final ServiceType _type;

  const SumAllInvoiceWidget._(this._type, {super.key, this.entity});

  const SumAllInvoiceWidget.aidService({
    Key? key,
    SumAllInvoiceEntity? entity,
  }) : this._(ServiceType.reliefService, entity: entity, key: key);

  const SumAllInvoiceWidget.homeService({
    Key? key,
    SumAllInvoiceEntity? entity,
  }) : this._(ServiceType.homeService, entity: entity, key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = switch (_type) {
      ServiceType.reliefService =>
        Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ServiceType.homeService =>
        Theme.of(context).colorScheme.secondary.withOpacity(0.1),
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSize.s12),
                topRight: Radius.circular(AppSize.s12),
              ),
              border: Border(
                bottom: BorderSide(
                  width: AppSize.s1,
                  color: color,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p16, horizontal: AppPadding.p8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'هزینه ها',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: AppSize.s14),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'مشتری',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: AppSize.s14),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'شرکت/گارانتی',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: AppSize.s14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Space.h8,
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              children: [
                ..._buildRows(context: context, color: color),
                Divider(
                  thickness: AppSize.s1,
                  height: AppSize.s1,
                  color: color,
                ),
                Space.h16,
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'جمع کل',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: AppSize.s14),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AmountRow(
                        amount: entity?.totalAllItemsCustomer,
                        showRial: (entity?.totalAllItemsCustomer ?? 0) > 0,
                        valueStyle: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                fontSize: AppSize.s10,
                                fontWeight: FontWeight.w600),
                        valueAlignment: Alignment.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AmountRow(
                        amount: entity?.totalAllItemsCompany,
                        showRial: (entity?.totalAllItemsCompany ?? 0) > 0,
                        valueStyle: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                              fontSize: AppSize.s10,
                              fontWeight: FontWeight.w600,
                            ),
                        valueAlignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
                Space.h8,
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRows({required BuildContext context, Color? color}) {
    final rows = [
      InvoiceRow(
        label: (_type == ServiceType.homeService)
            ? 'جمع کل هزینه های خدماتی'
            : 'جمع کل هزینه های امدادی',
        customerValue:
            entity?.detailEmdadInvoiceTotalCustomer ?? 0,
        companyValue: entity?.detailEmdadInvoiceTotalCompany ?? 0,
      ),
      InvoiceRow(
        label: 'جمع کل اجرت‌ها',
        customerValue: entity?.laborCustomerTotal ?? 0,
        companyValue: entity?.laborCompanyTotal ?? 0,
      ),
      InvoiceRow(
        label: 'جمع کل هزینه قطعات',
        customerValue: entity?.partCustomerTotal ?? 0,
        companyValue: entity?.partCompanyTotal ?? 0,
      ),
      InvoiceRow(
        label: 'جمع کل سایر هزینه ها',
        customerValue: entity?.totalOtherCostCustomerPrice ?? 0,
        companyValue: entity?.totalOtherCostCompanyPrice ?? 0,
      ),
      InvoiceRow(
        label: entity?.taxTotalCustomerText ?? '',
        customerValue: entity?.taxTotalCustomer ?? 0,
        companyValue: entity?.taxTotalCompany ?? 0,
      ),
      InvoiceRow(
        label: 'جمع تخفیف',
        customerValue: (entity?.discountTotalPrice != null &&
                (entity?.discountTotalPrice ?? -1) > 0)
            ? (entity?.totalReusableCustomerPrice ?? 0) -
                (entity?.discountTotalPrice ?? 0)
            : entity?.totalReusableCustomerPrice ?? 0,
        companyValue: entity?.totalReusableCompanyPrice ?? 0,
      ),
    ];

    return rows.asMap().entries.map((entry) {
      final i = entry.key;
      final row = entry.value;

      return Column(
        children: [
          if (i > 0) ...[
            Divider(
              thickness: AppSize.s1,
              height: AppSize.s1,
              color: color,
            ),
            Space.h12,
          ],
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  row.label,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: AppSize.s12,
                      ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AmountRow(
                  amount: row.customerValue,
                  showRial: false,
                  valueStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: AppSize.s12,
                      ),
                  valueAlignment: Alignment.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: AmountRow(
                  amount: row.companyValue,
                  showRial: false,
                  valueStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: AppSize.s12,
                      ),
                  valueAlignment: Alignment.center,
                ),
              ),
            ],
          ),
          Space.h12,
        ],
      );
    }).toList();
  }
}
