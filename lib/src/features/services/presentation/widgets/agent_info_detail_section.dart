import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:flutter/material.dart';

class AgentInfoDetailSection extends StatelessWidget {
  const AgentInfoDetailSection({
    super.key,
    required this.agentInfo,
  });

  final EmdadgarInfoEntity agentInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeyValueRow(
          label: "نام",
          value: agentInfo.agencyName ?? "-",
        ),
        KeyValueRow(
          label: "شماره موبایل",
          value: agentInfo.mobile ?? agentInfo.irancellMobile ?? "-",
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
          value: agentInfo.distanceKmToOrigin != null
              ? "${agentInfo.distanceKmToOrigin}"
              : "-",
        ),
        KeyValueRow(
          label: "اعزام کننده",
          value: agentInfo.agencyCodeLabel ?? "-",
        ),
        KeyValueRow(
          label: "نمایندگی (کد نمایندگی)",
          value: agentInfo.agencyName != null
              ? "${agentInfo.agencyName} (${agentInfo.agencyCode ?? '-'})"
              : "-",
        ),

        /* if(agentInfo is ReliefRequestEntity)...[
          KeyValueRow(
            label: "مسافت طی شده",
            value: (agentInfo as ReliefRequestEntity).emdadgarAssignDistanceTitle ?? '-',
          ),
          KeyValueRow(
            label: "مسافت حمل شده خودرو",
            value: (agentInfo as ReliefRequestEntity).emdadgarAssignDistanceTitle ?? '-',
          ),
          KeyValueRow(
            label: "ایراد ارزیابی شده",
            value: (agentInfo as ReliefRequestEntity).emdadServiceTitle ?? '-',
          ),
          KeyValueRow(
            label: "سرویس ارائه شده",
            value: (agentInfo as ReliefRequestEntity).emdadServiceTitle ?? '-',
          ),
        ],*/
        KeyValueRow(
          label: "توضیحات امداد رسان",
          value: agentInfo.statusTitle ?? '-',
        ),
      ],
    );
  }
}
