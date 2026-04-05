/*
import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/subscription_history/invoice_widget/invoice_row.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RequestHistoryInvoiceShimmerWidget extends StatelessWidget {
  final ServiceType _serviceType;

  const RequestHistoryInvoiceShimmerWidget._(this._serviceType, {super.key});

  factory RequestHistoryInvoiceShimmerWidget.aidService({Key? key}) {
    return RequestHistoryInvoiceShimmerWidget._(ServiceType.aidService, key: key);
  }

  factory RequestHistoryInvoiceShimmerWidget.homeService({Key? key}) {
    return RequestHistoryInvoiceShimmerWidget._(ServiceType.homeService, key: key);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p16, horizontal: AppPadding.p12),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(
                width: AppSize.s1,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            child: Shimmer.fromColors(
              period: DurationConstant.d1000,
              baseColor: colorScheme.onSecondary,
              highlightColor: colorScheme.surface,
              child: Column(
                children: [
                  _SumAllInvoiceShimmerWidget(serviceType: _serviceType,),
                ],
              ),
            ),
          ),
          Space.h16,
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(
                width: AppSize.s1,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            child: Shimmer.fromColors(
              period: DurationConstant.d1000,
              baseColor: colorScheme.onSecondary,
              highlightColor: colorScheme.surface,
              child: Column(
                children: [
                  _DetailsInvoiceShimmerWidget(serviceType: _serviceType,),
                ],
              ),
            ),
          ),
          Space.h16,
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(
                width: AppSize.s1,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            child: Shimmer.fromColors(
              period: DurationConstant.d1000,
              baseColor: colorScheme.onSecondary,
              highlightColor: colorScheme.surface,
              child: Column(
                children: [
                  _LaborInvoiceShimmerWidget(serviceType: _serviceType,),
                ],
              ),
            ),
          ),
          Space.h16,
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(
                width: AppSize.s1,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            child: Shimmer.fromColors(
              period: DurationConstant.d1000,
              baseColor: colorScheme.onSecondary,
              highlightColor: colorScheme.surface,
              child: Column(
                children: [
                  _PartInvoiceShimmerWidget(serviceType: _serviceType,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SumAllInvoiceShimmerWidget extends StatelessWidget {
  final ServiceType serviceType;
  const _SumAllInvoiceShimmerWidget({required this.serviceType});
  @override
  Widget build(BuildContext context) {
    final Color headerColor = switch (serviceType) {
      ServiceType.aidService => Theme.of(context).colorScheme.primary.withOpacity(0.2),
      ServiceType.homeService => Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
    };
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSize.s12),
              topRight: Radius.circular(AppSize.s12),
            ),
            border: Border(
              bottom: BorderSide(
                width: AppSize.s1,
                color: Theme.of(context).colorScheme.onSecondary,
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
                    'هزینه ها',
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
                      'مشتری',
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
                      'شرکت/گارانتی',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: AppSize.s14
                      ),
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
              ..._buildRows(context: context),
              Divider(
                thickness: AppSize.s1,
                height: AppSize.s1,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              Space.h16,
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'جمع کل',
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
                        'در حال محاسبه',
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
                        'در حال محاسبه',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: AppSize.s14
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Space.h8,
            ],
          ),
        ),
      ],
    );
  }
  List<Widget> _buildRows({required BuildContext context}) {
    final rows = [
      InvoiceRow(
        label: (serviceType == ServiceType.homeService) ? 'جمع کل هزینه های خدماتی' : 'جمع کل هزینه های امدادی' ,
        customerValue: 'در حال محاسبه',
        companyValue: 'در حال محاسبه',
      ),
      const InvoiceRow(
        label: 'جمع کل اجرت‌ها',
        customerValue: 'در حال محاسبه',
        companyValue: 'در حال محاسبه',
      ),
      const InvoiceRow(
        label: 'جمع کل هزینه قطعات',
        customerValue: 'در حال محاسبه',
        companyValue: 'در حال محاسبه',
      ),
      const InvoiceRow(
        label: 'جمع کل سایر هزینه ها',
        customerValue: 'در حال محاسبه',
        companyValue: 'در حال محاسبه',
      ),
      const InvoiceRow(
        label: 'مالیات بر ارزش افزوده',
        customerValue: 'در حال محاسبه',
        companyValue: 'در حال محاسبه',
      ),
    ];

    return rows.map((row) => Padding(padding: const EdgeInsets.only(bottom: AppPadding.p12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              row.label,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: AppSize.s12
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'در حال محاسبه',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: AppSize.s12
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'در حال محاسبه',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: AppSize.s12
                ),
              ),
            ),
          ),
        ],
      ),
    ))
        .toList();
  }
}

class _DetailsInvoiceShimmerWidget extends StatelessWidget {
  final ServiceType serviceType;
  const _DetailsInvoiceShimmerWidget({required this.serviceType});

  @override
  Widget build(BuildContext context) {
    final Color headerColor = switch (serviceType) {
      ServiceType.aidService => Theme.of(context).colorScheme.primary.withOpacity(0.2),
      ServiceType.homeService => Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
    };
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSize.s12),
              topRight: Radius.circular(AppSize.s12),
            ),
            border: Border(
              bottom: BorderSide(
                width: AppSize.s1,
                color: Theme.of(context).colorScheme.onSecondary,
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
                    (serviceType == ServiceType.homeService) ? 'جزئیات هزینه های خدماتی' : 'جزئیات هزینه های امدادی',
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
                      'مشتری',
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
                      'شرکت/گارانتی',
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
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'هزینه ${index + 1}',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: AppSize.s12
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'در حال محاسبه',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontSize: AppSize.s12
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'در حال محاسبه',
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
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'جمع کل',
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
                    'در حال محاسبه',
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
                    'در حال محاسبه',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: AppSize.s14
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Space.h8
      ],
    );
  }
}

class _LaborInvoiceShimmerWidget extends StatelessWidget {
  final ServiceType serviceType;
  const _LaborInvoiceShimmerWidget({required this.serviceType});

  @override
  Widget build(BuildContext context) {
    final Color headerColor = switch (serviceType) {
      ServiceType.aidService => Theme.of(context).colorScheme.primary.withOpacity(0.2),
      ServiceType.homeService => Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
    };
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSize.s12),
              topRight: Radius.circular(AppSize.s12),
            ),
            border: Border(
              bottom: BorderSide(
                width: AppSize.s1,
                color: Theme.of(context).colorScheme.onSecondary,
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
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'اجرت ${index + 1}',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: AppSize.s12
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'در حال محاسبه',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontSize: AppSize.s12
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'در حال محاسبه',
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
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'جمع کل',
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
                    'در حال محاسبه',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: AppSize.s14
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Space.h8
      ],
    );
  }
}

class _PartInvoiceShimmerWidget extends StatelessWidget {
  final ServiceType serviceType;
  const _PartInvoiceShimmerWidget({required this.serviceType});

  @override
  Widget build(BuildContext context) {
    final Color headerColor = switch (serviceType) {
      ServiceType.aidService => Theme.of(context).colorScheme.primary.withOpacity(0.2),
      ServiceType.homeService => Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
    };
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSize.s12),
              topRight: Radius.circular(AppSize.s12),
            ),
            border: Border(
              bottom: BorderSide(
                width: AppSize.s1,
                color: Theme.of(context).colorScheme.onSecondary,
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
                    'جزئیات قطعات',
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
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'قطعه ${index + 1}',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: AppSize.s12
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'در حال محاسبه',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontSize: AppSize.s12
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'در حال محاسبه',
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
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'جمع کل',
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
                    'در حال محاسبه',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: AppSize.s14
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Space.h8
      ],
    );
  }
}




*/
