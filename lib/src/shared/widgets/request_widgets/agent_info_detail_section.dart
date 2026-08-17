import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:flutter/material.dart';

class AgentInfoDetailSection extends StatelessWidget {
  const AgentInfoDetailSection({
    super.key,
    required this.agentInfo,
    this.selectedRequest,
  });

  final EmdadgarInfoEntity agentInfo;
  final BaseRequestEntity? selectedRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeyValueRow(
          label: "نام",
          value: selectedRequest?.emFullName ?? agentInfo.aidPerName1 ?? "-",
        ),
        KeyValueRow(
          label: "شماره موبایل",
          value: (agentInfo.mobile ?? agentInfo.irancellMobile)?.toLocalMobile() ??
              "-",
        ),
        KeyValueRow(
          label: "نوع ناوگان",
          value: agentInfo.navganTypeText ?? "-",
        ),

        KeyValueRow(
          label: "نوع خودرو",
          value: agentInfo.khodroTypeText ?? "-",
        ),
        KeyValueRow(
          label: "مسافت طی شده",
          value: selectedRequest?.distanceToCustomer != null
              ? "${selectedRequest?.distanceToCustomer}"
              : agentInfo.distanceKmToOrigin != null
                  ? "${agentInfo.distanceKmToOrigin}"
                  : "-",
        ),
        KeyValueRow(
          label: "اعزام کننده",
          value: selectedRequest?.dispatcher ?? "-",
        ),
        KeyValueRow(
          label: "نمایندگی (کد نمایندگی)",
          value: agentInfo.agencyName != null
              ? "${agentInfo.agencyName} (${agentInfo.agencyCode ?? '-'})"
              : "-",
        ),

        KeyValueRow(
          label: "توضیحات امداد رسان",
          value: agentInfo.statusTitle ?? '-',
        ),
      ],
    );
  }
}
