import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/params/emdad_unit_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
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
  late final TextEditingController _personController;
  late final TextEditingController _agencyController;
  late final TextEditingController _vehicleController;
  late final TextEditingController _locationController;
  int? _seatType;
  int? _grade;

  @override
  void initState() {
    super.initState();
    final filter = widget.initialFilter;
    _nameController = TextEditingController(text: filter.name);
    _personController = TextEditingController(text: filter.personInfoFullName);
    _agencyController = TextEditingController(text: filter.agencyInfoName);
    _vehicleController = TextEditingController(text: filter.vehicleInfoTitle);
    _locationController = TextEditingController(text: filter.locationTitle);
    _seatType = filter.seatType;
    _grade = filter.grade;
  }

  @override
  Widget build(BuildContext context) {
    return FilterBottomSheetScaffold(
      title: 'فیلترها',
      onApply: _apply,
      onClear: _clear,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: _nameController,
            labelText: 'عنوان',
            textInputAction: TextInputAction.next,
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: _personController,
            labelText: 'امدادرسان',
            textInputAction: TextInputAction.next,
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: _agencyController,
            labelText: 'نمایندگی',
            textInputAction: TextInputAction.next,
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: _vehicleController,
            labelText: 'خودرو',
            textInputAction: TextInputAction.next,
          ),
          Space.h12,
          EkDropDown(
            const ['همه', 'نوع ۱', 'نوع ۲'],
            label: 'نوع مقر',
            selectedItem: _seatTypeTitle(_seatType),
            onItemValue: (value) => setState(() => _seatType = _seatTypeValue(value)),
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: _locationController,
            labelText: 'محل استقرار',
            textInputAction: TextInputAction.next,
          ),
          Space.h12,
          EkDropDown(
            const ['همه', '۱', '۲', '۳', '۴', '۵'],
            label: 'گرید',
            selectedItem: _gradeTitle(_grade),
            onItemValue: (value) => setState(() => _grade = _gradeValue(value)),
          ),
        ],
      ),
    );
  }

  void _apply() {
    widget.onApply(
      EmdadUnitFilterParamEntity(
        name: _nameController.text,
        personInfoFullName: _personController.text,
        agencyInfoName: _agencyController.text,
        vehicleInfoTitle: _vehicleController.text,
        locationTitle: _locationController.text,
        seatType: _seatType,
        grade: _grade,
        skip: 0,
      ),
    );
    Navigator.of(context).pop();
  }

  void _clear() {
    widget.onClear();
    Navigator.of(context).pop();
  }

  String _seatTypeTitle(int? value) {
    if (value == 1) return 'نوع ۱';
    if (value == 2) return 'نوع ۲';
    return 'همه';
  }

  int? _seatTypeValue(String value) {
    if (value == 'نوع ۱') return 1;
    if (value == 'نوع ۲') return 2;
    return null;
  }

  String _gradeTitle(int? value) => value?.toString() ?? 'همه';

  int? _gradeValue(String value) => value == 'همه' ? null : int.tryParse(value);

  @override
  void dispose() {
    _nameController.dispose();
    _personController.dispose();
    _agencyController.dispose();
    _vehicleController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
