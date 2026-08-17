import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DateDropdown extends StatefulWidget {
  final Offset position;
  final double width;
  final VoidCallback onDismiss;
  final void Function(Jalali? from, Jalali? to) onApply;
  final Jalali? initialFromDate;
  final Jalali? initialToDate;
  final bool requireDateRange;

  const DateDropdown({
    super.key,
    required this.position,
    required this.width,
    required this.onDismiss,
    required this.onApply,
    this.initialFromDate,
    this.initialToDate,
    this.requireDateRange = false,
  });

  @override
  State<DateDropdown> createState() => _DateDropdownState();
}

class _DateDropdownState extends State<DateDropdown> {
  final _formKey = GlobalKey<FormState>();

  late final _fromController = TextEditingController(
    text: widget.initialFromDate != null
        ? _formatDate(widget.initialFromDate!)
        : '',
  );
  late final _toController = TextEditingController(
    text: widget.initialToDate != null
        ? _formatDate(widget.initialToDate!)
        : '',
  );
  late Jalali? _fromDate = widget.initialFromDate;
  late Jalali? _toDate = widget.initialToDate;

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onDismiss,
          behavior: HitTestBehavior.translucent,
          child: const SizedBox.expand(),
        ),
        Positioned(
          top: widget.position.dy + AppSize.s40,
          left: widget.position.dx - 50,
          width: widget.width,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(AppSize.s8),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DatePickerWidget(
                      controller: _fromController,
                      labelText: 'از تاریخ',
                      hintText: 'انتخاب تاریخ',
                      initialDate: _fromDate,
                      lastDate: _toDate,
                      mandatory: widget.requireDateRange,
                      validator: widget.requireDateRange
                          ? _requiredDateValidator
                          : null,
                      onTap: (picked) => _fromDate = picked,
                    ),
                    Space.h8,
                    DatePickerWidget(
                      controller: _toController,
                      labelText: 'تا تاریخ',
                      hintText: 'انتخاب تاریخ',
                      initialDate: _toDate,
                      mandatory: widget.requireDateRange,
                      validator: widget.requireDateRange
                          ? _requiredDateValidator
                          : null,
                      onTap: (picked) => _toDate = picked,
                    ),
                    Space.h12,
                    SizedBox(
                      width: double.infinity,
                      child: InkwellButtonWidget(
                        title: 'اعمال فیلتر',
                        onTap: () {
                          if (widget.requireDateRange &&
                              !(_formKey.currentState?.validate() ?? false)) {
                            return;
                          }

                          widget.onApply(_fromDate, _toDate);
                          widget.onDismiss();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String? _requiredDateValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'وارد کردن تاریخ الزامی است';
  }

  return null;
}

String _formatDate(Jalali value) {
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');

  return '${value.year}/$month/$day';
}
