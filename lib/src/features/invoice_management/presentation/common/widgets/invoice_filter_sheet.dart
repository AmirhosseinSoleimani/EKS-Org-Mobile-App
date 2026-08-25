import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class InvoiceFilterSheet extends StatefulWidget {
  const InvoiceFilterSheet({
    super.key,
    this.title = 'فیلترها',
    this.showSubscriptionField = true,
    this.allowAllServiceTypes = false,
    this.requireDateRange = false,
    this.requestTrackCodeMaxLength,
    this.agencyCodeMaxLength,
    this.emdadgarNameMaxLength,
    required this.initialFilter,
    required this.categories,
    required this.onApply,
    required this.onClear,
  });

  final String title;
  final bool showSubscriptionField;
  final bool allowAllServiceTypes;
  final bool requireDateRange;
  final int? requestTrackCodeMaxLength;
  final int? agencyCodeMaxLength;
  final int? emdadgarNameMaxLength;
  final InvoiceListFilterParamEntity initialFilter;
  final List<EmdadServiceCategoryEntity> categories;
  final ValueChanged<InvoiceListFilterParamEntity> onApply;
  final VoidCallback onClear;

  @override
  State<InvoiceFilterSheet> createState() => _InvoiceFilterSheetState();
}

class _InvoiceFilterSheetState extends State<InvoiceFilterSheet> {
  static const String _all = 'همه';

  late final TextEditingController _requestTrackCodeController;
  late final TextEditingController _agencyCodeController;
  late final TextEditingController _emdadgarNameController;
  late final TextEditingController _fromDateController;
  late final TextEditingController _toDateController;

  ServiceType? _serviceType;
  EmdadServiceCategoryEntity? _category;
  Jalali? _fromDate;
  Jalali? _toDate;
  bool? _showSubscription;

  @override
  void initState() {
    super.initState();

    final filter = widget.initialFilter;

    _requestTrackCodeController = TextEditingController(
      text: filter.requestTrackCode ?? '',
    );
    _agencyCodeController = TextEditingController(
      text: filter.agencyCode ?? '',
    );
    _emdadgarNameController = TextEditingController(
      text: filter.emdadgarName ?? '',
    );

    _serviceType = filter.serviceType ??
        (widget.allowAllServiceTypes ? null : ServiceType.reliefService);
    _category = _findCategory(filter.givenCode);
    _fromDate = _jalaliFromApiDate(filter.fromDate);
    _toDate = _jalaliFromApiDate(filter.toDate);
    _showSubscription = filter.showSubscription;

    _fromDateController = TextEditingController(
      text: _formatJalali(_fromDate),
    );
    _toDateController = TextEditingController(
      text: _formatJalali(_toDate),
    );
  }

  @override
  void dispose() {
    _requestTrackCodeController.dispose();
    _agencyCodeController.dispose();
    _emdadgarNameController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCategories = _filteredCategories;
    final serviceTypeItems = <String>[
      if (widget.allowAllServiceTypes) _all,
      ...ServiceType.values.map((item) => item.label),
    ];

    return FilterBottomSheetScaffold(
      title: widget.title,
      onApply: _apply,
      onClear: _clear,
      child: Column(
        children: [
          EkDropDown(
            serviceTypeItems,
            label: 'نوع خدمت',
            selectedItem: _serviceType?.label ?? _all,
            onItemValue: _onServiceTypeChanged,
          ),
          FilterBottomSheetScaffold.fieldGap,
          EkDropDown(
            [
              _all,
              ...filteredCategories
                  .map((item) => item.title?.trim())
                  .whereType<String>()
                  .where((item) => item.isNotEmpty),
            ],
            key: ValueKey(_serviceType?.value ?? -1),
            label: 'دسته خدمت',
            selectedItem: _category?.title?.trim() ?? _all,
            onItemValue: _onCategoryChanged,
          ),
          FilterBottomSheetScaffold.fieldGap,
          TextFormFieldWidget(
            controller: _requestTrackCodeController,
            labelText: 'شماره درخواست',
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLength: widget.requestTrackCodeMaxLength,
          ),
          FilterBottomSheetScaffold.fieldGap,
          DatePickerWidget(
            controller: _fromDateController,
            labelText: 'از تاریخ',
            mandatory: widget.requireDateRange,
            hintText: 'انتخاب تاریخ',
            initialDate: _fromDate,
            lastDate: _toDate,
            onTap: (value) {
              setState(() => _fromDate = value);
            },
          ),
          FilterBottomSheetScaffold.fieldGap,
          DatePickerWidget(
            controller: _toDateController,
            labelText: 'تا تاریخ',
            mandatory: widget.requireDateRange,
            hintText: 'انتخاب تاریخ',
            initialDate: _toDate,
            firstDate: _fromDate,
            onTap: (value) {
              setState(() => _toDate = value);
            },
          ),
          FilterBottomSheetScaffold.fieldGap,
          TextFormFieldWidget(
            controller: _agencyCodeController,
            labelText: 'کد نمایندگی',
            textInputAction: TextInputAction.next,
            maxLength: widget.agencyCodeMaxLength,
          ),
          FilterBottomSheetScaffold.fieldGap,
          TextFormFieldWidget(
            controller: _emdadgarNameController,
            labelText: 'نام امدادگر',
            textInputAction: TextInputAction.done,
            maxLength: widget.emdadgarNameMaxLength,
          ),
          if (widget.showSubscriptionField) ...[
            FilterBottomSheetScaffold.fieldGap,
            EkDropDown(
              const [_all, 'مشترک', 'غیر مشترک'],
              label: 'وضعیت اشتراک',
              selectedItem: _subscriptionLabel,
              onItemValue: _onSubscriptionChanged,
            ),
          ],
        ],
      ),
    );
  }

  List<EmdadServiceCategoryEntity> get _filteredCategories {
    final serviceType = _serviceType;
    if (serviceType == null) return const <EmdadServiceCategoryEntity>[];

    return widget.categories
        .where((item) => item.serviceTypeId == serviceType.value)
        .toList();
  }

  void _onServiceTypeChanged(String value) {
    setState(() {
      if (widget.allowAllServiceTypes && value == _all) {
        _serviceType = null;
        _category = null;
        return;
      }

      _serviceType = ServiceType.values.firstWhere(
        (item) => item.label == value,
      );

      final category = _category;
      if (category != null && category.serviceTypeId != _serviceType?.value) {
        _category = null;
      }
    });
  }

  void _onCategoryChanged(String value) {
    setState(() {
      _category = value == _all
          ? null
          : _filteredCategories.firstWhere(
              (item) => item.title?.trim() == value,
            );
    });
  }

  String get _subscriptionLabel {
    if (_showSubscription == true) return 'مشترک';
    if (_showSubscription == false) return 'غیر مشترک';
    return _all;
  }

  void _onSubscriptionChanged(String value) {
    setState(() {
      _showSubscription = switch (value) {
        'مشترک' => true,
        'غیر مشترک' => false,
        _ => null,
      };
    });
  }

  void _apply() {
    if (widget.requireDateRange && (_fromDate == null || _toDate == null)) {
      SnakeBarWidget.showError(
        context: context,
        message: 'وارد کردن تاریخ الزامیست.',
      );
      return;
    }

    widget.onApply(
      InvoiceListFilterParamEntity(
        serviceType: _serviceType,
        givenCode: _category?.id,
        requestTrackCode: _normalized(_requestTrackCodeController.text),
        fromDate: JalaliDateHelper.formatServerDateOnly(_fromDate?.toDateTime()),
        toDate: JalaliDateHelper.formatServerDateOnly(_toDate?.toDateTime()),
        invoiceStatus: widget.initialFilter.invoiceStatus,
        showSubscription: widget.showSubscriptionField
            ? _showSubscription
            : widget.initialFilter.showSubscription,
        categoryGivenCode: _category?.title,
        agencyCode: _normalized(_agencyCodeController.text),
        emdadgarName: _normalized(_emdadgarNameController.text),
        pageSize: widget.initialFilter.pageSize,
        skip: 0,
      ),
    );

    Navigator.of(context).pop();
  }

  void _clear() {
    widget.onClear();
    Navigator.of(context).pop();
  }

  EmdadServiceCategoryEntity? _findCategory(int? id) {
    if (id == null) return null;

    for (final category in widget.categories) {
      if (category.id == id) return category;
    }

    return null;
  }

  String? _normalized(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? null : normalized;
  }

  Jalali? _jalaliFromApiDate(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return null;

    final parts = normalized.split(RegExp(r'[-/]'));
    if (parts.length != 3) return null;

    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);

    if (year == null || month == null || day == null) return null;

    try {
      return Gregorian(year, month, day).toJalali();
    } catch (_) {
      return null;
    }
  }

  String _formatJalali(Jalali? value) {
    if (value == null) return '';

    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');

    return '${value.year}/$month/$day';
  }
}
