
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/labor_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/amount_row/amount_row.dart';
import 'package:flutter/material.dart';

class LaborInvoiceWidget extends StatelessWidget {
  final LaborInvoiceEntity? entity;
  final ServiceType _type;

  const LaborInvoiceWidget._(this._type, {super.key, this.entity});

  const LaborInvoiceWidget.aidService({Key? key, LaborInvoiceEntity? entity,}) :
        this._(ServiceType.reliefService, entity: entity, key: key);

  const LaborInvoiceWidget.homeService({Key? key, LaborInvoiceEntity? entity,
  }) : this._(ServiceType.homeService, entity: entity, key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = switch (_type) {
      ServiceType.reliefService => Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ServiceType.homeService => Theme.of(context).colorScheme.secondary.withOpacity(0.1),
    };
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s12))),
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
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p16, horizontal: AppPadding.p8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'جزئیات اجرت‌ها',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: AppSize.s14
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'هزینه',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: AppSize.s14
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'به عهده',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: AppSize.s14
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Space.h8,
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entity?.laborReception?.length ?? 0,
              separatorBuilder: (_, index) => Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Divider(
                  thickness: AppSize.s1,
                  height: AppSize.s1,
                  color: color,
                ),
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${entity?.laborReception?[index].laborDescription}'.splitPriceByComma(),
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontSize: AppSize.s12
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AmountRow(
                          amount: entity?.laborReception?[index].laborTotalPriceRial,
                          showRial: false,
                          valueStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: AppSize.s12,
                              ),
                          valueAlignment: Alignment.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${entity?.laborReception?[index].nahveMohasebeDescription}'
                                .splitPriceByComma(),
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: AppSize.s12
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Divider(
              thickness: AppSize.s1,
              height: AppSize.s1,
              color: color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'جمع کل'.splitPriceByComma(),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: AppSize.s14
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AmountRow(
                    amount: entity?.total,
                    valueStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: AppSize.s14,
                          fontWeight: FontWeight.w600,
                        ),
                    valueAlignment: Alignment.center,
                  ),
                )
              ],
            ),
          ),
          Space.h8
        ],
      ),
    );
  }
}
