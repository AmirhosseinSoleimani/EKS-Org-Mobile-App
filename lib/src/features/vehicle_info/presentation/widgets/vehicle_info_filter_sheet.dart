import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/vehicle_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/filter_dropdown_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/car_license_plate_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class VehicleInfoFilterSheet extends StatefulWidget {
  const VehicleInfoFilterSheet({
    super.key,
    required this.initialFilter,
    required this.vehicleModels,
    required this.onApply,
    required this.onClear,
  });

  final VehicleInfoFilterParamEntity initialFilter;
  final List<VehicleModelEntity> vehicleModels;
  final ValueChanged<VehicleInfoFilterParamEntity> onApply;
  final VoidCallback onClear;

  @override
  State<VehicleInfoFilterSheet> createState() => _VehicleInfoFilterSheetState();
}

class _VehicleInfoFilterSheetState extends State<VehicleInfoFilterSheet> {
  late final TextEditingController _chassisController;
  late final TextEditingController _engineController;
  late final TextEditingController _imeiController;
  late final TextEditingController _plateController;
  int? _vehicleModelId;
  bool? _isDepotEnabled;
  bool? _isTroubleShooter;
  bool? _isActive;
  int? _tashimType;

  @override
  void initState() {
    super.initState();
    final filter = widget.initialFilter;
    _vehicleModelId = filter.vehicleModelId;
    _isDepotEnabled = filter.isDepotEnabled;
    _isTroubleShooter = filter.isTroubleShooter;
    _isActive = filter.isActive;
    _tashimType = filter.tashimType;
    _chassisController = TextEditingController(text: filter.chassisNumber);
    _engineController = TextEditingController(text: filter.engineNumber);
    _imeiController = TextEditingController(text: filter.imeiSerial);
    _plateController = TextEditingController(text: filter.licensePlate);
  }

  @override
  void dispose() {
    _chassisController.dispose();
    _engineController.dispose();
    _imeiController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p16,
          right: AppPadding.p16,
          top: AppPadding.p16,
          bottom:
          MediaQuery
              .of(context)
              .viewInsets
              .bottom +
              AppPadding.p16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'فیلتر خودرو',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Space.h16,
              FilterDropdownWidget<int>(
                label: 'نوع خودرو',
                value: _vehicleModelId,
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('همه'),
                  ),

                  ...widget.vehicleModels.map(
                        (item) =>
                        DropdownMenuItem(
                          value: item.id,
                          child: Text(item.title),
                        ),
                  ),

                ],
                onChanged: (value) {
                  setState(() {
                    _vehicleModelId = value;
                  });
                },
              ),
              Space.h12,
              TextFormFieldWidget(
                controller: _chassisController,
                labelText: 'شماره شاسی',
              ),
              Space.h12,
              TextFormFieldWidget(
                controller: _engineController,
                labelText: 'شماره موتور',
              ),
              Space.h12,
              TextFormFieldWidget(
                controller: _imeiController,
                labelText: 'IMEI',
              ),
              Space.h12,
              FilterDropdownWidget<bool>(
                label: 'انبارک',
                value: _isDepotEnabled,
                items: const [
                  DropdownMenuItem(
                    value: null,
                    child: Text('همه'),
                  ),
                  DropdownMenuItem(
                    value: true,
                    child: Text('فعال'),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text('غیرفعال'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _isDepotEnabled = value;
                  });
                },
              ),


              Space.h12,


              FilterDropdownWidget<bool>(
                label: 'عیب یاب',
                value: _isTroubleShooter,
                items: const [
                  DropdownMenuItem(
                    value: null,
                    child: Text('همه'),
                  ),
                  DropdownMenuItem(
                    value: true,
                    child: Text('فعال'),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text('غیرفعال'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _isTroubleShooter = value;
                  });
                },
              ),


              Space.h12,


              FilterDropdownWidget<bool>(
                label: 'وضعیت',
                value: _isActive,
                items: const [
                  DropdownMenuItem(
                    value: null,
                    child: Text('همه'),
                  ),
                  DropdownMenuItem(
                    value: true,
                    child: Text('فعال'),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text('غیرفعال'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              Space.h12,
              FilterDropdownWidget<int>(
                label: 'مدل تسهیم انبارک',
                value: _tashimType,
                items: const [
                  DropdownMenuItem(
                    value: null,
                    child: Text('همه'),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text('براساس نمایندگی'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('براساس خودرو'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _tashimType = value;
                  });
                },
              ),
              Space.h24,
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p36,right:
                AppPadding.p36, bottom: AppPadding.p44),
                child: LicensePlateTextFormFieldWidget(controller: _plateController,mandatory: false,),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'اعمال فیلتر',
                      onTap: _applyFilter,
                    ),
                  ),

                  Space.w12,

                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'پاک کردن',
                      backgroundColor:
                      theme.colorScheme.onPrimary,
                      borderColor:
                      theme.colorScheme.outline.withOpacity(.65),
                      titleColor:
                      theme.colorScheme.onSurface,
                      onTap: () {
                        widget.onClear();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Space.h12,
            ],
          ),
        ),
      ),
    );
  }

  void _applyFilter() {
    widget.onApply(
      VehicleInfoFilterParamEntity(
        vehicleModelId: _vehicleModelId,
        isDepotEnabled: _isDepotEnabled,
        tashimType: _tashimType,
        chassisNumber: _chassisController.text,
        engineNumber: _engineController.text,
        imeiSerial: _imeiController.text,
        licensePlate: _plateController.text,
        isTroubleShooter: _isTroubleShooter,
        isActive: _isActive,
      ),
    );

    Navigator.of(context).pop();
  }
}

class _BoolDropdown extends StatelessWidget {
  const _BoolDropdown({required this.label, required this.value, required this.onChanged});
  final String label;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<bool?>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items: const [
        DropdownMenuItem<bool?>(value: null, child: Text('همه')),
        DropdownMenuItem<bool?>(value: true, child: Text('فعال')),
        DropdownMenuItem<bool?>(value: false, child: Text('غیرفعال')),
      ],
      onChanged: onChanged,
    );
  }
}
