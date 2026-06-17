import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:flutter/material.dart';

class RequestDetailSection extends StatelessWidget {
  const RequestDetailSection({
    super.key,
    required this.selectedRequest,
    this.showCustomerInfo = false,
  });

  final BaseRequestEntity? selectedRequest;
  final bool showCustomerInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeyValueRow(
          label: "شماره درخواست",
        value: selectedRequest?.trackCode.toString() ?? '-',
      ),
        KeyValueRow(
          label: "زمان ثبت",
          value:
            "${selectedRequest?.requestDateJalali ?? '-'} - ${selectedRequest?.requestTime ?? '-'}",
      ),
        KeyValueRow(
        label: isRelief ? "ایراد خودرو" : "سرویس انتخاب شده",
        value: isRelief
            ? (selectedRequest as ReliefRequestEntity).defectTitle ?? '-'
            : (selectedRequest as HomeServiceRequestEntity).emdadProductTitle ??
                "-",
        ),
      if (selectedRequest is ReliefRequestEntity)
        KeyValueRow(
            label: "وضعیت خودرو",
          value:
              (selectedRequest as ReliefRequestEntity).hamlReasonTitle ?? "-",
          ),
      if (selectedRequest is ReliefRequestEntity)
        KeyValueRow(
            label: "وضعیت چرخ‌ها",
          value: (selectedRequest as ReliefRequestEntity).wheelQuestionTitle ??
              "-",
          ),
      if (showCustomerInfo) ...[
        KeyValueRow(
          label: "نام مشتری",
          value:
              "${selectedRequest?.firstName ?? "-"} ${selectedRequest?.lastName ?? ""}"
                  .trim(),
        ),
        KeyValueRow(
          label: "شماره تماس مشتری",
          value: selectedRequest?.customerMobileNumber ?? "-",
        ),
        KeyValueRow(
          label: "آدرس",
          value: selectedRequest?.aidAddress ?? "-",
        ),
      ],
      KeyValueRow(
          label: "توضیحات مشتری",
        value: selectedRequest?.description ?? "-",
      ),
    ]);
  }

  bool get isRelief => selectedRequest is ReliefRequestEntity;
}
