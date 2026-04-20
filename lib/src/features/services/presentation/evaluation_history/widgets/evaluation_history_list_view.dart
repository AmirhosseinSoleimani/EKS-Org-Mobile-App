import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_wiget_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/timeline_item_card.dart';

class EvaluationListView extends StatelessWidget {
  final List<EvaluationHistoryItemEntity> items;
  final Widget icon;

  const EvaluationListView({
    super.key,
    required this.items,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BodyMediumText(text: "تاریخچه ارزیابی"),
          const SizedBox(height: 6),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return TimelineItemCard(
                icon: icon,
                expandedChildren: [
                  KeyValueRow(
                    label: "ایراد",
                    value: item.defectInfoTitle ?? "-",
                  ),
                  KeyValueRow(
                    label: "مسافت طی شده",
                    value: "${item.distanceToCustomer ?? 0}",
                  ),
                  KeyValueRow(
                    label: "مسافت حمل",
                    value: "${item.distanceHamlCustomer ?? 0}",
                  ),
                  KeyValueRow(
                    label: "زمان توقف (دقیقه)",
                    value: "${item.stopTime ?? 0}",
                  ),
                  KeyValueRow(
                    label: "استفاده از دکل",
                    value: (item.useDakal ?? false) ? "بله" : "خیر",
                  ),
                  KeyValueRow(
                    label: "عوارض آزادراهی",
                    value: (item.payAvarezi ?? false) ? "بله" : "خیر",
                  ),
                  KeyValueRow(
                    label: "زمان حضور",
                    value: item.arriveDateTimeJalali ?? "-",
                  ),
                  KeyValueRow(
                    label: "زمان اتمام",
                    value: item.endWorkDateTimeJalali ?? "-",
                  ),
                  KeyValueRow(
                    label: "علت کنسل مجاز",
                    value: item.cancelReasonTitle ?? "-",
                  ),
                  KeyValueRow(
                    label: "علت در محل نبودن امدادخواه",
                    value: item.cancelReasonDetailTitle ?? "-",
                  ),
                  KeyValueRow(
                    label: "توضیحات",
                    value: item.description ?? "-",
                  ),
                  KeyValueRow(
                    label: "عملیات",
                    value: "-",
                  ),
                ],
                children: [
                  KeyValueRow(
                    label: "وضعیت",
                    value: item.statusTitle ?? "-",
                  ),
                  KeyValueWidgetRow(
                    label: "نوع عدم همکاری",
                    value: StatusLabel(
                      text:hasInvoice(item)
                          ? "دارای فاکتور"
                          : "فاقد فاکتور",
                      color:  hasInvoice(item)
                          ?Theme.of(context).colorScheme.primary:Colors.grey,
                      variant: StatusLabelVariant.filledWhiteText,
                    ),
                  ),
                  KeyValueRow(
                    label: "نوع فاکتور",
                    value: hasInvoice(item)
                        ? "دارای فاکتور"
                        : "فاقد فاکتور",
                  ),
                  KeyValueRow(
                    label: "نام و نام خانوادگی",
                    value: "${item.firstName ?? ''} ${item.lastName ?? ''}",
                  ),
                  KeyValueRow(
                    label: "تاریخ و ساعت ثبت",
                    value: item.insertDateTimeJalali ?? "-",
                  ),
                  KeyValueRow(
                    label: "نوع ناوگان",
                    value: item.emdadgarNavganTypeTitle ?? "-",
                  ),
                  KeyValueRow(
                    label: "نوع امداد",
                    value: item.emdadServiceCategoryTitle ?? "-",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  bool hasInvoice(EvaluationHistoryItemEntity item) => (item.invoiceId != null && item.invoiceId != -1);
}
