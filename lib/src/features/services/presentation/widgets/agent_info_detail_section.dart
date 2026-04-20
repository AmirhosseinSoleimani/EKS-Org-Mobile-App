import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:flutter/material.dart';

class AgentInfoDetailSection extends StatelessWidget {
  const AgentInfoDetailSection({
    super.key,
    required this.selectedRequest,
  });

  final BaseRequestEntity selectedRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeyValueRow(
          label: "نام",
          value: selectedRequest.carName ?? "-",
        ),
        KeyValueRow(
          label: "شماره موبایل",
          value: selectedRequest.emMobileNumber1 ?? "-",
        ),
        KeyValueRow(
          label: "نوع ناوگان",
          value: selectedRequest.emVehicleTypeTitle ?? "-",
        ),

        KeyValueRow(
          label: "نوع خودرو",
          value: selectedRequest.emVehicleSubTypeTitle ?? "-",
        ),
        KeyValueRow(
          label: "مسافت طی شده",
          value: selectedRequest.kilometer.toString(),
        ),
        KeyValueRow(
          label: "اعزام کننده",
          value: selectedRequest.dispatcher ?? "-",
        ),
        KeyValueRow(
          label: "نمایندگی (کد نمایندگی)",
          value: '${selectedRequest.emRepresentationName} (${selectedRequest.emRepresentationCode})',
        ),
        if(selectedRequest is ReliefRequestEntity)...[
          KeyValueRow(
            label: "مسافت طی شده",
            value: (selectedRequest as ReliefRequestEntity).emdadgarAssignDistanceTitle ?? '-',
          ),
          KeyValueRow(
            label: "مسافت حمل شده خودرو",
            value: (selectedRequest as ReliefRequestEntity).emdadgarAssignDistanceTitle ?? '-',
          ),
          KeyValueRow(
            label: "ایراد ارزیابی شده",
            value: (selectedRequest as ReliefRequestEntity).emdadServiceTitle ?? '-',
          ),
          KeyValueRow(
            label: "سرویس ارائه شده",
            value: (selectedRequest as ReliefRequestEntity).emdadServiceTitle ?? '-',
          ),
        ],
        KeyValueRow(
          label: "توضیحات امداد رسان",
          value: selectedRequest.description ?? '-',
        ),
      ],
    );
  }
}
