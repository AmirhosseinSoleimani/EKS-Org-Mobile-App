import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_wiget_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:flutter/material.dart';

class RequestFollowupHistoryItem extends StatelessWidget {
  final String result;
  final String followupDate;
  final String followupTime;
  final String source;
  final String creator;
  final String insertDate;
  final String insertTime;
  final String description;

  const RequestFollowupHistoryItem({
    super.key,
    required this.result,
    required this.followupDate,
    required this.followupTime,
    required this.source,
    required this.creator,
    required this.insertDate,
    required this.insertTime,
    required this.description,
  });


  factory RequestFollowupHistoryItem.fromEntity(
      FollowupItemEntity item, {
        Key? key,
      }) {
    final followupDate = item.followUpDateJalali ?? "-";
    final followupTime = item.followUpTime ?? "-";

    final insertDate = item.insertDateTimeJalali ?? "-";
    final insertTime = item.insertTime ?? "-";

    final result = item.resultStatusTitle ?? "-";
    final source = item.sourceTypeTitle ?? "-";

    final creator = item.authorFullName != null
        ? "${item.authorFullName} (${item.authorTypeTitle ?? '-'})"
        : "-";

    return RequestFollowupHistoryItem(
      key: key,
      result: result,
      followupDate: followupDate,
      followupTime: followupTime,
      source: source,
      creator: creator,
      insertDate: insertDate,
      insertTime: insertTime,
      description: item.description ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            value: StatusLabel(
              text: result,
              color: Colors.purple,
            ),
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
          KeyValueRow(
            label: "توضیحات",
            value: description,
          ),
        ],
      ),
    );
  }
}