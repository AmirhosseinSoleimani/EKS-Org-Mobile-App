import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/widgets/deployment_location_area_utils.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeploymentLocationFilterSheet extends StatefulWidget {
  const DeploymentLocationFilterSheet({
    super.key,
    this.initialTitle,
    this.initialProvinceTitle,
    this.initialCityTitle,
    this.initialAddress,
    this.initialIsActive,
    required this.provinceCities,
    required this.isAreasLoading,
    required this.onSubmit,
  });

  final String? initialTitle;
  final String? initialProvinceTitle;
  final String? initialCityTitle;
  final String? initialAddress;
  final bool? initialIsActive;
  final List<ProvinceEntity> provinceCities;
  final bool isAreasLoading;
  final void Function(
    String? title,
    String? provinceTitle,
    String? cityTitle,
    String? address,
    bool? isActive,
  ) onSubmit;

  @override
  State<DeploymentLocationFilterSheet> createState() =>
      _DeploymentLocationFilterSheetState();
}

class _DeploymentLocationFilterSheetState
    extends State<DeploymentLocationFilterSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _addressController;
  ProvinceEntity? _selectedProvince;
  ProvinceEntity? _selectedCity;
  bool? _isActive;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _addressController = TextEditingController(text: widget.initialAddress);
    _syncInitialArea();
    _isActive = widget.initialIsActive;
  }

  @override
  void didUpdateWidget(covariant DeploymentLocationFilterSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.provinceCities.length != widget.provinceCities.length ||
        oldWidget.initialProvinceTitle != widget.initialProvinceTitle ||
        oldWidget.initialCityTitle != widget.initialCityTitle) {
      _syncInitialArea();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provinces = uniqueDeploymentLocationProvinces(
      widget.provinceCities,
    );
    final cities = deploymentLocationCitiesForProvince(
      widget.provinceCities,
      _selectedProvince?.provinceId,
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleMediumText(
                text: 'فیلتر محل استقرار',
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
              Space.h16,
              TextFormFieldWidget(
                controller: _titleController,
                labelText: 'عنوان',
              ),
              Space.h12,
              OverlayDropdownFormField<ProvinceEntity>(
                key: ValueKey(
                  'filter-province-${_selectedProvince?.provinceId}-${provinces.length}',
                ),
                labelText: 'استان',
                items: provinces,
                value: _selectedProvince,
                enabled: provinces.isNotEmpty,
                hintText: widget.isAreasLoading
                    ? 'در حال دریافت...'
                    : 'انتخاب کنید',
                onChanged: (item) {
                  setState(() {
                    _selectedProvince = item;
                    _selectedCity = null;
                  });
                },
              ),
              Space.h12,
              OverlayDropdownFormField<ProvinceEntity>(
                key: ValueKey(
                  'filter-city-${_selectedProvince?.provinceId}-${_selectedCity?.cityId}-${cities.length}',
                ),
                labelText: 'شهر',
                items: cities,
                value: _selectedCity,
                enabled: _selectedProvince != null && cities.isNotEmpty,
                hintText: _selectedProvince == null
                    ? 'ابتدا استان را انتخاب کنید'
                    : 'انتخاب کنید',
                itemTitleBuilder: (item) => item.cityName ?? '',
                onChanged: (item) => setState(() => _selectedCity = item),
              ),
              Space.h12,
              TextFormFieldWidget(
                controller: _addressController,
                labelText: 'آدرس',
                maxLines: 2,
              ),
              Space.h12,
              EkDropDown(
                const ['همه', 'فعال', 'غیرفعال'],
                label: 'وضعیت',
                selectedItem: _statusTitle(_isActive),
                onItemValue: (value) {
                  setState(() => _isActive = _statusValue(value));
                },
              ),
              Space.h20,
              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'اعمال فیلتر',
                      onTap: () {
                        widget.onSubmit(
                          _titleController.text,
                          _selectedProvince?.title,
                          _selectedCity?.cityName,
                          _addressController.text,
                          _isActive,
                        );
                        context.pop();
                      },
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'حذف فیلتر',
                      backgroundColor: theme.colorScheme.onPrimary,
                      borderColor: theme.colorScheme.outline,
                      titleColor: theme.colorScheme.onSurface,
                      onTap: () {
                        widget.onSubmit(null, null, null, null, null);
                        context.pop();
                      },
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

  void _syncInitialArea() {
    _selectedProvince = findDeploymentLocationProvince(
      items: widget.provinceCities,
      provinceTitle: widget.initialProvinceTitle,
    );
    _selectedCity = findDeploymentLocationCity(
      items: widget.provinceCities,
      cityTitle: widget.initialCityTitle,
    );
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
