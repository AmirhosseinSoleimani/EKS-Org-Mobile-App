import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/san_history_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class RescuerHistorySection extends StatelessWidget {
  final List<SanHistoryEntity> items;

  const RescuerHistorySection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FormSectionContainer(
      hasBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BodyMediumText(text: 'تاریخچه', fontWeight: FontWeight.w700),
          const SizedBox(height: 12),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: BodySmallText(
                text: 'تاریخچه‌ای ثبت نشده است.',
                textAlign: TextAlign.center,
              ),
            )
          else
            ...List.generate(items.length, (index) {
              final item = items[index];
              final isLast = index == items.length - 1;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _actionColor(item.actionType, colorScheme),
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 88,
                          color: colorScheme.outlineVariant,
                        ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodySmallText(
                            text: item.description?.trim().isNotEmpty == true
                                ? item.description!.trim()
                                : '-',
                            lineHeight: 1.6,
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              Expanded(
                                child: BodySmallText(
                                  text: 'کاربر: ${item.insertUserName ?? '-'}',
                                  color: colorScheme.onSurfaceVariant,
                                  fontSize: 10,
                                ),
                              ),
                              BodySmallText(
                                text: item.insertDateTimeJalali ?? '-',
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
        ],
      ),
    );
  }

  Color _actionColor(int? actionType, ColorScheme colorScheme) {
    switch (actionType) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return colorScheme.error;
      default:
        return colorScheme.primary;
    }
  }
}
