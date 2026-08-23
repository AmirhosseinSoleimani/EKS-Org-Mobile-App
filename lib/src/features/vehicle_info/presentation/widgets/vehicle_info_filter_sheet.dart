import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/vehicle_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/car_license_plate_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
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
    return FilterBottomSheetScaffold(
      title: 'فیلترها',
      onApply: _applyFilter,
      onClear: _clear,
      child: Column(
        children: [
          EkDropDown(
            ['همه', ...widget.vehicleModels.map((item) => item.title)],
            label: 'نوع خودرو',
            selectedItem: _vehicleModelTitle(_vehicleModelId),
            onItemValue: (value) {
              setState(() => _vehicleModelId = _vehicleModelValue(value));
            },
          ),
          FilterBottomSheetScaffold.fieldGap,
          TextFormFieldWidget(
            controller: _chassisController,
            labelText: 'شماره شاسی',
            textInputAction: TextInputAction.next,
          ),
          FilterBottomSheetScaffold.fieldGap,
          TextFormFieldWidget(
            controller: _engineController,
            labelText: 'شماره موتور',
            textInputAction: TextInputAction.next,
          ),
          FilterBottomSheetScaffold.fieldGap,
          TextFormFieldWidget(
            controller: _imeiController,
            labelText: 'IMEI',
            textInputAction: TextInputAction.next,
          ),
          FilterBottomSheetScaffold.fieldGap,
          EkDropDown(
            const ['همه', 'فعال', 'غیرفعال'],
            label: 'انبارک',
            selectedItem: _boolTitle(_isDepotEnabled),
            onItemValue: (value) =>
                setState(() => _isDepotEnabled = _boolValue(value)),
          ),
          FilterBottomSheetScaffold.fieldGap,
          EkDropDown(
            const ['همه', 'فعال', 'غیرفعال'],
            label: 'عیب یاب',
            selectedItem: _boolTitle(_isTroubleShooter),
            onItemValue: (value) =>
                setState(() => _isTroubleShooter = _boolValue(value)),
          ),
          FilterBottomSheetScaffold.fieldGap,
          EkDropDown(
            const ['همه', 'فعال', 'غیرفعال'],
            label: 'وضعیت',
            selectedItem: _boolTitle(_isActive),
            onItemValue: (value) => setState(() => _isActive = _boolValue(value)),
          ),
          FilterBottomSheetScaffold.fieldGap,
          EkDropDown(
            const ['همه', 'براساس نمایندگی', 'براساس خودرو'],
            label: 'مدل تسهیم انبارک',
            selectedItem: _tashimTitle(_tashimType),
            onItemValue: (value) =>
                setState(() => _tashimType = _tashimValue(value)),
          ),
          FilterBottomSheetScaffold.fieldGap,
          LicensePlateTextFormFieldWidget(
            controller: _plateController,
            mandatory: false,
          ),
        ],
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

  void _clear() {
    widget.onClear();
    Navigator.of(context).pop();
  }

  String _vehicleModelTitle(int? id) {
    if (id == null) return 'همه';
    for (final item in widget.vehicleModels) {
      if (item.id == id) return item.title;
    }
    return 'همه';
  }

  int? _vehicleModelValue(String title) {
    if (title == 'همه') return null;
    for (final item in widget.vehicleModels) {
      if (item.title == title) return item.id;
    }
    return null;
  }

  String _boolTitle(bool? value) {
    if (value == true) return 'فعال';
    if (value == false) return 'غیرفعال';
    return 'همه';
  }

  bool? _boolValue(String value) {
    if (value == 'فعال') return true;
    if (value == 'غیرفعال') return false;
    return null;
  }

  String _tashimTitle(int? value) {
    if (value == 1) return 'براساس نمایندگی';
    if (value == 2) return 'براساس خودرو';
    return 'همه';
  }

  int? _tashimValue(String value) {
    if (value == 'براساس نمایندگی') return 1;
    if (value == 'براساس خودرو') return 2;
    return null;
  }
}
