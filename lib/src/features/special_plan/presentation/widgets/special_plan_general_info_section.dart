import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class SpecialPlanGeneralInfoSection extends StatelessWidget {
  const SpecialPlanGeneralInfoSection({
    super.key,
    required this.titleController,
    required this.startDateController,
    required this.endDateController,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.onStatusChanged,
    required this.requiredValidator,
  });

  static const _statusItems = [
    SimpleDropdownItem<bool>(value: true, label: 'فعال'),
    SimpleDropdownItem<bool>(value: false, label: 'غیرفعال'),
  ];

  final TextEditingController titleController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isActive;
  final ValueChanged<DateTime> onStartDateChanged;
  final ValueChanged<DateTime> onEndDateChanged;
  final ValueChanged<bool> onStatusChanged;
  final String? Function(String?) requiredValidator;

  @override
  Widget build(BuildContext context) {
    final selectedStatus = _statusItems.firstWhere(
      (item) => item.value == isActive,
    );
    return FormSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SpecialPlanSectionHeader(
            title: 'اطلاعات طرح',
            icon: Icons.description_outlined,
          ),
          Space.h20,
          TextFormFieldWidget(
            controller: titleController,
            labelText: 'نام طرح ویژه',
            mandatory: true,
            validator: requiredValidator,
          ),
          Space.h16,
          Row(
            children: [
              Expanded(
                child: DatePickerWidget(
                  controller: startDateController,
                  labelText: 'تاریخ شروع',
                  hintText: 'انتخاب کنید',
                  mandatory: true,
                  validator: requiredValidator,
                  initialDate: startDate == null
                      ? null
                      : Jalali.fromDateTime(startDate!),
                  lastDate: Jalali(1500, 12, 29),
                  suffixIcon: const Icon(Icons.calendar_month_outlined),
                  onTap: (value) {
                    if (value != null) onStartDateChanged(value.toDateTime());
                  },
                ),
              ),
              Space.w12,
              Expanded(
                child: DatePickerWidget(
                  controller: endDateController,
                  labelText: 'تاریخ پایان',
                  hintText: 'انتخاب کنید',
                  mandatory: true,
                  validator: requiredValidator,
                  initialDate:
                      endDate == null ? null : Jalali.fromDateTime(endDate!),
                  lastDate: Jalali(1500, 12, 29),
                  suffixIcon: const Icon(Icons.calendar_month_outlined),
                  onTap: (value) {
                    if (value != null) onEndDateChanged(value.toDateTime());
                  },
                ),
              ),
            ],
          ),
          Space.h16,
          OverlayDropdownFormField<SimpleDropdownItem<bool>>(
            key: ValueKey('special-plan-status-$isActive'),
            labelText: 'وضعیت',
            mandatory: true,
            items: _statusItems,
            value: selectedStatus,
            onChanged: (item) {
              if (item != null) onStatusChanged(item.value);
            },
          ),
        ],
      ),
    );
  }
}
