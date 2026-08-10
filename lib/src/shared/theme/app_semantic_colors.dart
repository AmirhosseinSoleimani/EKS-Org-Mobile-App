import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:flutter/material.dart';

@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.confirmation,
    required this.invoiceStatusInitialText,
    required this.invoiceStatusInitialBackground,
    required this.invoiceStatusEvaluatedText,
    required this.invoiceStatusEvaluatedBackground,
    required this.invoiceStatusApprovedText,
    required this.invoiceStatusApprovedBackground,
    required this.invoiceStatusFinalizedText,
    required this.invoiceStatusFinalizedBackground,
    required this.agencyCorrectionStatusRegisteredText,
    required this.agencyCorrectionStatusRegisteredBackground,
    required this.agencyCorrectionStatusApprovedText,
    required this.agencyCorrectionStatusApprovedBackground,
    required this.agencyCorrectionStatusCancelledText,
    required this.agencyCorrectionStatusCancelledBackground,
  });

  static const light = AppSemanticColors(
    confirmation: ColorLightManager.confirmation,
    invoiceStatusInitialText: ColorLightManager.invoiceStatusInitialText,
    invoiceStatusInitialBackground:
        ColorLightManager.invoiceStatusInitialBackground,
    invoiceStatusEvaluatedText: ColorLightManager.invoiceStatusEvaluatedText,
    invoiceStatusEvaluatedBackground:
        ColorLightManager.invoiceStatusEvaluatedBackground,
    invoiceStatusApprovedText: ColorLightManager.invoiceStatusApprovedText,
    invoiceStatusApprovedBackground:
        ColorLightManager.invoiceStatusApprovedBackground,
    invoiceStatusFinalizedText: ColorLightManager.invoiceStatusFinalizedText,
    invoiceStatusFinalizedBackground:
        ColorLightManager.invoiceStatusFinalizedBackground,
    agencyCorrectionStatusRegisteredText:
        ColorLightManager.agencyCorrectionStatusRegisteredText,
    agencyCorrectionStatusRegisteredBackground:
        ColorLightManager.agencyCorrectionStatusRegisteredBackground,
    agencyCorrectionStatusApprovedText:
        ColorLightManager.agencyCorrectionStatusApprovedText,
    agencyCorrectionStatusApprovedBackground:
        ColorLightManager.agencyCorrectionStatusApprovedBackground,
    agencyCorrectionStatusCancelledText:
        ColorLightManager.agencyCorrectionStatusCancelledText,
    agencyCorrectionStatusCancelledBackground:
        ColorLightManager.agencyCorrectionStatusCancelledBackground,
  );

  final Color confirmation;

  final Color invoiceStatusInitialText;
  final Color invoiceStatusInitialBackground;

  final Color invoiceStatusEvaluatedText;
  final Color invoiceStatusEvaluatedBackground;

  final Color invoiceStatusApprovedText;
  final Color invoiceStatusApprovedBackground;

  final Color invoiceStatusFinalizedText;
  final Color invoiceStatusFinalizedBackground;

  final Color agencyCorrectionStatusRegisteredText;
  final Color agencyCorrectionStatusRegisteredBackground;

  final Color agencyCorrectionStatusApprovedText;
  final Color agencyCorrectionStatusApprovedBackground;

  final Color agencyCorrectionStatusCancelledText;
  final Color agencyCorrectionStatusCancelledBackground;

  @override
  AppSemanticColors copyWith({
    Color? confirmation,
    Color? invoiceStatusInitialText,
    Color? invoiceStatusInitialBackground,
    Color? invoiceStatusEvaluatedText,
    Color? invoiceStatusEvaluatedBackground,
    Color? invoiceStatusApprovedText,
    Color? invoiceStatusApprovedBackground,
    Color? invoiceStatusFinalizedText,
    Color? invoiceStatusFinalizedBackground,
    Color? agencyCorrectionStatusRegisteredText,
    Color? agencyCorrectionStatusRegisteredBackground,
    Color? agencyCorrectionStatusApprovedText,
    Color? agencyCorrectionStatusApprovedBackground,
    Color? agencyCorrectionStatusCancelledText,
    Color? agencyCorrectionStatusCancelledBackground,
  }) {
    return AppSemanticColors(
      confirmation: confirmation ?? this.confirmation,
      invoiceStatusInitialText:
          invoiceStatusInitialText ?? this.invoiceStatusInitialText,
      invoiceStatusInitialBackground:
          invoiceStatusInitialBackground ?? this.invoiceStatusInitialBackground,
      invoiceStatusEvaluatedText:
          invoiceStatusEvaluatedText ?? this.invoiceStatusEvaluatedText,
      invoiceStatusEvaluatedBackground: invoiceStatusEvaluatedBackground ??
          this.invoiceStatusEvaluatedBackground,
      invoiceStatusApprovedText:
          invoiceStatusApprovedText ?? this.invoiceStatusApprovedText,
      invoiceStatusApprovedBackground: invoiceStatusApprovedBackground ??
          this.invoiceStatusApprovedBackground,
      invoiceStatusFinalizedText:
          invoiceStatusFinalizedText ?? this.invoiceStatusFinalizedText,
      invoiceStatusFinalizedBackground: invoiceStatusFinalizedBackground ??
          this.invoiceStatusFinalizedBackground,
      agencyCorrectionStatusRegisteredText:
          agencyCorrectionStatusRegisteredText ??
              this.agencyCorrectionStatusRegisteredText,
      agencyCorrectionStatusRegisteredBackground:
          agencyCorrectionStatusRegisteredBackground ??
              this.agencyCorrectionStatusRegisteredBackground,
      agencyCorrectionStatusApprovedText: agencyCorrectionStatusApprovedText ??
          this.agencyCorrectionStatusApprovedText,
      agencyCorrectionStatusApprovedBackground:
          agencyCorrectionStatusApprovedBackground ??
              this.agencyCorrectionStatusApprovedBackground,
      agencyCorrectionStatusCancelledText:
          agencyCorrectionStatusCancelledText ??
              this.agencyCorrectionStatusCancelledText,
      agencyCorrectionStatusCancelledBackground:
          agencyCorrectionStatusCancelledBackground ??
              this.agencyCorrectionStatusCancelledBackground,
    );
  }

  @override
  AppSemanticColors lerp(
    covariant AppSemanticColors? other,
    double t,
  ) {
    if (other is! AppSemanticColors) return this;

    return AppSemanticColors(
      confirmation: Color.lerp(confirmation, other.confirmation, t)!,
      invoiceStatusInitialText: Color.lerp(
        invoiceStatusInitialText,
        other.invoiceStatusInitialText,
        t,
      )!,
      invoiceStatusInitialBackground: Color.lerp(
        invoiceStatusInitialBackground,
        other.invoiceStatusInitialBackground,
        t,
      )!,
      invoiceStatusEvaluatedText: Color.lerp(
        invoiceStatusEvaluatedText,
        other.invoiceStatusEvaluatedText,
        t,
      )!,
      invoiceStatusEvaluatedBackground: Color.lerp(
        invoiceStatusEvaluatedBackground,
        other.invoiceStatusEvaluatedBackground,
        t,
      )!,
      invoiceStatusApprovedText: Color.lerp(
        invoiceStatusApprovedText,
        other.invoiceStatusApprovedText,
        t,
      )!,
      invoiceStatusApprovedBackground: Color.lerp(
        invoiceStatusApprovedBackground,
        other.invoiceStatusApprovedBackground,
        t,
      )!,
      invoiceStatusFinalizedText: Color.lerp(
        invoiceStatusFinalizedText,
        other.invoiceStatusFinalizedText,
        t,
      )!,
      invoiceStatusFinalizedBackground: Color.lerp(
        invoiceStatusFinalizedBackground,
        other.invoiceStatusFinalizedBackground,
        t,
      )!,
      agencyCorrectionStatusRegisteredText: Color.lerp(
        agencyCorrectionStatusRegisteredText,
        other.agencyCorrectionStatusRegisteredText,
        t,
      )!,
      agencyCorrectionStatusRegisteredBackground: Color.lerp(
        agencyCorrectionStatusRegisteredBackground,
        other.agencyCorrectionStatusRegisteredBackground,
        t,
      )!,
      agencyCorrectionStatusApprovedText: Color.lerp(
        agencyCorrectionStatusApprovedText,
        other.agencyCorrectionStatusApprovedText,
        t,
      )!,
      agencyCorrectionStatusApprovedBackground: Color.lerp(
        agencyCorrectionStatusApprovedBackground,
        other.agencyCorrectionStatusApprovedBackground,
        t,
      )!,
      agencyCorrectionStatusCancelledText: Color.lerp(
        agencyCorrectionStatusCancelledText,
        other.agencyCorrectionStatusCancelledText,
        t,
      )!,
      agencyCorrectionStatusCancelledBackground: Color.lerp(
        agencyCorrectionStatusCancelledBackground,
        other.agencyCorrectionStatusCancelledBackground,
        t,
      )!,
    );
  }
}
