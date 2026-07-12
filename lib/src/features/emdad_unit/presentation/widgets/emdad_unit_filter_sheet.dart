import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/emdad_unit_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class EmdadUnitFilterSheet extends StatefulWidget {
  const EmdadUnitFilterSheet({
    super.key,
    required this.initialFilter,
    required this.onApply,
    required this.onClear,
  });

  final EmdadUnitFilterParamEntity initialFilter;
  final ValueChanged<EmdadUnitFilterParamEntity> onApply;
  final VoidCallback onClear;

  @override
  State<EmdadUnitFilterSheet> createState() => _EmdadUnitFilterSheetState();
}

class _EmdadUnitFilterSheetState extends State<EmdadUnitFilterSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _agencyController;
  late final TextEditingController _vehicleController;
  late final TextEditingController _personController;
  late final TextEditingController _locationController;
  int? _seatType;
  int? _grade;
  bool? _isActive;

  @override
  void initState() {
    super.initState();
    final filter = widget.initialFilter;
    _nameController = TextEditingController(text: filter.name);
    _agencyController = TextEditingController(text: filter.agencyInfoName);
    _vehicleController = TextEditingController(text: filter.vehicleInfoTitle);
    _personController = TextEditingController(text: filter.personInfoFullName);
    _locationController = TextEditingController(text: filter.locationTitle);
    _seatType = filter.seatType;
    _grade = filter.grade;
    _isActive = filter.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p16,
          right: AppPadding.p16,
          top: AppPadding.p16,
          bottom: MediaQuery.viewInsetsOf(context).bottom + AppPadding.p16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('فیلتر واحدهای امدادی', style: Theme.of(context).textTheme.titleMedium),
              Space.h16,
              _TextField(controller: _nameController, label: 'عنوان'),
              _TextField(controller: _agencyController, label: 'نمایندگی'),
              _TextField(controller: _vehicleController, label: 'خودرو'),
              _TextField(controller: _personController, label: 'امدادرسان'),
              _TextField(controller: _locationController, label: 'محل استقرار'),
              DropdownButtonFormField<int?>(
                value: _seatType,
                decoration: const InputDecoration(labelText: 'نوع مقر'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('همه')),
                  DropdownMenuItem(value: 1, child: Text('نوع ۱')),
                  DropdownMenuItem(value: 2, child: Text('نوع ۲')),
                ],
                onChanged: (value) => setState(() => _seatType = value),
              ),
              DropdownButtonFormField<int?>(
                value: _grade,
                decoration: const InputDecoration(labelText: 'گرید'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('همه')),
                  DropdownMenuItem(value: 1, child: Text('۱')),
                  DropdownMenuItem(value: 2, child: Text('۲')),
                  DropdownMenuItem(value: 3, child: Text('۳')),
                  DropdownMenuItem(value: 4, child: Text('۴')),
                  DropdownMenuItem(value: 5, child: Text('۵')),
                ],
                onChanged: (value) => setState(() => _grade = value),
              ),
              DropdownButtonFormField<bool?>(
                value: _isActive,
                decoration: const InputDecoration(labelText: 'وضعیت'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('همه')),
                  DropdownMenuItem(value: true, child: Text('فعال')),
                  DropdownMenuItem(value: false, child: Text('غیرفعال')),
                ],
                onChanged: (value) => setState(() => _isActive = value),
              ),
              Space.h24,
              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'اعمال فیلتر',
                      onTap: _apply,
                    ),
                  ),
                  Space.w12,
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'پاک کردن',
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      borderColor: Theme.of(context).colorScheme.outline,
                      titleColor: Theme.of(context).colorScheme.onSurface,
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

  void _apply() {
    widget.onApply(EmdadUnitFilterParamEntity(
      name: _nameController.text,
      agencyInfoName: _agencyController.text,
      vehicleInfoTitle: _vehicleController.text,
      personInfoFullName: _personController.text,
      locationTitle: _locationController.text,
      seatType: _seatType,
      grade: _grade,
      isActive: _isActive,
    ));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _agencyController.dispose();
    _vehicleController.dispose();
    _personController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}

class _TextField extends StatelessWidget {
  const _TextField({required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
