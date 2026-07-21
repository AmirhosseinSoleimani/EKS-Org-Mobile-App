import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_section.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_validator.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_state.dart';

class RescuerCooperationForm extends StatelessWidget {
  const RescuerCooperationForm({super.key, required this.cubit});

  final AddRescuerCubit cubit;

  static const _maritalItems = <SimpleDropdownItem<int>>[
    SimpleDropdownItem(value: 1, label: 'مجرد'),
    SimpleDropdownItem(value: 2, label: 'متأهل'),
  ];

  static const _degreeItems = <SimpleDropdownItem<int>>[
    SimpleDropdownItem(value: 1, label: 'زیر دیپلم'),
    SimpleDropdownItem(value: 2, label: 'دیپلم'),
    SimpleDropdownItem(value: 3, label: 'کاردانی'),
    SimpleDropdownItem(value: 4, label: 'کارشناسی'),
    SimpleDropdownItem(value: 5, label: 'کارشناسی ارشد'),
    SimpleDropdownItem(value: 6, label: 'دکتری'),
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.cooperationFormKey,
      child: RescuerFormSection(
        title: 'اطلاعات همکاری',
        icon: Icons.person_outline,
        child: Column(
          children: [
            OverlayDropdownFormField<SimpleDropdownItem<int>>(
              labelText: 'وضعیت تأهل',
              items: _maritalItems,
              mandatory: true,
              value: _find(_maritalItems, cubit.marital),
              validator: (value) => RescuerFormValidator.requiredSelection(
                value,
                'وضعیت تأهل',
              ),
              onChanged: (item) => cubit.marital = item?.value,
            ),
            const SizedBox(height: 16),
            OverlayDropdownFormField<SimpleDropdownItem<int>>(
              labelText: 'مدرک تحصیلی',
              items: _degreeItems,
              value: _find(_degreeItems, cubit.degree),
              onChanged: (item) => cubit.degree = item?.value,
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              labelText: 'رشته',
              controller: cubit.fieldGraduationController,
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              labelText: 'سایز لباس',
              controller: cubit.clothingSizeController,
              textInputType: TextInputType.number,
              textInputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              labelText: 'سایز کفش',
              controller: cubit.shoesSizeController,
              textInputType: TextInputType.number,
              textInputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 16),
            DatePickerWidget(
              labelText: 'تاریخ شروع همکاری',
              hintText: 'انتخاب تاریخ',
              mandatory: true,
              controller: cubit.cooperationStartDateController,
              onTap: cubit.setCooperationStartDate,
              validator: (value) => RescuerFormValidator.requiredText(
                value,
                'تاریخ شروع همکاری',
              ),
              suffixIcon: const Icon(
                Icons.calendar_month_outlined,
                color: Color(0xFFA4A4A4),
              ),
            ),
            const SizedBox(height: 16),
            OverlayDropdownFormField<SimpleDropdownItem<bool>>(
              labelText: 'وضعیت',
              value: cubit.statusItems.firstWhere(
                    (item) => item.value == cubit.isActive,
              ),
              items: cubit.statusItems,
              mandatory: true,
              itemTitleBuilder: (item) => item.label,
              onChanged: (item) {
                if (item == null) return;
                cubit.isActive = item.value;
              },
            ),
          ],
        ),
      ),
    );
  }

  SimpleDropdownItem<int>? _find(
    List<SimpleDropdownItem<int>> items,
    int? value,
  ) {
    if (value == null) return null;
    for (final item in items) {
      if (item.value == value) return item;
    }
    return null;
  }
}
