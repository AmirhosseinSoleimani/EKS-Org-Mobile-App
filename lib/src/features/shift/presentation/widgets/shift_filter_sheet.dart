import 'package:eks_sana_plus_org/src/features/shift/domain/entities/params/shift_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShiftFilterSheet extends StatefulWidget {
  const ShiftFilterSheet({
    super.key,
    required this.initialFilter,
    required this.shiftTypes,
    required this.onApply,
    required this.onClear,
  });

  final ShiftFilterParamEntity initialFilter;
  final List<CurrentSessionEnumItemEntity> shiftTypes;
  final ValueChanged<ShiftFilterParamEntity> onApply;
  final VoidCallback onClear;

  @override
  State<ShiftFilterSheet> createState() => _ShiftFilterSheetState();
}

class _ShiftFilterSheetState extends State<ShiftFilterSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _startTimeController;
  late final TextEditingController _endTimeController;
  int? _type;

  @override
  void initState() {
    super.initState();
    final filter = widget.initialFilter;
    _titleController = TextEditingController(text: filter.title);
    _startTimeController = TextEditingController(text: filter.startTime);
    _endTimeController = TextEditingController(text: filter.endTime);
    _type = filter.type;
  }

  @override
  Widget build(BuildContext context) {
    final typeItems = widget.shiftTypes.where((item) => item.value != null).toList();

    return FilterBottomSheetScaffold(
      title: 'فیلترها',
      onApply: _apply,
      onClear: _clear,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: _titleController,
            labelText: 'عنوان',
            textInputAction: TextInputAction.next,
            maxLength: 30,
          ),
          Space.h12,
          EkDropDown(
            ['همه', ...typeItems.map(_typeLabel)],
            label: 'نوع',
            selectedItem: _selectedTypeLabel(typeItems),
            onItemValue: (value) {
              setState(() {
                _type = value == 'همه' ? null : _typeValue(typeItems, value);
              });
            },
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: _startTimeController,
            labelText: 'از ساعت',
            textInputAction: TextInputAction.next,
            maxLength: 5,
            textInputFormatter: [_TimeInputFormatter()],
          ),
          Space.h12,
          TextFormFieldWidget(
            controller: _endTimeController,
            labelText: 'تا ساعت',
            textInputAction: TextInputAction.done,
            maxLength: 5,
            textInputFormatter: [_TimeInputFormatter()],
          ),
        ],
      ),
    );
  }

  void _apply() {
    widget.onApply(
      ShiftFilterParamEntity(
        title: _titleController.text,
        type: _type,
        startTime: _startTimeController.text,
        endTime: _endTimeController.text,
        skip: 0,
      ),
    );
    Navigator.of(context).pop();
  }

  void _clear() {
    widget.onClear();
    Navigator.of(context).pop();
  }

  String _typeLabel(CurrentSessionEnumItemEntity item) {
    return item.title ?? item.name ?? item.value.toString();
  }

  String _selectedTypeLabel(List<CurrentSessionEnumItemEntity> items) {
    if (_type == null) return 'همه';
    for (final item in items) {
      if (item.value == _type) return _typeLabel(item);
    }
    return 'همه';
  }

  int? _typeValue(List<CurrentSessionEnumItemEntity> items, String label) {
    for (final item in items) {
      if (_typeLabel(item) == label) return item.value;
    }
    return null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }
}

class _TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final normalized = _englishDigits(newValue.text)
        .replaceAll(RegExp(r'[^0-9:]'), '');
    if (normalized.length > 5) return oldValue;
    return newValue.copyWith(
      text: normalized,
      selection: TextSelection.collapsed(offset: normalized.length),
    );
  }

  String _englishDigits(String value) {
    const persian = '۰۱۲۳۴۵۶۷۸۹';
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    var result = value;
    for (var i = 0; i < 10; i++) {
      result = result.replaceAll(persian[i], '$i').replaceAll(arabic[i], '$i');
    }
    return result;
  }
}
