import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_filter_controller.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/shared/input_formatter/persian_arabic_digits_to_english_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class SpecialPlanFilterSheet extends StatelessWidget {
  const SpecialPlanFilterSheet({
    super.key,
    required this.products,
    required this.provinces,
    required this.controller,
    required this.onApply,
    required this.onClear,
  });

  final List<SpecialPlanProductEntity> products;
  final List<ProvinceLookupEntity> provinces;
  final SpecialPlanFilterController controller;
  final VoidCallback onApply;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return FilterBottomSheetScaffold(
          title: 'فیلترها',
          onApply: onApply,
          onClear: onClear,
          child: Column(
            children: [
              TextFormFieldWidget(
                controller: controller.titleController,
                labelText: 'عنوان',
              ),
              Space.h12,
              EkDropDown(
                ['همه', ...products.map((item) => item.label)],
                label: 'محصول',
                selectedItem: controller.product?.label ?? 'همه',
                onItemValue: (value) => controller.selectProduct(
                  value == 'همه' ? null : _findProduct(value),
                ),
              ),
              Space.h12,
              EkDropDown(
                const ['همه', 'بله', 'خیر'],
                label: 'اولویت بالا',
                selectedItem: _booleanTitle(controller.hasHighPriority),
                onItemValue: (value) =>
                    controller.selectHighPriority(_booleanValue(value)),
              ),
              Space.h12,
              DatePickerWidget(
                controller: controller.startDateController,
                labelText: 'تاریخ شروع',
                hintText: 'انتخاب تاریخ',
                initialDate: controller.startDate == null
                    ? null
                    : Jalali.fromDateTime(controller.startDate!),
                lastDate: Jalali(1500, 12, 29),
                onTap: controller.selectStartDate,
              ),
              Space.h12,
              DatePickerWidget(
                controller: controller.endDateController,
                labelText: 'تاریخ پایان',
                hintText: 'انتخاب تاریخ',
                initialDate: controller.endDate == null
                    ? null
                    : Jalali.fromDateTime(controller.endDate!),
                lastDate: Jalali(1500, 12, 29),
                onTap: controller.selectEndDate,
              ),
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
              EkDropDown(
                ['همه', ...provinces.map((item) => item.label)],
                label: 'استان',
                selectedItem: controller.province?.label ?? 'همه',
                onItemValue: (value) => controller.selectProvince(
                  value == 'همه' ? null : _findProvince(value),
                ),
              ),
              Space.h12,
              TextFormFieldWidget(
                controller: controller.cityController,
                labelText: 'شهر',
              ),
              Space.h12,
              EkDropDown(
                const ['همه', 'فعال', 'غیرفعال'],
                label: 'وضعیت',
                selectedItem: _statusTitle(controller.isActive),
                onItemValue: (value) =>
                    controller.selectStatus(_statusValue(value)),
              ),
              Space.h12,
              EkDropDown(
                const ['همه', 'بله', 'خیر'],
                label: 'فقط خودروهای سایپایی',
                selectedItem: _booleanTitle(controller.onlySaipaCars),
                onItemValue: (value) =>
                    controller.selectOnlySaipaCars(_booleanValue(value)),
              ),
            ],
          ),
        );
      },
    );
  }

  SpecialPlanProductEntity? _findProduct(String label) {
    for (final item in products) {
      if (item.label == label) return item;
    }
    return null;
  }

  ProvinceLookupEntity? _findProvince(String label) {
    for (final item in provinces) {
      if (item.label == label) return item;
    }
    return null;
  }

  String _booleanTitle(bool? value) {
    if (value == true) return 'بله';
    if (value == false) return 'خیر';
    return 'همه';
  }

  bool? _booleanValue(String value) {
    if (value == 'بله') return true;
    if (value == 'خیر') return false;
    return null;
  }

  String _statusTitle(bool? value) {
    if (value == true) return 'فعال';
    if (value == false) return 'غیرفعال';
    return 'همه';
  }

  bool? _statusValue(String value) {
    if (value == 'فعال') return true;
    if (value == 'غیرفعال') return false;
    return null;
  }
}
