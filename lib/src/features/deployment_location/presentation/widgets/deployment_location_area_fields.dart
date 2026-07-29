import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/widgets/deployment_location_area_utils.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:flutter/material.dart';

class DeploymentLocationAreaFields extends StatelessWidget {
  const DeploymentLocationAreaFields({
    super.key,
    required this.provinceCities,
    required this.selectedProvince,
    required this.selectedCity,
    required this.isLoading,
    required this.onProvinceChanged,
    required this.onCityChanged,
  });

  final List<ProvinceEntity> provinceCities;
  final ProvinceEntity? selectedProvince;
  final ProvinceEntity? selectedCity;
  final bool isLoading;
  final ValueChanged<ProvinceEntity?> onProvinceChanged;
  final ValueChanged<ProvinceEntity?> onCityChanged;

  @override
  Widget build(BuildContext context) {
    final provinces = uniqueDeploymentLocationProvinces(provinceCities);
    final cities = deploymentLocationCitiesForProvince(
      provinceCities,
      selectedProvince?.provinceId,
    );

    return Column(
      children: [
        OverlayDropdownFormField<ProvinceEntity>(
          key: ValueKey(
            'form-province-${selectedProvince?.provinceId}-${provinces.length}',
          ),
          labelText: 'استان',
          mandatory: true,
          items: provinces,
          value: selectedProvince,
          enabled: provinces.isNotEmpty,
          hintText: isLoading ? 'در حال دریافت...' : 'انتخاب کنید',
          validator: (item) =>
              item == null ? 'انتخاب استان الزامی است.' : null,
          onChanged: onProvinceChanged,
        ),
        Space.h16,
        OverlayDropdownFormField<ProvinceEntity>(
          key: ValueKey(
            'form-city-${selectedProvince?.provinceId}-${selectedCity?.cityId}-${cities.length}',
          ),
          labelText: 'شهر',
          mandatory: true,
          items: cities,
          value: selectedCity,
          enabled: selectedProvince != null && cities.isNotEmpty,
          hintText: selectedProvince == null
              ? 'ابتدا استان را انتخاب کنید'
              : 'انتخاب کنید',
          itemTitleBuilder: (item) => item.cityName ?? '',
          validator: (item) =>
              item == null ? 'انتخاب شهر الزامی است.' : null,
          onChanged: onCityChanged,
        ),
      ],
    );
  }
}
