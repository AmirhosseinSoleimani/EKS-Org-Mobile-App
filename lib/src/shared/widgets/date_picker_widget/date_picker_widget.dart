import 'dart:async';

import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/font_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/style_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DatePickerWidget extends StatelessWidget {
  final TextEditingController controller;
  final Jalali? initialDate;
  final Jalali? lastDate;
  final Widget? suffixIcon;
  final FutureOr<void> Function(Jalali?)? onTap;
  final String labelText;
  final String hintText;

  const DatePickerWidget({
    super.key,
    this.onTap,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.initialDate,
    this.lastDate,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormFieldWidget(
      readOnly: true,
      labelText: labelText,
      hintStyle: theme.textTheme.displayMedium?.copyWith(fontSize: AppSize.s14, color: theme.colorScheme.inverseSurface),
      labelStyle: theme.textTheme.displayMedium?.copyWith(fontSize: AppSize.s14),
      textStyle: theme.textTheme.displayMedium?.copyWith(fontSize: AppSize.s14),
      controller: controller,
      hintText: hintText,
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
      onTap: () async{
        Jalali? picked = await showPersianDatePicker(
          initialEntryMode: PersianDatePickerEntryMode.calendarOnly,
            context: context,
            initialDate: initialDate ?? Jalali.now(),
            firstDate: Jalali(1300, 1),
            lastDate: lastDate ?? Jalali.now(),
            initialDatePickerMode: PersianDatePickerMode.year,
            builder: (_, child) {
              return Theme(
                data: ThemeData(
                    colorScheme: ColorScheme(
                        primary: Theme.of(context).colorScheme.primary,
                        brightness: Brightness.light,
                        onPrimary: Theme.of(context).colorScheme.surface,
                        secondary: Theme.of(context).colorScheme.surface,
                        onSecondary: Theme.of(context).colorScheme.surface,
                        error: Theme.of(context).colorScheme.error,
                        onError: Theme.of(context).colorScheme.onError,
                        surface: Theme.of(context).colorScheme.surface,
                        onSurface: Theme.of(context).colorScheme.onSurface,
                        primaryContainer: Theme.of(context).colorScheme.surface,
                    ),
                    textTheme: TextTheme(
                      headlineLarge: getBoldStyle(fontSize: AppSize.s24, color: ColorLightManager.surface),
                      headlineMedium: getSemiBoldStyle(fontSize: AppSize.s24, color: ColorLightManager.surface),
                      headlineSmall: getRegularStyle(fontSize: AppSize.s24, color: ColorLightManager.surface),

                      titleLarge: getBoldStyle(fontSize: AppSize.s20, color: ColorLightManager.surface),
                      titleMedium: getSemiBoldStyle(fontSize: AppSize.s20, color: ColorLightManager.surface),
                      titleSmall: getRegularStyle(fontSize: AppSize.s20, color: ColorLightManager.surface),

                      displayLarge: getBoldStyle(fontSize: AppSize.s18, color: ColorLightManager.surface),
                      displayMedium: getSemiBoldStyle(fontSize: AppSize.s18, color: ColorLightManager.surface),
                      displaySmall: getRegularStyle(fontSize: AppSize.s18, color: ColorLightManager.surface),

                      bodyLarge: getBoldStyle(fontSize: AppSize.s16, color: ColorLightManager.surface),
                      bodyMedium: getSemiBoldStyle(fontSize: AppSize.s16, color: ColorLightManager.surface),
                      bodySmall: getRegularStyle(fontSize: AppSize.s16, color: ColorLightManager.surface),

                      labelLarge: getBoldStyle(fontSize: AppSize.s14, color: ColorLightManager.surface),
                      labelMedium: getSemiBoldStyle(fontSize: AppSize.s14, color: ColorLightManager.surface),
                      labelSmall: getRegularStyle(fontSize: AppSize.s14, color: ColorLightManager.surface),
                    ).apply(fontFamily: FontConstants.fontFamilyPersian,
                    ),
                    dialogTheme: DialogThemeData(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      shadowColor:Theme.of(context).colorScheme.surface,
                      surfaceTintColor: Theme.of(context).colorScheme.surface,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppSize.s12),
                        ),
                      ),
                    )
                ),
                child: child ?? const SizedBox.shrink(),
              );
            });
        if (picked != null) {
          controller.text = '${picked.year}/${picked.month}/${picked.day}';
          if (onTap != null) {
            await onTap!(picked);
          }
        }
      },
      suffixIcon: suffixIcon,
    );
  }
}
