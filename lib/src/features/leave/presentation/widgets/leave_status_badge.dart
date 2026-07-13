import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_status.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12, vertical: AppPadding.p6),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      child: Text(
        title?.trim().isNotEmpty == true ? title! : _fallbackTitle(status),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colors.foreground,
              fontSize: AppSize.s14,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
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

