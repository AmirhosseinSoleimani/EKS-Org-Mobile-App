import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
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
          label: 'شماره درخواست',
          value: selectedRequest?.trackCode.toString() ?? '-',
        ),
        KeyValueRow(
          label: 'زمان ثبت',
          value:
              '${selectedRequest?.requestDateJalali ?? '-'} - ${selectedRequest?.requestTime ?? '-'}',
        ),
        if (selectedRequest is ReliefRequestEntity) ...[
          KeyValueRow(
            label: 'ایراد خودرو',
            value: reliefRequest?.defectTitle ?? '-',
          ),
          KeyValueRow(
            label: 'سرویس خودرو',
            value: reliefRequest?.emdadServiceTitle ?? '-',
          ),
          if (reliefRequest?.emdadServiceCategoryId == 21) ...[
            KeyValueRow(
              label: 'وضعیت خودرو',
              value: reliefRequest?.hamlReasonTitle ?? '-',
            ),
            KeyValueRow(
              label: 'وضعیت چرخ‌ها',
              value: reliefRequest?.wheelQuestionTitle ?? '-',
            ),
          ],
        ] else if (selectedRequest is HomeServiceRequestEntity)
          KeyValueRow(
            label: 'سرویس درخواستی',
            value: homeServiceRequest?.emdadProductTitle ??
                homeServiceRequest?.emdadServiceCategoryTitle ??
                '-',
          ),
        if (showCustomerInfo) ...[
          KeyValueRow(
            label: 'نام مشتری',
            value:
                '${selectedRequest?.firstName ?? '-'} ${selectedRequest?.lastName ?? ''}'
                    .trim(),
          ),
          KeyValueRow(
            label: 'شماره تماس مشتری',
            value: selectedRequest?.customerMobileNumber?.toLocalMobile() ?? '-',
          ),
          KeyValueRow(
            label: 'آدرس',
            value: selectedRequest?.aidAddress ?? '-',
          ),
        ],
        KeyValueRow(
          label: 'توضیحات مشتری',
          value: selectedRequest?.description ?? '-',
        ),
      ],
    );
  }

  ReliefRequestEntity? get reliefRequest =>
      selectedRequest is ReliefRequestEntity
          ? selectedRequest as ReliefRequestEntity
          : null;

  HomeServiceRequestEntity? get homeServiceRequest =>
      selectedRequest is HomeServiceRequestEntity
          ? selectedRequest as HomeServiceRequestEntity
          : null;
}
