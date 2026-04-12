import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
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
      return const Center(
        child: Text("هیچ سابقه پیگیری ثبت نشده است"),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: DataTable(
          headingRowHeight: 42,
          dataRowMinHeight: 60,
          dataRowMaxHeight: 120,
          columnSpacing: 32,
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          columns: const [
            DataColumn(label: Text("نتیجه پیگیری")),
            DataColumn(label: Text("تاریخ و ساعت")),
            DataColumn(label: Text("منبع")),
            DataColumn(label: Text("ثبت کننده")),
            DataColumn(label: Text("تاریخ و ساعت ثبت")),
            DataColumn(label: Text("توضیحات")),
          ],
          rows: items.map((e) {
            return DataRow(
              cells: [
                DataCell(Text(e.resultStatusTitle ?? "-")),

                // تاریخ و ساعت پیگیری
                DataCell(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.followUpDateJalali ?? "-"),
                      const SizedBox(height: 2),
                      Text(e.followUpTime ?? "-"),
                    ],
                  ),
                ),

                // منبع
                DataCell(Text(e.sourceTypeTitle ?? "-")),

                // ثبت کننده + نوع (مدیر سیستم (کاربر سیستم))
                DataCell(
                  Text(
                    "${e.authorFullName ?? "-"}"
                    "${e.authorTypeTitle != null ? " (${e.authorTypeTitle})" : ""}",
                  ),
                ),

                // تاریخ و ساعت ثبت
                DataCell(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.insertDateTimeJalali ?? "-"),
                      const SizedBox(height: 2),
                      Text(e.insertTime ?? "-"),
                    ],
                  ),
                ),

                // توضیحات
                const DataCell(
                  SizedBox(
                    width: 200,
                    child: Text(
                      /*e.description ??*/
                      "-",
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
