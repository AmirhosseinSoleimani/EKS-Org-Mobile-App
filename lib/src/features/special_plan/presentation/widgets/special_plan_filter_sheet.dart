import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_filter_controller.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/shared/input_formatter/persian_arabic_digits_to_english_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class SpecialPlanFilterSheet extends StatelessWidget {
  const SpecialPlanFilterSheet({
    super.key,
    required this.products,
    required this.provinces,
    required this.controller,
  });

  static const List<SimpleDropdownItem<bool?>> _booleanItems = [
    SimpleDropdownItem<bool?>(value: null, label: 'همه'),
    SimpleDropdownItem<bool?>(value: true, label: 'بله'),
    SimpleDropdownItem<bool?>(value: false, label: 'خیر'),
  ];

  static const List<SimpleDropdownItem<bool?>> _statusItems = [
    SimpleDropdownItem<bool?>(value: null, label: 'همه'),
    SimpleDropdownItem<bool?>(value: true, label: 'فعال'),
    SimpleDropdownItem<bool?>(value: false, label: 'غیرفعال'),
  ];

  final List<SpecialPlanProductEntity> products;
  final List<ProvinceLookupEntity> provinces;
  final SpecialPlanFilterController controller;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormFieldWidget(
                controller: controller.titleController,
                labelText: 'عنوان',
              ),
              Space.h12,
              OverlayDropdownFormField<SpecialPlanProductEntity>(
                labelText: 'محصول',
                items: products,
                value: controller.product,
                onChanged: controller.selectProduct,
              ),
              Space.h12,
              OverlayDropdownFormField<SimpleDropdownItem<bool?>>(
                labelText: 'اولویت بالا',
                items: _booleanItems,
                value: _booleanItem(controller.hasHighPriority),
                onChanged: (item) => controller.selectHighPriority(item?.value),
              ),
              Space.h12,
              _SpecialPlanFilterDateFields(controller: controller),
              Space.h12,
              TextFormFieldWidget(
                controller: controller.orderController,
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
                items: provinces,
                value: controller.province,
                onChanged: controller.selectProvince,
              ),
              Space.h12,
              TextFormFieldWidget(
                controller: controller.cityController,
                labelText: 'شهر',
              ),
              Space.h12,
              OverlayDropdownFormField<SimpleDropdownItem<bool?>>(
                labelText: 'وضعیت',
                items: _statusItems,
                value: _statusItem(controller.isActive),
                onChanged: (item) => controller.selectStatus(item?.value),
              ),
              Space.h12,
              OverlayDropdownFormField<SimpleDropdownItem<bool?>>(
                labelText: 'فقط خودروهای سایپایی',
                items: _booleanItems,
                value: _booleanItem(controller.onlySaipaCars),
                onChanged: (item) =>
                    controller.selectOnlySaipaCars(item?.value),
              ),
            ],
          );
        },
      ),
    );
  }

  SimpleDropdownItem<bool?> _booleanItem(bool? value) {
    return _booleanItems.firstWhere((item) => item.value == value);
  }

  SimpleDropdownItem<bool?> _statusItem(bool? value) {
    return _statusItems.firstWhere((item) => item.value == value);
  }
}

class _SpecialPlanFilterDateFields extends StatelessWidget {
  const _SpecialPlanFilterDateFields({required this.controller});

  final SpecialPlanFilterController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DatePickerWidget(
            controller: controller.startDateController,
            labelText: 'تاریخ شروع',
            hintText: 'انتخاب کنید',
            initialDate: controller.startDate == null
                ? null
                : Jalali.fromDateTime(controller.startDate!),
            lastDate: Jalali(1500, 12, 29),
            suffixIcon: const Icon(Icons.calendar_month_outlined),
            onTap: controller.selectStartDate,
          ),
        ),
        Space.w12,
        Expanded(
          child: DatePickerWidget(
            controller: controller.endDateController,
            labelText: 'تاریخ پایان',
            hintText: 'انتخاب کنید',
            initialDate: controller.endDate == null
                ? null
                : Jalali.fromDateTime(controller.endDate!),
            lastDate: Jalali(1500, 12, 29),
            suffixIcon: const Icon(Icons.calendar_month_outlined),
            onTap: controller.selectEndDate,
          ),
        ),
      ],
    );
  }
}
