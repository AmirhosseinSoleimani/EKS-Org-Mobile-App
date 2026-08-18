import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
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
    required this.onSubmit,
  });

  final String? initialTitle;
  final String? initialProvinceTitle;
  final String? initialCityTitle;
  final String? initialAddress;
  final bool? initialIsActive;
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
  late final TextEditingController _provinceController;
  late final TextEditingController _cityController;
  late final TextEditingController _addressController;
  bool? _isActive;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _provinceController = TextEditingController(
      text: widget.initialProvinceTitle,
    );
    _cityController = TextEditingController(text: widget.initialCityTitle);
    _addressController = TextEditingController(text: widget.initialAddress);
    _isActive = widget.initialIsActive;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _provinceController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FilterBottomSheetScaffold(
      title: 'فیلترها',
      onApply: _submit,
      onClear: _clear,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: _titleController,
            labelText: 'عنوان',
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: _provinceController,
            labelText: 'استان',
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: _cityController,
            labelText: 'شهر',
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
        ],
      ),
    );
  }

  void _submit() {
    widget.onSubmit(
      _normalizedText(_titleController),
      _normalizedText(_provinceController),
      _normalizedText(_cityController),
      _normalizedText(_addressController),
      _isActive,
    );
    context.pop();
  }

  void _clear() {
    widget.onSubmit(null, null, null, null, null);
    context.pop();
  }

  String? _normalizedText(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
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
