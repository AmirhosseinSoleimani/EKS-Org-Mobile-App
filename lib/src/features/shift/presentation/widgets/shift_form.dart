import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/use_cases/validate_shift_use_case.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/widgets/shift_dropdown_field.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShiftForm extends StatefulWidget {
  const ShiftForm({
    super.key,
    required this.item,
    required this.shiftTypes,
    required this.isSubmitting,
    required this.onSubmit,
    required this.onCancel,
  });

  final ShiftEntity item;
  final List<CurrentSessionEnumItemEntity> shiftTypes;
  final bool isSubmitting;
  final ValueChanged<ShiftEntity> onSubmit;
  final VoidCallback onCancel;

  @override
  State<ShiftForm> createState() => _ShiftFormState();
}

class _ShiftFormState extends State<ShiftForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  int? _type;
  bool _isActive = true;

  bool get _isNew => widget.item.id == null || widget.item.id == 0;

  @override
  void initState() {
    super.initState();
    _syncControllers(widget.item);
  }

  @override
  void didUpdateWidget(covariant ShiftForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.id != widget.item.id) {
      _syncControllers(widget.item);
    }
  }

  Future<void> _showCupertinoTimePicker(
      TextEditingController controller,
      ) async {
    var selectedTime = _parseDateTime(controller.text) ?? DateTime.now();
    final theme = Theme.of(context);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          top: false,
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1E1E6),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFF2F2F7),
                        foregroundColor: const Color(0xFF6E6E73),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'انتخاب زمان',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1D1D1F),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        initialDateTime: selectedTime,
                        minuteInterval: 1,
                        backgroundColor: Colors.white,
                        onDateTimeChanged: (value) {
                          selectedTime = value;
                        },
                      ),

                      IgnorePointer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _TimePickerUnitLabel(text: 'دقیقه'),
                            const SizedBox(width: 100),
                            _TimePickerUnitLabel(text: 'ساعت'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: () {
                      controller.text = _formatTime(selectedTime);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.check_rounded, size: AppSize.s24,),
                    label: const Text('تأیید زمان'),
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppSize.s16
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DateTime? _parseDateTime(String value) {
    final normalized = _englishDigits(value.trim());
    final parts = normalized.split(':');

    if (parts.length != 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;

    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  String _formatTime(DateTime value) {
    return '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      appBar: SimpleAppBar(
        title: _isNew ? 'ثبت شیفت جدید' : 'ویرایش شیفت',
      ),
      bottomNavigationBar: _ShiftFormActions(
        isNew: _isNew,
        isSubmitting: widget.isSubmitting,
        onSubmit: _submit,
        onCancel: widget.onCancel,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p18,
          AppPadding.p16,
          AppPadding.p24,
        ),
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p16),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(AppSize.s8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(16),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgWidget(
                      src: SvgAsset(SvgManager.swapDriving),
                      width: AppSize.s22,
                      height: AppSize.s22,
                    ),
                    Space.w8,
                    Text(
                      'اطلاعات شیفت',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: AppSize.s16,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                Space.h16,
                ShiftDropdownField<int>(
                  label: 'نوع',
                  value: _type,
                  mandatory: true,
                  items: widget.shiftTypes
                      .where((item) => item.value != null)
                      .map((item) => ShiftDropdownField.item<int>(
                            item.value!,
                            item.title ?? item.name ?? item.value.toString(),
                          ))
                      .toList(),
                  validator: (value) => value == null ? 'نوع الزامی است' : null,
                  onChanged: (value) => setState(() => _type = value),
                ),
                Space.h16,
                TextFormFieldWidget(
                  controller: _titleController,
                  labelText: 'عنوان',
                  mandatory: true,
                  maxLength: ValidateShiftUseCase.titleMaxLength,
                  validator: (value) {
                    final title = value?.trim();
                    if (title == null || title.isEmpty) {
                      return 'عنوان الزامی است';
                    }
                    if (title.length > ValidateShiftUseCase.titleMaxLength) {
                      return 'عنوان باید حداکثر ۳۰ کاراکتر باشد';
                    }
                    return null;
                  },
                ),
                Space.h16,
                TextFormFieldWidget(
                  controller: _startTimeController,
                  labelText: 'زمان شروع',
                  mandatory: true,
                  readOnly: true,
                  maxLength: 5,
                  suffixIcon: const Icon(Icons.schedule_rounded),
                  textInputType: TextInputType.datetime,
                  onTap: () => _showCupertinoTimePicker(_startTimeController),
                  validator: (value) => _timeValidator(value, 'زمان شروع'),
                ),
                Space.h16,
                TextFormFieldWidget(
                  controller: _endTimeController,
                  labelText: 'زمان پایان',
                  mandatory: true,
                  readOnly: true,
                  maxLength: 5,
                  suffixIcon: const Icon(Icons.schedule_rounded),
                  textInputType: TextInputType.datetime,
                  onTap: () => _showCupertinoTimePicker(_endTimeController),
                  validator: (value) => _timeValidator(value, 'زمان پایان'),
                ),
                Space.h16,
                ShiftDropdownField<bool>(
                  label: 'وضعیت',
                  value: _isActive,
                  items: const [
                    DropdownMenuItem(value: true, child: Text('فعال')),
                    DropdownMenuItem(value: false, child: Text('غیرفعال')),
                  ],
                  onChanged: (value) =>
                      setState(() => _isActive = value ?? true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _timeValidator(String? value, String label) {
    final normalized = _englishDigits(value?.trim() ?? '');
    if (normalized.isEmpty) return '$label الزامی است';
    if (!RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$').hasMatch(normalized)) {
      return '$label باید با فرمت HH:mm وارد شود';
    }
    return null;
  }

  void _submit() {
    if (widget.isSubmitting) return;
    if (_formKey.currentState?.validate() != true) return;
    widget.onSubmit(widget.item.copyWith(
      title: _titleController.text.trim(),
      type: _type,
      startTime: _englishDigits(_startTimeController.text.trim()),
      endTime: _englishDigits(_endTimeController.text.trim()),
      isActive: _isActive,
    ));
  }

  void _syncControllers(ShiftEntity item) {
    _titleController.text = item.title ?? '';
    _startTimeController.text = item.startTime ?? item.startTimeStr ?? '';
    _endTimeController.text = item.endTime ?? item.endTimeStr ?? '';
    _type = item.type;
    _isActive = item.isActive;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }
}

class _ShiftFormActions extends StatelessWidget {
  const _ShiftFormActions({
    required this.isNew,
    required this.isSubmitting,
    required this.onSubmit,
    required this.onCancel,
  });

  final bool isNew;
  final bool isSubmitting;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(14),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: InkwellButtonWidget(
                  title: isNew ? 'ثبت' : 'ویرایش',
                  showLoading: isSubmitting,
                  borderRadius: AppSize.s8,
                  onTap: () {
                    if (isSubmitting) return;
                    onSubmit();
                  },
                ),
              ),
              Space.w12,
              Expanded(
                child: InkwellButtonWidget(
                  title: 'انصراف',
                  backgroundColor: theme.colorScheme.onPrimary,
                  titleColor: theme.colorScheme.onSurfaceVariant,
                  borderRadius: AppSize.s8,
                  onTap: () {
                    if (isSubmitting) return;
                    onCancel();
                  },
                ),
              ),
            ],
          ),
        ),
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

class _TimePickerUnitLabel extends StatelessWidget {
  const _TimePickerUnitLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: const Color(0xFF6E6E73),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}