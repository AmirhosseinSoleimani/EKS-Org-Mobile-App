import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/add/add_rescuer_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_city_dropdown_field.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_section.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/add/rescuer_form_validator.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RescuerContactForm extends StatelessWidget {
  const RescuerContactForm({super.key, required this.cubit});

  final AddRescuerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.contactFormKey,
      child: RescuerFormSection(
        title: 'اطلاعات تماس و محل',
        icon: Icons.contact_phone_rounded,
        child: Column(
          children: [
            TextFormFieldWidget(
              labelText: 'موبایل',
              mandatory: true,
              controller: cubit.mobileController,
              textInputType: TextInputType.phone,
              maxLength: 11,
              validator: (value) =>
                  RescuerFormValidator.requiredText(value, 'موبایل'),
              textInputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              labelText: 'تلفن',
              controller: cubit.telController,
              textInputType: TextInputType.phone,
              textInputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 16),
            OverlayDropdownFormField<ProvinceEntity>(
              labelText: 'محل صدور شناسنامه',
              value: cubit.issuingCity,
              items: cubit.cities,
              mandatory: true,
              itemTitleBuilder: (item) => item.cityName ?? item.title ?? '-',
              onChanged: (value) => cubit.issuingCity = value,
              validator: (value) => RescuerFormValidator.requiredSelection(
                value,
                'محل صدور شناسنامه',
              ),
            ),
            const SizedBox(height: 16),
            RescuerCityDropdownField(
              label: 'شهر محل سکونت',
              value: cubit.addressCity,
              cities: cubit.cities,
              mandatory: true,
              validator: (value) => RescuerFormValidator.requiredSelection(
                value,
                'شهر محل سکونت',
              ),
              onChanged: (value) => cubit.addressCity = value,
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              labelText: 'آدرس',
              mandatory: true,
              controller: cubit.addressController,
              maxLines: 4,
              validator: (value) =>
                  RescuerFormValidator.requiredText(value, 'آدرس'),
            ),
          ],
        ),
      ),
    );
  }
}
