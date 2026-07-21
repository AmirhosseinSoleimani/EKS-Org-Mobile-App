import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class JalaliYearPickerWidget extends StatelessWidget {
  const JalaliYearPickerWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText = 'انتخاب سال',
    this.firstYear = 1300,
    this.lastYear,
    this.initialYear,
    this.suffixIcon,
    this.mandatory = false,
    this.validator,
    this.onChanged,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int firstYear;
  final int? lastYear;
  final int? initialYear;
  final Widget? suffixIcon;
  final bool mandatory;
  final String? Function(String?)? validator;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      mandatory: mandatory,
      validator: validator,
      readOnly: true,
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: suffixIcon,
      onTap: () => _pickYear(context),
    );
  }

  Future<void> _pickYear(BuildContext context) async {
    final currentYear = Jalali.now().year;
    final maxYear = lastYear ?? currentYear;
    final selectedYear = int.tryParse(controller.text.trim()) ??
        initialYear ??
        maxYear;

    final year = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: _JalaliYearDialog(
            firstYear: firstYear,
            lastYear: maxYear,
            selectedYear: selectedYear,
          ),
        );
      },
    );

    if (year == null) return;

    controller.text = year.toString();
    onChanged?.call(year);
  }
}

class _JalaliYearDialog extends StatelessWidget {
  const _JalaliYearDialog({
    required this.firstYear,
    required this.lastYear,
    required this.selectedYear,
  });

  final int firstYear;
  final int lastYear;
  final int selectedYear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final years = List<int>.generate(
      lastYear - firstYear + 1,
      (index) => lastYear - index,
      growable: false,
    );

    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(
        AppPadding.p20,
        AppPadding.p20,
        AppPadding.p20,
        AppPadding.p8,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        AppPadding.p12,
        AppPadding.p8,
        AppPadding.p12,
        AppPadding.p16,
      ),
      title: Text(
        'انتخاب سال',
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      content: SizedBox(
        width: 320,
        height: 360,
        child: GridView.builder(
          itemCount: years.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.8,
            mainAxisSpacing: AppSize.s8,
            crossAxisSpacing: AppSize.s8,
          ),
          itemBuilder: (context, index) {
            final year = years[index];
            final isSelected = year == selectedYear;

            return Material(
              color: isSelected
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppSize.s8),
                onTap: () => Navigator.of(context).pop(year),
                child: Center(
                  child: Text(
                    year.toString(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
