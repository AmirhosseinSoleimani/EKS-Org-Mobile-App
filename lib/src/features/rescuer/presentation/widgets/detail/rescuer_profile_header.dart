import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/rescuer_avatar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class RescuerProfileHeader extends StatelessWidget {
  final RescuerEntity item;

  const RescuerProfileHeader({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = item.isActive == true || item.status == 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          RescuerAvatar(
            imageBase64: item.imageBase64,
            size: 72,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyMediumText(
                  text: item.fullName.isEmpty ? 'بدون نام' : item.fullName,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 5),
                BodySmallText(
                  text: 'کد پرسنلی: ${item.code ?? '-'}',
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 10),
                StatusLabel(
                  text: isActive ? 'فعال' : 'غیرفعال',
                  color: isActive ? Colors.green : colorScheme.error,
                  backgroundColor: isActive
                      ? const Color(0xFFDDF8E8)
                      : colorScheme.errorContainer,
                  variant: StatusLabelVariant.filledWithoutBorder,
                  fontSize: 11,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
