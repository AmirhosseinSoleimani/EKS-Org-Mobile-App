import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/services/special_plan_date_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/shared/input_formatter/persian_arabic_digits_to_english_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class SpecialPlanFilterValue {
  const SpecialPlanFilterValue({
    this.title,
    this.productId,
    this.hasHighPriority,
    this.startDate,
    this.endDate,
    this.orderNo,
    this.provinceTitle,
    this.cityTitle,
    this.isActive,
    this.onlySaipaCars,
  });

  final String? title;
  final int? productId;
  final bool? hasHighPriority;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? orderNo;
  final String? provinceTitle;
  final String? cityTitle;
  final bool? isActive;
  final bool? onlySaipaCars;
}

class SpecialPlanFilterSheet extends StatefulWidget {
  const SpecialPlanFilterSheet({
    super.key,
    required this.products,
    required this.provinces,
    required this.initialValue,
    required this.onSubmit,
  });

  final List<SpecialPlanProductEntity> products;
  final List<ProvinceLookupEntity> provinces;
  final SpecialPlanFilterValue initialValue;
  final ValueChanged<SpecialPlanFilterValue> onSubmit;

  @override
  State<SpecialPlanFilterSheet> createState() =>
      _SpecialPlanFilterSheetState();
}

class _SpecialPlanFilterSheetState extends State<SpecialPlanFilterSheet> {
  static const _booleanItems = [
    SimpleDropdownItem<bool?>(value: null, label: 'همه'),
    SimpleDropdownItem<bool?>(value: true, label: 'بله'),
    SimpleDropdownItem<bool?>(value: false, label: 'خیر'),
  ];
  static const _statusItems = [
    SimpleDropdownItem<bool?>(value: null, label: 'همه'),
    SimpleDropdownItem<bool?>(value: true, label: 'فعال'),
    SimpleDropdownItem<bool?>(value: false, label: 'غیرفعال'),
  ];

  late final TextEditingController _titleController;
  late final TextEditingController _orderController;
  late final TextEditingController _cityController;
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;
  SpecialPlanProductEntity? _product;
  ProvinceLookupEntity? _province;
  bool? _hasHighPriority;
  bool? _isActive;
  bool? _onlySaipaCars;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialValue;
    _titleController = TextEditingController(text: initial.title);
    _orderController = TextEditingController(
      text: initial.orderNo?.toString() ?? '',
    );
    _cityController = TextEditingController(text: initial.cityTitle);
    _startDateController = TextEditingController(
      text: initial.startDate == null
          ? ''
          : SpecialPlanDateFormatter.jalaliDate(initial.startDate),
    );
    _endDateController = TextEditingController(
      text: initial.endDate == null
          ? ''
          : SpecialPlanDateFormatter.jalaliDate(initial.endDate),
    );
    _product = _findProduct(initial.productId);
    _province = _findProvince(initial.provinceTitle);
    _hasHighPriority = initial.hasHighPriority;
    _isActive = initial.isActive;
    _onlySaipaCars = initial.onlySaipaCars;
    _startDate = initial.startDate;
    _endDate = initial.endDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _orderController.dispose();
    _cityController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormFieldWidget(
                controller: _titleController,
                labelText: 'عنوان',
              ),
              Space.h12,
              OverlayDropdownFormField<SpecialPlanProductEntity>(
                labelText: 'محصول',
                items: widget.products,
                value: _product,
                onChanged: (item) => setState(() => _product = item),
              ),
              Space.h12,
              OverlayDropdownFormField<SimpleDropdownItem<bool?>>(
                labelText: 'اولویت بالا',
                items: _booleanItems,
                value: _booleanItem(_hasHighPriority),
                onChanged: (item) =>
                    setState(() => _hasHighPriority = item?.value),
              ),
              Space.h12,
              Row(
                children: [
                  Expanded(
                    child: DatePickerWidget(
                      controller: _startDateController,
                      labelText: 'تاریخ شروع',
                      hintText: 'انتخاب کنید',
                      initialDate: _startDate == null
                          ? null
                          : Jalali.fromDateTime(_startDate!),
                      lastDate: Jalali(1500, 12, 29),
                      suffixIcon: const Icon(Icons.calendar_month_outlined),
                      onTap: (date) {
                        if (date == null) return;
                        setState(() => _startDate = date.toDateTime());
                      },
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: DatePickerWidget(
                      controller: _endDateController,
                      labelText: 'تاریخ پایان',
                      hintText: 'انتخاب کنید',
                      initialDate: _endDate == null
                          ? null
                          : Jalali.fromDateTime(_endDate!),
                      lastDate: Jalali(1500, 12, 29),
                      suffixIcon: const Icon(Icons.calendar_month_outlined),
                      onTap: (date) {
                        if (date == null) return;
                        setState(() => _endDate = date.toDateTime());
                      },
                    ),
                  ),
                ],
              ),
              Space.h12,
              TextFormFieldWidget(
                controller: _orderController,
                labelText: 'شماره اولویت',
                textInputType: TextInputType.number,
                textInputFormatter: [
                  PersianArabicDigitsToEnglishFormatter(),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              Space.h12,
              OverlayDropdownFormField<ProvinceLookupEntity>(
                labelText: 'استان',
                items: widget.provinces,
                value: _province,
                onChanged: (item) => setState(() => _province = item),
              ),
              Space.h12,
              TextFormFieldWidget(
                controller: _cityController,
                labelText: 'شهر',
              ),
              Space.h12,
              OverlayDropdownFormField<SimpleDropdownItem<bool?>>(
                labelText: 'وضعیت',
                items: _statusItems,
                value: _statusItem(_isActive),
                onChanged: (item) => setState(() => _isActive = item?.value),
              ),
              Space.h12,
              OverlayDropdownFormField<SimpleDropdownItem<bool?>>(
                labelText: 'فقط خودروهای سایپایی',
                items: _booleanItems,
                value: _booleanItem(_onlySaipaCars),
                onChanged: (item) =>
                    setState(() => _onlySaipaCars = item?.value),
              ),
              Space.h20,
              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'اعمال فیلتر',
                      onTap: _submit,
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'حذف فیلتر',
                      backgroundColor: theme.colorScheme.onPrimary,
                      borderColor: theme.colorScheme.outline,
                      titleColor: theme.colorScheme.onSurface,
                      onTap: _clear,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    widget.onSubmit(
      SpecialPlanFilterValue(
        title: _text(_titleController),
        productId: _product?.id,
        hasHighPriority: _hasHighPriority,
        startDate: _startDate,
        endDate: _endDate,
        orderNo: int.tryParse(_orderController.text.trim()),
        provinceTitle: _province?.name,
        cityTitle: _text(_cityController),
        isActive: _isActive,
        onlySaipaCars: _onlySaipaCars,
      ),
    );
    context.pop();
  }

  void _clear() {
    widget.onSubmit(const SpecialPlanFilterValue());
    context.pop();
  }

  String? _text(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }

  SpecialPlanProductEntity? _findProduct(int? id) {
    if (id == null) return null;
    for (final item in widget.products) {
      if (item.id == id) return item;
    }
    return null;
  }

  ProvinceLookupEntity? _findProvince(String? title) {
    final value = title?.trim();
    if (value == null || value.isEmpty) return null;
    for (final item in widget.provinces) {
      if (item.name == value) return item;
    }
    return null;
  }

  SimpleDropdownItem<bool?> _booleanItem(bool? value) =>
      _booleanItems.firstWhere((item) => item.value == value);

  SimpleDropdownItem<bool?> _statusItem(bool? value) =>
      _statusItems.firstWhere((item) => item.value == value);
}
