import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/chassis_request_history_page/widgets/chassis_request_header.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_wiget_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_details_button.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:flutter/material.dart';

class ChassisRequestHistoryCard extends StatelessWidget {
  final ChassisRequestHistoryEntity chassisRequest;
  final IconData serviceIcon;
  final Function(ChassisRequestHistoryEntity) onSelected;

  const ChassisRequestHistoryCard({
    super.key,
    required this.chassisRequest,
    required this.serviceIcon,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ChassisRequestHeader(request: chassisRequest),
          const SizedBox(height: 16),
          KeyValueRow(
            label: "شماره درخواست",
            value: chassisRequest.trackingCode?.toString() ?? "-",
          ),

          KeyValueRow(
            label: "شاسی",
            value: chassisRequest.chassisNumber ?? "-",
          ),

          KeyValueRow(
            label: "نام خودرو",
            value: chassisRequest.carName ?? "-",
          ),

          KeyValueRow(
            label: "زمان",
            value: chassisRequest.insertDateTimeJalali ?? "-",
          ),

          KeyValueWidgetRow(
            label: "وضعیت درخواست",
            value: StatusLabel(
              text: chassisRequest.statusTitle ?? '',
              color: Colors.grey,
              variant: StatusLabelVariant.outlined,
            ),
          ),

          KeyValueRow(
            label: "نوع ایراد",
            value: chassisRequest.defectTitle ?? "-",
          ),

          KeyValueRow(
            label: "تلفن همراه",
            value: chassisRequest.mobileNumber ?? "-",
          ),
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.tertiaryFixed,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 12),
              RequestDetailsButton(
                onPressed: () {
                  onSelected(chassisRequest);
                },

              ),
            ],
          ),
        ],
      ),
    );
  }

}
