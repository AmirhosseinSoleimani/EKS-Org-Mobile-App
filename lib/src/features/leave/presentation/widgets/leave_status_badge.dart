import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_status.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:flutter/material.dart';

class LeaveStatusBadge extends StatelessWidget {
  const LeaveStatusBadge({
    super.key,
    required this.statusCode,
    required this.title,
  });

  final int? statusCode;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final status = LeaveStatus.fromCode(statusCode);
    final colors = _colors(status);
    return StatusLabel(
      text: title
          ?.trim()
          .isNotEmpty == true ? title! : _fallbackTitle(status),
      color: colors.foreground,
      backgroundColor: colors.background,);
  }

  _BadgeColors _colors(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.accepted:
        return const _BadgeColors(
          background: Color(0xFFEAFBF4),
          foreground: Color(0xFF00966D),
        );
      case LeaveStatus.rejected:
        return const _BadgeColors(
          background: Color(0xFFFFF0F0),
          foreground: Color(0xFFE00000),
        );
      case LeaveStatus.registered:
      case LeaveStatus.all:
        return const _BadgeColors(
          background: Color(0xFFEDEDED),
          foreground: Color(0xFF666666),
        );
    }
  }

  String _fallbackTitle(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.accepted:
        return 'تایید شده';
      case LeaveStatus.rejected:
        return 'رد شده';
      case LeaveStatus.registered:
      case LeaveStatus.all:
        return 'ثبت شده';
    }
  }
}

class _BadgeColors {
  const _BadgeColors({
    required this.background,
    required this.foreground,
  });

  final Color background;
  final Color foreground;
}

