import 'package:eks_sana_plus_org/src/shared/theme/app_semantic_colors.dart';
import 'package:flutter/material.dart';

enum EmdadgarInvoiceStatusType {
  initial,
  evaluated,
  approved,
  finalized,
  unknown;

  static EmdadgarInvoiceStatusType resolve({
    required int? status,
    required String? title,
  }) {
    final byCode = switch (status) {
      0 => EmdadgarInvoiceStatusType.initial,
      1 => EmdadgarInvoiceStatusType.evaluated,
      2 => EmdadgarInvoiceStatusType.approved,
      3 => EmdadgarInvoiceStatusType.finalized,
      _ => null,
    };
    if (byCode != null) return byCode;

    final normalizedTitle = title?.trim() ?? '';
    if (normalizedTitle.contains('نهایی')) {
      return EmdadgarInvoiceStatusType.finalized;
    }
    if (normalizedTitle.contains('تایید')) {
      return EmdadgarInvoiceStatusType.approved;
    }
    if (normalizedTitle.contains('ارزیابی')) {
      return EmdadgarInvoiceStatusType.evaluated;
    }
    if (normalizedTitle.contains('اولیه')) {
      return EmdadgarInvoiceStatusType.initial;
    }

    return EmdadgarInvoiceStatusType.unknown;
  }

  EmdadgarInvoiceStatusPalette palette({
    required AppSemanticColors semanticColors,
    required ColorScheme colorScheme,
  }) {
    return switch (this) {
      EmdadgarInvoiceStatusType.initial => EmdadgarInvoiceStatusPalette(
          textColor: semanticColors.invoiceStatusInitialText,
          backgroundColor: semanticColors.invoiceStatusInitialBackground,
        ),
      EmdadgarInvoiceStatusType.evaluated => EmdadgarInvoiceStatusPalette(
          textColor: semanticColors.invoiceStatusEvaluatedText,
          backgroundColor: semanticColors.invoiceStatusEvaluatedBackground,
        ),
      EmdadgarInvoiceStatusType.approved => EmdadgarInvoiceStatusPalette(
          textColor: semanticColors.invoiceStatusApprovedText,
          backgroundColor: semanticColors.invoiceStatusApprovedBackground,
        ),
      EmdadgarInvoiceStatusType.finalized => EmdadgarInvoiceStatusPalette(
          textColor: semanticColors.invoiceStatusFinalizedText,
          backgroundColor: semanticColors.invoiceStatusFinalizedBackground,
        ),
      EmdadgarInvoiceStatusType.unknown => EmdadgarInvoiceStatusPalette(
          textColor: colorScheme.secondary,
          backgroundColor: colorScheme.surfaceContainer,
        ),
    };
  }
}

class EmdadgarInvoiceStatusPalette {
  const EmdadgarInvoiceStatusPalette({
    required this.textColor,
    required this.backgroundColor,
  });

  final Color textColor;
  final Color backgroundColor;
}
