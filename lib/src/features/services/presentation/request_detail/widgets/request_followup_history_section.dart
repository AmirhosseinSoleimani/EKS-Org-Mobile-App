import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:flutter/material.dart';

class RequestFollowupHistorySection extends StatelessWidget {
  final List<FollowupEntity> items;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
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
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KeyValueRow(
                label: "نتیجه پیگیری",
                value: result,
              ),
              KeyValueRow(
                label: "تاریخ و ساعت",
                value: "$followupDate\n$followupTime",
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
                value: "$insertDate\n$insertTime",
              ),
              if ((item.description ?? "").trim().isNotEmpty)
                KeyValueRow(
                  label: "توضیحات",
                  value: item.description ?? '',
                ),
            ],
          ),
        );
      }),
    );
  }
}
