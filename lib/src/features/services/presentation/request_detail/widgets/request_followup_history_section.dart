import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_wiget_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/vertical_line_indicator.dart';
import 'package:flutter/material.dart';

class RequestFollowupHistorySection extends StatelessWidget {
  final List<FollowupItemEntity> items;

  const RequestFollowupHistorySection({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Text("هیچ سابقه پیگیری ثبت نشده است"),
        ),
      );
    }

    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: VerticalLineIndicator(icon: const Icon(
            Icons.date_range_rounded,
            color: Colors.grey,
            size: 20,
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, right: 24),
          child: Column(children: List.generate(items.length, (index) {
            final item = items[index];

            final followupDate = item.followUpDateJalali ?? "-";
            final followupTime = item.followUpTime ?? "-";

            final insertDate = item.insertDateTimeJalali ?? "-";
            final insertTime = item.insertTime ?? "-";

            final result = item.resultStatusTitle ?? "-";
            final source = item.sourceTypeTitle ?? "-";

            final creator = item.authorFullName != null
                ? "${item.authorFullName} (${item.authorTypeTitle ?? '-'})"
                : "-";

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KeyValueWidgetRow(
                    label: "نتیجه پیگیری",
                    value: StatusLabel(text: result, color: Colors.purple),
                  ),
                  KeyValueRow(
                    label: "تاریخ و ساعت",
                    value: "$followupDate - $followupTime",
                  ),
                  KeyValueRow(
                    label: "منبع",
                    value: source,
                  ),
                  KeyValueRow(
                    label: "ثبت کننده",
                    value: creator,
                  ),
                  KeyValueRow(
                    label: "تاریخ و ساعت ثبت",
                    value: "$insertDate - $insertTime",
                  ),
                  if ((item.description ?? "").trim().isNotEmpty)
                    KeyValueRow(
                      label: "توضیحات",
                      value: item.description ?? '',
                    ),
                ],
              ),
            );
          }),),
        )
      ],
    );
  }
}
