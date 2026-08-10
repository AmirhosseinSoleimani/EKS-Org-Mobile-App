import 'package:eks_sana_plus_org/src/shared/theme/app_semantic_colors.dart';
import 'package:flutter/material.dart';

enum AgencyCorrectionRequestStatusType {
  registered,
  approved,
  cancelled,
  unknown;

  static AgencyCorrectionRequestStatusType resolve({
    required int? status,
    required String? title,
  }) {
    final byCode = switch (status) {
      0 => AgencyCorrectionRequestStatusType.registered,
      1 => AgencyCorrectionRequestStatusType.approved,
      2 => AgencyCorrectionRequestStatusType.cancelled,
      _ => null,
    };
    if (byCode != null) return byCode;

    final normalizedTitle = title?.trim() ?? '';
    if (normalizedTitle.contains('لغو') || normalizedTitle.contains('رد')) {
      return AgencyCorrectionRequestStatusType.cancelled;
    }
    if (normalizedTitle.contains('تایید')) {
      return AgencyCorrectionRequestStatusType.approved;
    }
    if (normalizedTitle.contains('ثبت')) {
      return AgencyCorrectionRequestStatusType.registered;
    }

    return AgencyCorrectionRequestStatusType.unknown;
  }

  AgencyCorrectionRequestStatusPalette palette({
    required AppSemanticColors semanticColors,
    required ColorScheme colorScheme,
  }) {
    return switch (this) {
      AgencyCorrectionRequestStatusType.registered =>
        AgencyCorrectionRequestStatusPalette(
          textColor: semanticColors.agencyCorrectionStatusRegisteredText,
          backgroundColor:
              semanticColors.agencyCorrectionStatusRegisteredBackground,
        ),
      AgencyCorrectionRequestStatusType.approved =>
        AgencyCorrectionRequestStatusPalette(
          textColor: semanticColors.agencyCorrectionStatusApprovedText,
          backgroundColor:
              semanticColors.agencyCorrectionStatusApprovedBackground,
        ),
      AgencyCorrectionRequestStatusType.cancelled =>
        AgencyCorrectionRequestStatusPalette(
          textColor: semanticColors.agencyCorrectionStatusCancelledText,
          backgroundColor:
              semanticColors.agencyCorrectionStatusCancelledBackground,
        ),
      AgencyCorrectionRequestStatusType.unknown =>
        AgencyCorrectionRequestStatusPalette(
          textColor: colorScheme.onPrimaryFixed,
          backgroundColor: colorScheme.secondaryContainer,
        ),
    };
  }
}

class AgencyCorrectionRequestStatusPalette {
  const AgencyCorrectionRequestStatusPalette({
    required this.textColor,
    required this.backgroundColor,
  });

  final Color textColor;
  final Color backgroundColor;
}
