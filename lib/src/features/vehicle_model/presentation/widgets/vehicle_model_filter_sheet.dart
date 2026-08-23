import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_navgan_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class VehicleModelFilterSheet extends StatefulWidget {
  const VehicleModelFilterSheet({
    super.key,
    this.initialCode,
    this.initialName,
    this.initialIsActive,
    this.initialNavganTypeTitle,
    this.initialHasDepot,
    required this.navgans,
    required this.isNavgansLoading,
    required this.onSubmit,
  });

  final String? initialCode;
  final String? initialName;
  final bool? initialIsActive;
  final String? initialNavganTypeTitle;
  final bool? initialHasDepot;
  final List<VehicleNavganEntity> navgans;
  final bool isNavgansLoading;
  final void Function(
    String? code,
    String? name,
    bool? isActive,
    String? navganTypeTitle,
    bool? hasDepot,
  ) onSubmit;

  @override
  State<VehicleModelFilterSheet> createState() =>
      _VehicleModelFilterSheetState();
}

class _VehicleModelFilterSheetState extends State<VehicleModelFilterSheet> {
  late final TextEditingController _codeController;
  late final TextEditingController _nameController;
  VehicleNavganEntity? _selectedNavgan;
  bool? _isActive;
  bool? _hasDepot;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.initialCode);
    _nameController = TextEditingController(text: widget.initialName);
    _selectedNavgan = _initialNavgan(widget.navgans);
    _isActive = widget.initialIsActive;
    _hasDepot = widget.initialHasDepot;
  }

  @override
  void didUpdateWidget(covariant VehicleModelFilterSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_selectedNavgan == null ||
        oldWidget.navgans.length != widget.navgans.length ||
        oldWidget.initialNavganTypeTitle != widget.initialNavganTypeTitle) {
      _selectedNavgan = _initialNavgan(widget.navgans);
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navganItems = <String>['همه', ...widget.navgans.map((item) => item.label)];

    return FilterBottomSheetScaffold(
      title: 'فیلترها',
      onApply: _apply,
      onClear: _clear,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: _codeController,
            labelText: 'کد',
            textInputAction: TextInputAction.next,
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: _nameController,
            labelText: 'نام',
            textInputAction: TextInputAction.next,
          ),
          Space.h12,
          EkDropDown(
            navganItems,
            key: ValueKey(
              'vehicle-model-navgans-${widget.navgans.map((item) => item.id).join('-')}',
            ),
            label: 'نوع ناوگان',
            selectedItem: _selectedNavgan?.label ?? 'همه',
            onItemValue: (value) {
              setState(() {
                _selectedNavgan = value == 'همه' ? null : _findNavgan(value);
              });
            },
          ),
          Space.h12,
          EkDropDown(
            const ['همه', 'فعال', 'غیرفعال'],
            label: 'وضعیت',
            selectedItem: _boolTitle(_isActive),
            onItemValue: (value) => setState(() => _isActive = _boolValue(value)),
          ),
          Space.h12,
          EkDropDown(
            const ['همه', 'دارد', 'ندارد'],
            label: 'مجهز به انبارک',
            selectedItem: _depotTitle(_hasDepot),
            onItemValue: (value) => setState(() => _hasDepot = _depotValue(value)),
          ),
        ],
      ),
    );
  }

  void _apply() {
    widget.onSubmit(
      _normalized(_codeController.text),
      _normalized(_nameController.text),
      _isActive,
      _selectedNavgan?.title,
      _hasDepot,
    );
    Navigator.of(context).pop();
  }

  void _clear() {
    widget.onSubmit(null, null, null, null, null);
    Navigator.of(context).pop();
  }

  String? _normalized(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? null : normalized;
  }

  VehicleNavganEntity? _findNavgan(String label) {
    for (final item in widget.navgans) {
      if (item.label == label) return item;
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

  String _depotTitle(bool? value) {
    if (value == true) return 'دارد';
    if (value == false) return 'ندارد';
    return 'همه';
  }

  bool? _depotValue(String value) {
    if (value == 'دارد') return true;
    if (value == 'ندارد') return false;
    return null;
  }

  VehicleNavganEntity? _initialNavgan(List<VehicleNavganEntity> navgans) {
    final title = widget.initialNavganTypeTitle?.trim();
    if (title?.isNotEmpty != true) return null;
    for (final navgan in navgans) {
      if (navgan.title == title) return navgan;
    }
    return null;
  }
}
