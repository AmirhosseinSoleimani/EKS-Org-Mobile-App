import 'package:eks_sana_plus_org/src/features/shift/domain/entities/params/shift_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/widgets/shift_dropdown_field.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
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
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p20,
          right: AppPadding.p20,
          top: AppPadding.p8,
          bottom: MediaQuery.viewInsetsOf(context).bottom + AppPadding.p16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: AppSize.s48,
                  height: AppSize.s4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                ),
              ),
              Space.h24,
              Text(
                'جستجو و فیلتر',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Space.h24,
              _TextField(controller: _titleController, label: 'عنوان'),
              Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p18),
                child: ShiftDropdownField<int>(
                  label: 'نوع',
                  value: _type,
                  items: widget.shiftTypes
                      .where((item) => item.value != null)
                      .map((item) => ShiftDropdownField.item<int>(
                            item.value!,
                            item.title ?? item.name ?? item.value.toString(),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _type = value),
                ),
              ),
              _TextField(
                controller: _startTimeController,
                label: 'از ساعت',
                inputFormatters: [_TimeInputFormatter()],
              ),
              _TextField(
                controller: _endTimeController,
                label: 'تا ساعت',
                inputFormatters: [_TimeInputFormatter()],
              ),
              Space.h8,
              Row(
                children: [
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'اعمال فیلتر',
                      onTap: _apply,
                    ),
                  ),
                  Space.w16,
                  Expanded(
                    child: InkwellButtonWidget(
                      title: 'پاک کردن همه',
                      backgroundColor: theme.colorScheme.onPrimary,
                      borderColor: theme.colorScheme.outline.withOpacity(0.65),
                      titleColor: theme.colorScheme.onSurface,
                      onTap: _clear,
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
    widget.onApply(ShiftFilterParamEntity(
      title: _titleController.text,
      type: _type,
      startTime: _startTimeController.text,
      endTime: _endTimeController.text,
      skip: 0,
    ));
    Navigator.of(context).pop();
  }

  void _clear() {
    widget.onClear();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.label,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String label;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p18),
      child: TextFormFieldWidget(
        controller: controller,
        textInputAction: TextInputAction.next,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        borderRadius: AppSize.s8,
        maxLength: label == 'عنوان' ? 30 : 5,
        textInputFormatter: inputFormatters,
      ),
    );
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
