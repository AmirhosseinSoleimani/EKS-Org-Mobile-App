import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/timeline_item_card.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/vertical_line_indicator.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class RequestStatusHistorySection extends StatelessWidget {
  final List<RequestStatusHistoryItemEntity> items;

  const RequestStatusHistorySection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Center(child: Text("هیچ سابقه پیگیری ثبت نشده است")),
      );
    }

    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: VerticalLineIndicator(
            icon: const Icon(Icons.history, color: Colors.grey, size: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: ListView.builder(
            key: const PageStorageKey('request_status_history_list'),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return TimelineItemCard(
                children: [
                  KeyValueRow(
                    label: item.title ?? '-',
                    valueFontSize: 14,
                    boldLabel: true,
                    value: item.insertDateTime ?? '-',
                  ),
                  Space.h8,
                  KeyValueRow(
                    leadingWidget: Icon(
                      Icons.person_rounded,
                      size: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    label: '',
                    value: item.insertUserName ?? '-',
                    boldValue: true,
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space.h8,
                      BodySmallText(
                        text: item.description!,
                        textAlign: TextAlign.start,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
