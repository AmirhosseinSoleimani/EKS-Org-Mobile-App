import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_city_dropdown_field.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_section.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_validator.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/input_formatter/input_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RescuerIdentityForm extends StatelessWidget {
  const RescuerIdentityForm({super.key, required this.cubit});

  final AddRescuerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.identityFormKey,
      child: RescuerFormSection(
        title: 'اطلاعات هویتی',
        icon: Icons.badge_rounded,
        child: Column(
          children: [
            TextFormFieldWidget(
              labelText: 'نام',
              mandatory: true,
              textInputType: TextInputType.name,
              controller: cubit.firstNameController,
              validator: (value) =>
                  RescuerFormValidator.requiredText(value, 'نام'),
              textInputFormatter: [
                FilteringTextInputFormatter.singleLineFormatter,
                NumberTextInputFormatter.lettersOnly,
              ],
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              labelText: 'نام خانوادگی',
              mandatory: true,
              controller: cubit.lastNameController,
              textInputType: TextInputType.name,
              validator: (value) =>
                  RescuerFormValidator.requiredText(value, 'نام خانوادگی'),
              textInputFormatter: [
                FilteringTextInputFormatter.singleLineFormatter,
                NumberTextInputFormatter.lettersOnly,
              ],
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              labelText: 'نام پدر',
              controller: cubit.fatherNameController,
              textInputType: TextInputType.name,
              textInputFormatter: [
                FilteringTextInputFormatter.singleLineFormatter,
                NumberTextInputFormatter.lettersOnly,
              ],
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              labelText: 'کدملی',
              mandatory: true,
              controller: cubit.nationalNumberController,
              textInputType: TextInputType.number,
              maxLength: 10,
              validator: (value) =>
                  RescuerFormValidator.requiredText(value, 'کدملی'),
              textInputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.singleLineFormatter,
              ],
            ),
            const SizedBox(height: 16),
            DatePickerWidget(
              labelText: 'تاریخ تولد',
              hintText: '',
              mandatory: true,
              controller: cubit.birthDateController,
              onTap: cubit.setBirthDate,
              validator: (value) =>
                  RescuerFormValidator.requiredText(value, 'تاریخ تولد'),
              suffixIcon: const Icon(
                Icons.calendar_month_outlined,
                color: Color(0xFFA4A4A4),
              ),
            ),
            const SizedBox(height: 16),
            OverlayDropdownFormField<ProvinceEntity>(
              labelText: 'محل تولد',
              value: cubit.birthCity,
              items: cubit.cities,
              mandatory: true,
              itemTitleBuilder: (item) => item.cityName ?? item.title ?? '-',
              validator: (value) => RescuerFormValidator.requiredSelection(
                value,
                'محل تولد',
              ),
              onChanged: (value) => cubit.birthCity = value,
            ),
          ],
        ),
      ),
    );
  }
}
