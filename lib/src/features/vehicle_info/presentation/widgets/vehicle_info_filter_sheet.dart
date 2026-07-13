import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/vehicle_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
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
          bottom: MediaQuery.of(context).viewInsets.bottom + AppPadding.p16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text('فیلتر خودرو', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
              ),
              Space.h16,
              DropdownButtonFormField<int>(
                value: _vehicleModelId,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'نوع خودرو'),
                items: widget.vehicleModels
                    .map((item) => DropdownMenuItem(value: item.id, child: Text(item.title)))
                    .toList(),
                onChanged: (value) => setState(() => _vehicleModelId = value),
              ),
              TextField(controller: _chassisController, decoration: const InputDecoration(labelText: 'شماره شاسی')),
              TextField(controller: _engineController, decoration: const InputDecoration(labelText: 'شماره موتور')),
              TextField(controller: _imeiController, decoration: const InputDecoration(labelText: 'IMEI')),
              TextField(controller: _plateController, decoration: const InputDecoration(labelText: 'پلاک')),
              _BoolDropdown(label: 'انبارک', value: _isDepotEnabled, onChanged: (value) => setState(() => _isDepotEnabled = value)),
              _BoolDropdown(label: 'عیب یاب', value: _isTroubleShooter, onChanged: (value) => setState(() => _isTroubleShooter = value)),
              _BoolDropdown(label: 'وضعیت', value: _isActive, onChanged: (value) => setState(() => _isActive = value)),
              DropdownButtonFormField<int?>(
                value: _tashimType,
                decoration: const InputDecoration(labelText: 'مدل تسهیم انبارک'),
                items: const [
                  DropdownMenuItem<int?>(value: null, child: Text('همه')),
                  DropdownMenuItem<int?>(value: 1, child: Text('براساس نمایندگی')),
                  DropdownMenuItem<int?>(value: 2, child: Text('براساس خودرو')),
                ],
                onChanged: (value) => setState(() => _tashimType = value),
              ),
              Space.h24,
              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'اعمال فیلتر',
                      onTap: () {
                        widget.onApply(VehicleInfoFilterParamEntity(
                          vehicleModelId: _vehicleModelId,
                          isDepotEnabled: _isDepotEnabled,
                          tashimType: _tashimType,
                          chassisNumber: _chassisController.text,
                          engineNumber: _engineController.text,
                          imeiSerial: _imeiController.text,
                          licensePlate: _plateController.text,
                          isTroubleShooter: _isTroubleShooter,
                          isActive: _isActive,
                        ));
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'پاک کردن',
                      backgroundColor: theme.colorScheme.onPrimary,
                      borderColor: theme.colorScheme.outline.withOpacity(0.65),
                      titleColor: theme.colorScheme.onSurface,
                      onTap: () {
                        widget.onClear();
                        Navigator.of(context).pop();
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
