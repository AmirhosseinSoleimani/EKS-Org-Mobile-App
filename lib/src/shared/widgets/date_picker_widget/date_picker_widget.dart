import 'dart:async';

import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/font_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/style_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.onTap,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.suffixIcon,
    this.mandatory = false,
    this.validator,
  });

  final TextEditingController controller;
  final Jalali? initialDate;
  final Jalali? firstDate;
  final Jalali? lastDate;
  final Widget? suffixIcon;
  final FutureOr<void> Function(Jalali?)? onTap;
  final String labelText;
  final String hintText;
  final bool mandatory;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormFieldWidget(
      readOnly: true,
      labelText: labelText,
      mandatory: mandatory,
      validator: validator,
      hintStyle: theme.textTheme.displayMedium?.copyWith(
        fontSize: 13,
      ),
      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        fontSize: AppSize.s14,
      ),
      textStyle: theme.textTheme.displayMedium?.copyWith(
        fontSize: 13,
      ),
      controller: controller,
      hintText: hintText,
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      onTap: () => _pickDate(context),
      suffixIcon: suffixIcon,
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showPersianDatePicker(
      locale: const Locale('fa', 'IR'),
      initialEntryMode: PersianDatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: _controllerDate() ?? initialDate ?? Jalali.now(),
      firstDate: firstDate ?? Jalali(1300, 1, 1),
      lastDate: lastDate ?? Jalali.now(),
      initialDatePickerMode: PersianDatePickerMode.day,
      builder: (ctx, child) {
        return Localizations.override(
          context: context,
          locale: const Locale('fa', 'IR'),
          delegates: const [
            PersianMaterialLocalizations.delegate,
            PersianCupertinoLocalizations.delegate,
          ],
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Theme(
              data: _pickerTheme(context),
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );
      },
    );

    if (picked == null) return;

    controller.text = _format(picked);
    await onTap?.call(picked);
  }

  Jalali? _controllerDate() {
    final parts = controller.text.trim().split('/');
    if (parts.length != 3) return null;

    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);
    if (year == null || month == null || day == null) return null;

    try {
      return Jalali(year, month, day);
    } catch (_) {
      return null;
    }
  }

  String _format(Jalali value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '${value.year}/$month/$day';
  }

  ThemeData _pickerTheme(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ThemeData(
      colorScheme: ColorScheme(
        primary: colorScheme.primary,
        brightness: Brightness.light,
        onPrimary: colorScheme.surface,
        secondary: colorScheme.surface,
        onSecondary: colorScheme.surface,
        error: colorScheme.error,
        onError: colorScheme.onError,
        surface: colorScheme.surface,
        onSurface: colorScheme.onSurface,
        primaryContainer: colorScheme.surface,
      ),
      textTheme: TextTheme(
        headlineLarge: getBoldStyle(
          fontSize: AppSize.s24,
          color: ColorLightManager.surface,
        ),
        headlineMedium: getSemiBoldStyle(
          fontSize: AppSize.s24,
          color: ColorLightManager.surface,
        ),
        headlineSmall: getRegularStyle(
          fontSize: AppSize.s24,
          color: ColorLightManager.surface,
        ),
        titleLarge: getBoldStyle(
          fontSize: AppSize.s20,
          color: ColorLightManager.surface,
        ),
        titleMedium: getSemiBoldStyle(
          fontSize: AppSize.s20,
          color: ColorLightManager.surface,
        ),
        titleSmall: getRegularStyle(
          fontSize: AppSize.s20,
          color: ColorLightManager.surface,
        ),
        displayLarge: getBoldStyle(
          fontSize: AppSize.s18,
          color: ColorLightManager.surface,
        ),
        displayMedium: getSemiBoldStyle(
          fontSize: AppSize.s18,
          color: ColorLightManager.surface,
        ),
        displaySmall: getRegularStyle(
          fontSize: AppSize.s18,
          color: ColorLightManager.surface,
        ),
        bodyLarge: getBoldStyle(
          fontSize: AppSize.s16,
          color: ColorLightManager.surface,
        ),
        bodyMedium: getSemiBoldStyle(
          fontSize: AppSize.s16,
          color: ColorLightManager.surface,
        ),
        bodySmall: getRegularStyle(
          fontSize: AppSize.s16,
          color: ColorLightManager.surface,
        ),
        labelLarge: getBoldStyle(
          fontSize: AppSize.s14,
          color: ColorLightManager.surface,
        ),
        labelMedium: getSemiBoldStyle(
          fontSize: AppSize.s14,
          color: ColorLightManager.surface,
        ),
        labelSmall: getRegularStyle(
          fontSize: AppSize.s14,
          color: ColorLightManager.surface,
        ),
      ).apply(fontFamily: FontConstants.fontFamilyPersian),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        shadowColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s12)),
        ),
      ),
    );
  }
}
