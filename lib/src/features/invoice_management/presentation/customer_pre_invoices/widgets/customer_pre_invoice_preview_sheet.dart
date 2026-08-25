import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/details_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/labor_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/other_cost_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/part_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/sum_all_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:flutter/material.dart';

class CustomerPreInvoicePreviewSheet extends StatefulWidget {
  const CustomerPreInvoicePreviewSheet({
    super.key,
    required this.invoice,
    required this.serviceType,
    this.onFinalize,
    this.onOpenDocument,
  });

  final InvoiceEntity invoice;
  final ServiceType serviceType;
  final Future<bool> Function()? onFinalize;
  final Future<void> Function()? onOpenDocument;

  @override
  State<CustomerPreInvoicePreviewSheet> createState() =>
      _CustomerPreInvoicePreviewSheetState();
}

class _CustomerPreInvoicePreviewSheetState
    extends State<CustomerPreInvoicePreviewSheet> {
  bool _isFinalizing = false;
  bool _isOpeningDocument = false;

  @override
  Widget build(BuildContext context) {
    final invoice = widget.invoice;
    final otherCosts = _resolveOtherCosts(invoice);

    return SafeArea(
      child: Column(
        children: [
          FullScreenBottomSheetAppBar(
            title: _title(invoice.invoiceTitle),
            onClose: () => Navigator.of(context).pop(false),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppPadding.p16),
              children: [
                _buildInvoiceMeta(context),
                Space.h16,
                _CustomerTotalsCard(
                  entity: invoice.sumAllInvoice,
                  serviceType: widget.serviceType,
                  hasParts:
                      invoice.partInvoice?.partReception?.isNotEmpty ?? false,
                ),
                if (invoice.detailsInvoice != null) ...[
                  Space.h16,
                  _DetailsSection(entity: invoice.detailsInvoice!),
                ],
                if (invoice.laborInvoice?.laborReception?.isNotEmpty ?? false)
                  ...[
                    Space.h16,
                    _LaborSection(entity: invoice.laborInvoice!),
                  ],
                if (invoice.partInvoice?.partReception?.isNotEmpty ?? false)
                  ...[
                    Space.h16,
                    _PartSection(entity: invoice.partInvoice!),
                  ],
                if (otherCosts?.otherCostReceptions?.isNotEmpty ?? false) ...[
                  Space.h16,
                  _OtherCostsSection(entity: otherCosts!),
                ],
                if (_optionTitles.isNotEmpty) ...[
                  Space.h16,
                  _OptionsSection(titles: _optionTitles),
                ],
              ],
            ),
          ),
          if (widget.onFinalize != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p8,
                AppPadding.p16,
                AppPadding.p16,
              ),
              child: InkwellButtonWidget(
                title: 'نهایی سازی فاکتور',
                backgroundColor: widget.serviceType.serviceColor,
                showLoading: _isFinalizing,
                onTap: _isFinalizing ? null : _finalize,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInvoiceMeta(BuildContext context) {
    final summary = widget.invoice.sumAllInvoice;
    final categoryTitle = summary?.emdadServiceCategoryTitle?.trim();
    final evaluationChangedTitle = summary?.evaluationChangedTitle?.trim();
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Wrap(
            spacing: AppSize.s8,
            runSpacing: AppSize.s8,
            children: [
              StatusLabel(
                text: summary?.isSubscription == true ? 'مشترک' : 'غیر مشترک',
                color: summary?.isSubscription == true
                    ? Colors.green
                    : theme.colorScheme.error,
              ),
              StatusLabel(
                text: summary?.isGuaranty == true
                    ? 'گارانتی دارد'
                    : 'گارانتی ندارد',
                color: summary?.isGuaranty == true
                    ? Colors.green
                    : theme.colorScheme.error,
              ),
              if (categoryTitle != null && categoryTitle.isNotEmpty)
                StatusLabel(
                  text: categoryTitle,
                  color: widget.serviceType.serviceColor,
                ),
              if (summary?.isEvaluationChanged == true &&
                  evaluationChangedTitle != null &&
                  evaluationChangedTitle.isNotEmpty)
                StatusLabel(
                  text: evaluationChangedTitle,
                  color: theme.colorScheme.tertiary,
                ),
            ],
          ),
        ),
        if (widget.onOpenDocument != null) ...[
          Space.w8,
          IconButton(
            tooltip: 'مشاهده فاکتور',
            onPressed: _isOpeningDocument ? null : _openDocument,
            icon: _isOpeningDocument
                ? SizedBox.square(
                    dimension: AppSize.s20,
                    child: CircularProgressIndicator(
                      strokeWidth: AppSize.s2,
                      color: widget.serviceType.serviceColor,
                    ),
                  )
                : Icon(
                    Icons.download_rounded,
                    color: widget.serviceType.serviceColor,
                  ),
          ),
        ],
      ],
    );
  }

  Future<void> _finalize() async {
    final callback = widget.onFinalize;
    if (callback == null || _isFinalizing) return;

    setState(() => _isFinalizing = true);
    final success = await callback();
    if (!mounted) return;

    setState(() => _isFinalizing = false);
    if (success) Navigator.of(context).pop(true);
  }

  Future<void> _openDocument() async {
    final callback = widget.onOpenDocument;
    if (callback == null || _isOpeningDocument) return;

    setState(() => _isOpeningDocument = true);
    await callback();
    if (!mounted) return;
    setState(() => _isOpeningDocument = false);
  }

  String _title(String? value) {
    final title = value?.trim();
    return title?.isNotEmpty == true ? title! : 'پیش فاکتور مشتری';
  }

  OtherCostInvoiceEntity? _resolveOtherCosts(InvoiceEntity invoice) {
    if (invoice.otherCosts?.otherCostReceptions?.isNotEmpty ?? false) {
      return invoice.otherCosts;
    }
    return invoice.otherCostInvoice;
  }

  List<String> get _optionTitles {
    final result = <String>[];
    for (final option in widget.invoice.options ?? const <dynamic>[]) {
      String? title;
      if (option is Map) {
        title = option['title']?.toString().trim();
      } else {
        title = option?.toString().trim();
      }
      if (title != null && title.isNotEmpty && title != 'null') {
        result.add(title);
      }
    }
    return result;
  }
}

class _CustomerTotalsCard extends StatelessWidget {
  const _CustomerTotalsCard({
    required this.entity,
    required this.serviceType,
    required this.hasParts,
  });

  final SumAllInvoiceEntity? entity;
  final ServiceType serviceType;
  final bool hasParts;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: entity?.title?.trim().isNotEmpty == true
          ? entity!.title!.trim()
          : 'هزینه ها',
      accentColor: serviceType.serviceColor,
      child: Column(
        children: [
          _AmountPairHeader(accentColor: serviceType.serviceColor),
          _AmountPairRow(
            label: 'جمع کل هزینه های خدماتی',
            customer: entity?.detailEmdadInvoiceTotalCustomer,
            company: entity?.detailEmdadInvoiceTotalCompany,
          ),
          _AmountPairRow(
            label: 'جمع کل اجرت ها',
            customer: entity?.laborCustomerTotal,
            company: entity?.laborCompanyTotal,
          ),
          _AmountPairRow(
            label: 'جمع کل قطعات',
            customer: entity?.partCustomerTotal,
            company: entity?.partCompanyTotal,
          ),
          _AmountPairRow(
            label: 'جمع سایر هزینه ها',
            customer: entity?.totalOtherCostCustomerPrice,
            company: entity?.totalOtherCostCompanyPrice,
          ),
          _AmountPairRow(
            label: 'جمع تخفیف',
            customer: entity?.discountTotalPrice,
            company: 0,
          ),
          _AmountPairRow(
            label: _text(entity?.taxTotalCustomerText, fallback: 'مالیات'),
            customer: entity?.taxTotalCustomer,
            company: entity?.taxTotalCompany,
          ),
          _AmountPairRow(
            label: 'جمع کل',
            customer: entity?.totalAllItemsCustomer,
            company: entity?.totalAllItemsCompany,
            emphasize: true,
          ),
          if (hasParts)
            _AmountPairRow(
              label: 'جمع ارزش داغی',
              customer: entity?.totalReusableCustomerPrice,
              company: entity?.totalReusableCompanyPrice,
            ),
          Space.h12,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppPadding.p12),
            decoration: BoxDecoration(
              color: serviceType.serviceColor.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
            child: Text(
              'مبلغ قابل پرداخت مشتری: ${_money(entity?.customerPaymentPrice)} ریال',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({required this.entity});

  final DetailsInvoiceEntity entity;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: _text(entity.title, fallback: 'جزئیات هزینه های خدماتی'),
      child: Column(
        children: [
          for (final item in entity.invoiceItems ?? const <DetailsInvoiceItemEntity>[])
            _ItemCard(
              children: [
                _ValueRow(label: 'شرح', value: item.aidItemTypeStr),
                _ValueRow(label: 'قیمت پایه مشتری', value: _money(item.customerBasePrice)),
                _ValueRow(label: 'تخفیف مشتری', value: _money(item.customerDiscountPrice)),
                _ValueRow(label: 'قیمت نهایی مشتری', value: _money(item.customerPrice)),
                _ValueRow(label: 'عهده شرکت/گارانتی', value: _money(item.companyPrice)),
              ],
            ),
          _TotalsRow(
            customer: entity.customerTotal,
            company: entity.companyTotal,
          ),
        ],
      ),
    );
  }
}

class _LaborSection extends StatelessWidget {
  const _LaborSection({required this.entity});

  final LaborInvoiceEntity entity;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: _text(entity.title, fallback: 'جزئیات اجرت ها'),
      child: Column(
        children: [
          for (final item in entity.laborReception ?? const <LaborReceptionEntity>[])
            _ItemCard(
              children: [
                _ValueRow(label: 'کد تعمیرات', value: item.laborCode),
                _ValueRow(label: 'شرح عملیات/تعمیرات', value: item.laborDescription),
                _ValueRow(label: 'هزینه سرویس', value: _money(item.basePrice)),
                _ValueRow(label: 'تخفیف', value: _money(item.discountPrice)),
                _ValueRow(label: 'هزینه نهایی', value: _money(item.price)),
                _ValueRow(label: 'مرکز هزینه', value: item.nahveMohasebeDescription),
              ],
            ),
          _SingleTotalRow(value: entity.total),
        ],
      ),
    );
  }
}

class _PartSection extends StatelessWidget {
  const _PartSection({required this.entity});

  final PartInvoiceEntity entity;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: _text(entity.title, fallback: 'جزئیات قطعات'),
      child: Column(
        children: [
          for (final item in entity.partReception ?? const <PartReceptionEntity>[])
            _ItemCard(
              children: [
                _ValueRow(label: 'شرح قطعه', value: item.commodityDescription),
                _ValueRow(label: 'شماره سریال', value: item.commodityCode),
                _ValueRow(label: 'مارک', value: item.mark),
                _ValueRow(label: 'تعداد', value: item.replaceCount?.toString()),
                _ValueRow(
                  label: 'شرح',
                  value: _firstText([
                    item.partReusableDescription,
                    item.description,
                  ]),
                ),
                _ValueRow(label: 'قیمت واحد', value: _money(item.basePrice)),
                _ValueRow(label: 'تخفیف', value: _money(item.discountPrice)),
                _ValueRow(label: 'قیمت نهایی', value: _money(item.partPriceRial)),
                _ValueRow(
                  label: 'قیمت کل',
                  value: _money(
                    (item.partPriceRial ?? 0) * (item.replaceCount ?? 0),
                  ),
                ),
                _ValueRow(label: 'مرکز هزینه', value: item.nahveMohasebeDescription),
              ],
            ),
          _SingleTotalRow(value: entity.total),
        ],
      ),
    );
  }
}

class _OtherCostsSection extends StatelessWidget {
  const _OtherCostsSection({required this.entity});

  final OtherCostInvoiceEntity entity;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: _text(entity.title, fallback: 'سایر هزینه ها'),
      child: Column(
        children: [
          for (final item in entity.otherCostReceptions ?? const <OtherCostReceptionEntity>[])
            _ItemCard(
              children: [
                _ValueRow(label: 'شرح', value: item.title),
                _ValueRow(label: 'قیمت پایه مشتری', value: _money(item.customerBasePrice)),
                _ValueRow(label: 'تخفیف مشتری', value: _money(item.customerDiscountPrice)),
                _ValueRow(label: 'قیمت نهایی مشتری', value: _money(item.customerPrice)),
                _ValueRow(label: 'عهده شرکت/گارانتی', value: _money(item.companyPrice)),
              ],
            ),
          _TotalsRow(
            customer: entity.customerTotalPrice,
            company: entity.companyTotalPrice,
          ),
        ],
      ),
    );
  }
}

class _OptionsSection extends StatelessWidget {
  const _OptionsSection({required this.titles});

  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'مزایای اشتراک',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'با توجه به اشتراک موجود از آپشن های ذیل بهره مند هستید:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Space.h8,
          for (final title in titles)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•'),
                  Space.w8,
                  Expanded(child: Text(title)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
    this.accentColor,
  });

  final String title;
  final Widget child;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? Theme.of(context).colorScheme.primary;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(color: color.withValues(alpha: .16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(AppPadding.p12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSize.s12),
                topRight: Radius.circular(AppSize.s12),
              ),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppPadding.p12),
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Column(children: children),
    );
  }
}

class _ValueRow extends StatelessWidget {
  const _ValueRow({required this.label, this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          Space.w8,
          Expanded(
            flex: 3,
            child: Text(
              _text(value),
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountPairHeader extends StatelessWidget {
  const _AmountPairHeader({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p8),
      child: Row(
        children: [
          const Expanded(flex: 2, child: SizedBox.shrink()),
          Expanded(
            child: Text(
              'مشتری',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              'شرکت/گارانتی',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountPairRow extends StatelessWidget {
  const _AmountPairRow({
    required this.label,
    this.customer,
    this.company,
    this.emphasize = false,
  });

  final String label;
  final num? customer;
  final num? company;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: emphasize ? FontWeight.w700 : FontWeight.w500,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: style)),
          Expanded(
            child: Text(
              _money(customer),
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
          Expanded(
            child: Text(
              _money(company),
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalsRow extends StatelessWidget {
  const _TotalsRow({this.customer, this.company});

  final num? customer;
  final num? company;

  @override
  Widget build(BuildContext context) {
    return _AmountPairRow(
      label: 'جمع کل',
      customer: customer,
      company: company,
      emphasize: true,
    );
  }
}

class _SingleTotalRow extends StatelessWidget {
  const _SingleTotalRow({this.value});

  final num? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'جمع کل',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        Text(
          '${_money(value)} ریال',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

String _money(num? value) => '${value ?? 0}'.splitPriceByComma();

String _text(String? value, {String fallback = '---'}) {
  final normalized = value?.trim();
  if (normalized == null ||
      normalized.isEmpty ||
      normalized.toLowerCase() == 'null') {
    return fallback;
  }
  return normalized;
}

String _firstText(List<String?> values) {
  for (final value in values) {
    final normalized = value?.trim();
    if (normalized != null &&
        normalized.isNotEmpty &&
        normalized.toLowerCase() != 'null') {
      return normalized;
    }
  }
  return '---';
}
