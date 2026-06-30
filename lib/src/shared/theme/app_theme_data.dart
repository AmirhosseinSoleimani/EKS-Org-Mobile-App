import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/font_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/style_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';


abstract class AppThemeData {
  ThemeData get materialThemeData;
  ThemeData get cupertinoThemeData;
}

class LightThemeData extends AppThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        primary: ColorLightManager.primary,
        onPrimary: ColorLightManager.onPrimary,

        secondary: ColorLightManager.secondary,
        /// Todo add onSecondary color
        onSecondary: ColorLightManager.secondary,

        error: ColorLightManager.error,
        onError: ColorLightManager.onError,

        surface: ColorLightManager.surface,
        onSurface: ColorLightManager.onSurface,

        tertiary: ColorLightManager.tertiary,
        onTertiary: ColorLightManager.onTertiary,

        outline: ColorLightManager.outline,
        outlineVariant: ColorLightManager.outlineVariant,

        errorContainer: ColorLightManager.errorContainer,

        primaryContainer: ColorLightManager.primaryContainer,
        onPrimaryContainer: ColorLightManager.onPrimaryContainer,

        tertiaryFixed: ColorLightManager.tertiaryFixed,
        onTertiaryFixed: ColorLightManager.onTertiaryFixed,

        primaryFixed: ColorLightManager.primaryFixed,
        onPrimaryFixed: ColorLightManager.onPrimaryFixed,

        inverseSurface: ColorLightManager.inverseSurface,
        onSecondaryFixed: ColorLightManager.onSecondaryFixed,

        surfaceTint: ColorLightManager.surfaceTint,
        onInverseSurface: ColorLightManager.onInverseSurface,

        secondaryFixed: ColorLightManager.secondaryFixed,

        primaryFixedDim: ColorLightManager.primaryFixedDim,

        onPrimaryFixedVariant: ColorLightManager.onPrimaryFixedVariant,
        shadow: ColorLightManager.shadow,

        onSecondaryContainer: ColorLightManager.onSecondaryContainer,
        inversePrimary: ColorLightManager.inversePrimary,
        surfaceBright: ColorLightManager.surfaceBright,
        surfaceContainer: ColorLightManager.surfaceContainer,

        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        headlineLarge: getBoldStyle(fontSize: AppSize.s24, color: ColorLightManager.onSurface),
        headlineMedium: getSemiBoldStyle(fontSize: AppSize.s24, color: ColorLightManager.onSurface),
        headlineSmall: getRegularStyle(fontSize: AppSize.s24, color: ColorLightManager.onSurface),

        titleLarge: getBoldStyle(fontSize: AppSize.s18, color: ColorLightManager.onSurface),
        titleMedium: getSemiBoldStyle(fontSize: AppSize.s18, color: ColorLightManager.onSurface),
        titleSmall: getRegularStyle(fontSize: AppSize.s18, color: ColorLightManager.onSurface),

        displayLarge: getBoldStyle(fontSize: AppSize.s18, color: ColorLightManager.onSurface),
        displayMedium: getSemiBoldStyle(fontSize: AppSize.s18, color: ColorLightManager.onSurface),
        displaySmall: getRegularStyle(fontSize: AppSize.s18, color: ColorLightManager.onSurface),

        bodyLarge: getBoldStyle(fontSize: AppSize.s18, color: ColorLightManager.onSurface),
        bodyMedium: getSemiBoldStyle(fontSize: AppSize.s14, color: ColorLightManager.onSurface),
        bodySmall: getRegularStyle(fontSize: AppSize.s12, color: ColorLightManager.onSurface),
        labelLarge: getBoldStyle(fontSize: AppSize.s18, color: ColorLightManager.onSurface),
        labelMedium: getSemiBoldStyle(fontSize: AppSize.s16, color: ColorLightManager.onSurface),
        labelSmall: getRegularStyle(fontSize: AppSize.s14, color: ColorLightManager.onSurface),
      ).apply(fontFamily: FontConstants.fontFamilyPersian,
      )
  );


  @override
  // TODO: implement cupertinoThemeData
  ThemeData get cupertinoThemeData => throw UnimplementedError();

}

class DarkThemeData extends AppThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontFamily: 'YekanBakhNoEn', package: 'component_library'),
    ),
  );

  @override
  // TODO: implement cupertinoThemeData
  ThemeData get cupertinoThemeData => throw UnimplementedError();
}