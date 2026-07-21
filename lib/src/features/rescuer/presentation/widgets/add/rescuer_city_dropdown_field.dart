import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:flutter/material.dart';

class RescuerCityDropdownField extends StatelessWidget {
  const RescuerCityDropdownField({
    super.key,
    required this.label,
    required this.cities,
    required this.onChanged,
    this.value,
    this.mandatory = false,
    this.validator,
  });

  final String label;
  final ProvinceEntity? value;
  final List<ProvinceEntity> cities;
  final ValueChanged<ProvinceEntity?> onChanged;
  final bool mandatory;
  final FormFieldValidator<ProvinceEntity>? validator;

  @override
  Widget build(BuildContext context) {
    return OverlayDropdownFormField<ProvinceEntity>(
      labelText: label,
      value: value,
      items: cities,
      mandatory: mandatory,
      validator: validator,
      itemTitleBuilder: (item) => item.cityName ?? item.title ?? '-',
      onChanged: onChanged,
    );
  }
}
