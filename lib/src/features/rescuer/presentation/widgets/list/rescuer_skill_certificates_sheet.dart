import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class RescuerSkillCertificatesSheet extends StatelessWidget {
  final List<SkillCertificateEntity> items;

  const RescuerSkillCertificatesSheet({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.card_membership_outlined, color: colorScheme.primary),
            const SizedBox(width: 8),
            const Expanded(
              child: BodyMediumText(
                text: 'گواهینامه مهارت‌ها',
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        if (items.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: BodySmallText(
              text: 'گواهینامه مهارتی ثبت نشده است.',
              textAlign: TextAlign.center,
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEDE6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: BodySmallText(
                  text: item.title?.trim().isNotEmpty == true
                      ? item.title!.trim()
                      : '-',
                  color: const Color(0xFFF97316),
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList(growable: false),
          ),
      ],
    );
  }
}
