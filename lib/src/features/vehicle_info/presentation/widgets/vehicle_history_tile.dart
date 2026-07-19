import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_history_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class VehicleHistoryTile extends StatelessWidget {
  const VehicleHistoryTile({
    super.key,
    required this.history,
  });

  final VehicleHistoryEntity history;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE4E4E4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BodySmallText(
                text: _formatDateTime(history.insertDateTimeJalali),
                textDirection: TextDirection.ltr,
                color: const Color(0xFF777777),
                fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              BodySmallText(
                text: 'ثبت کننده',
                color: const Color(0xFF777777),
                fontWeight: FontWeight.w600,
              ),
              Space.w4,
              BodySmallText(
                text: _dash(history.insertUserName),
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ],
          ),
          Space.h12,
          BodyMediumText(
            text: _dash(history.description),
            color: const Color(0xFF202020),
            fontWeight: FontWeight.w600,
            lineHeight: 1.7,
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String? value) {
    final text = value?.trim();
    if (text == null || text.isEmpty) return '---';

    final parts = text.split(RegExp(r'\s+'));
    final date = parts.isNotEmpty ? parts.first.replaceAll('-', '/') : '---';
    final time = parts.length > 1 ? parts[1] : '';
    return time.isEmpty ? date : '$date - $time';
  }

  String _dash(String? value) => value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
