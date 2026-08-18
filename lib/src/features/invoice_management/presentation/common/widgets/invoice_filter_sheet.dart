import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/switch_widgets/labeled_switch_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class InvoiceFilterSheet extends StatefulWidget {
  const InvoiceFilterSheet({
    super.key,
    this.title = 'فیلترها',
    this.showSubscriptionField = true,
    required this.initialFilter,
    required this.categories,
    required this.onApply,
    required this.onClear,
  });

  final String title;
  final bool showSubscriptionField;
  final InvoiceListFilterParamEntity initialFilter;
  final List<EmdadServiceCategoryEntity> categories;
  final ValueChanged<InvoiceListFilterParamEntity> onApply;
  final VoidCallback onClear;

  @override
  State<InvoiceFilterSheet> createState() =>
      _InvoiceFilterSheetState();
}

class _InvoiceFilterSheetState
    extends State<InvoiceFilterSheet> {
  static const String _all = 'همه';

  late final TextEditingController _requestTrackCodeController;
  late final TextEditingController _agencyCodeController;
  late final TextEditingController _emdadgarNameController;
  late final TextEditingController _fromDateController;
  late final TextEditingController _toDateController;

  late ServiceType _serviceType;
  EmdadServiceCategoryEntity? _category;
  Jalali? _fromDate;
  Jalali? _toDate;
  bool _showSubscription = false;

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

    _serviceType = filter.serviceType ?? ServiceType.reliefService;
    _category = _findCategory(filter.givenCode);
    _fromDate = _jalaliFromApiDate(filter.fromDate);
    _toDate = _jalaliFromApiDate(filter.toDate);
    _showSubscription = filter.showSubscription == true;

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
    final theme = Theme.of(context);
    final filteredCategories = _filteredCategories;

    return SafeArea(
      top: false,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.78,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p16,
                AppPadding.p16,
                AppPadding.p8,
              ),
              child: Text(
                widget.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p16,
                  vertical: AppPadding.p8,
                ),
                child: Column(
                  children: [
                    EkDropDown(
                      ServiceType.values.map((item) => item.label).toList(),
                      label: 'نوع خدمت',
                      selectedItem: _serviceType.label,
                      onItemValue: _onServiceTypeChanged,
                    ),
                    Space.h12,
                    EkDropDown(
                      [
                        _all,
                        ...filteredCategories
                            .map((item) => item.title?.trim())
                            .whereType<String>()
                            .where((item) => item.isNotEmpty),
                      ],
                      key: ValueKey(_serviceType.value),
                      label: 'دسته خدمت',
                      selectedItem: _category?.title?.trim() ?? _all,
                      onItemValue: _onCategoryChanged,
                    ),
                    Space.h12,
                    TextFormFieldWidget(
                      controller: _requestTrackCodeController,
                      labelText: 'شماره درخواست',
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    Space.h12,
                    DatePickerWidget(
                      controller: _fromDateController,
                      labelText: 'از تاریخ',
                      hintText: 'انتخاب تاریخ',
                      initialDate: _fromDate,
                      lastDate: _toDate,
                      onTap: (value) {
                        setState(() => _fromDate = value);
                      },
                    ),
                    Space.h12,
                    DatePickerWidget(
                      controller: _toDateController,
                      labelText: 'تا تاریخ',
                      hintText: 'انتخاب تاریخ',
                      initialDate: _toDate,
                      firstDate: _fromDate,
                      onTap: (value) {
                        setState(() => _toDate = value);
                      },
                    ),
                    Space.h12,
                    TextFormFieldWidget(
                      controller: _agencyCodeController,
                      labelText: 'کد نمایندگی',
                      textInputAction: TextInputAction.next,
                    ),
                    Space.h12,
                    TextFormFieldWidget(
                      controller: _emdadgarNameController,
                      labelText: 'نام امدادگر',
                      textInputAction: TextInputAction.done,
                    ),
                    Space.h12,
                    if (widget.showSubscriptionField) ...[
                      LabeledSwitchField(
                        label: 'فقط درخواست‌های اشتراکی',
                        value: _showSubscription,
                        onChanged: (value) {
                          setState(() => _showSubscription = value);
                        },
                      ),
                      Space.h16,
                    ],
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p12,
                AppPadding.p16,
                AppPadding.p16,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: theme.dividerColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'اعمال فیلتر',
                      onTap: _apply,
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'پاک کردن',
                      backgroundColor: theme.colorScheme.onPrimary,
                      borderColor: theme.colorScheme.outline.withOpacity(0.6),
                      titleColor: theme.colorScheme.onSurface,
                      onTap: _clear,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<EmdadServiceCategoryEntity> get _filteredCategories {
    return widget.categories
        .where((item) => item.serviceTypeId == _serviceType.value)
        .toList();
  }

  void _onServiceTypeChanged(String value) {
    setState(() {
      _serviceType = ServiceType.values.firstWhere(
        (item) => item.label == value,
      );

      final category = _category;
      if (category != null &&
          category.serviceTypeId != _serviceType.value) {
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

  void _apply() {
    widget.onApply(
      InvoiceListFilterParamEntity(
        serviceType: _serviceType,
        givenCode: _category?.id,
        requestTrackCode: _normalized(_requestTrackCodeController.text),
        fromDate: _apiDate(_fromDate),
        toDate: _apiDate(_toDate),
        invoiceStatus: widget.initialFilter.invoiceStatus,
        showSubscription: widget.showSubscriptionField
            ? (_showSubscription ? true : null)
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

  String? _apiDate(Jalali? value) {
    if (value == null) return null;

    final gregorian = value.toGregorian();
    final month = gregorian.month.toString().padLeft(2, '0');
    final day = gregorian.day.toString().padLeft(2, '0');

    return '${gregorian.year}-$month-$day';
  }

  String _formatJalali(Jalali? value) {
    if (value == null) return '';

    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');

    return '${value.year}/$month/$day';
  }
}
