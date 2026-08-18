import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:flutter/material.dart';

class AgentInfoDetailSection extends StatelessWidget {
  const AgentInfoDetailSection({
    super.key,
    this.agentInfo,
    this.selectedRequest,
  });

  final EmdadgarInfoEntity? agentInfo;
  final BaseRequestEntity? selectedRequest;

  @override
  Widget build(BuildContext context) {
    final isHomeService = selectedRequest?.isHomeService == true;
    final agentTitle = isHomeService ? 'خدمت رسان' : 'امدادرسان';

    return Column(
      children: [
        KeyValueRow(
          label: 'نام',
          value: selectedRequest?.emFullName ?? agentInfo?.aidPerName1 ?? '-',
        ),
        KeyValueRow(
          label: 'شماره موبایل',
          value: (selectedRequest?.emMobileNumber1 ??
                      agentInfo?.mobile ??
                      agentInfo?.irancellMobile)
                  ?.toLocalMobile() ??
              '-',
        ),
        KeyValueRow(
          label: 'نوع ناوگان',
          value: selectedRequest?.emVehicleTypeTitle ??
              agentInfo?.navganTypeText ??
              '-',
        ),
        KeyValueRow(
          label: 'نوع خودرو',
          value: selectedRequest?.emVehicleSubTypeTitle ??
              agentInfo?.khodroTypeText ??
              '-',
        ),
        if (selectedRequest?.emdadgarPriority != null)
          KeyValueRow(
            label: 'اولویت $agentTitle',
            value: selectedRequest!.emdadgarPriority.toString(),
          ),
        KeyValueRow(
          label: 'مسافت طی شده',
          value: _distanceValue,
        ),
        KeyValueRow(
          label: 'اعزام کننده',
          value: selectedRequest?.dispatcher ?? '-',
        ),
        KeyValueRow(
          label: 'نمایندگی (کد نمایندگی)',
          value: _agencyValue,
        ),
        KeyValueRow(
          label: 'توضیحات $agentTitle',
          value: selectedRequest != null
              ? (selectedRequest?.emdadgarEvaluationDescription ?? '')
              : (agentInfo?.statusTitle ?? '-'),
        ),
      ],
    );
  }

  String get _distanceValue {
    if (selectedRequest?.isHomeService == true) {
      return selectedRequest?.kilometer?.toString() ?? '-';
    }

    if (selectedRequest != null) {
      return selectedRequest?.distanceToCustomer?.toString() ?? '-';
    }

    return agentInfo?.distanceKmToOrigin?.toString() ?? '-';
  }

  String get _agencyValue {
    final agencyName = selectedRequest?.emRepresentationName ??
        agentInfo?.agencyName;
    final agencyCode = selectedRequest?.emRepresentationCode ??
        agentInfo?.agencyCode;

    if ((agencyName == null || agencyName.isEmpty) &&
        (agencyCode == null || agencyCode.isEmpty)) {
      return '-';
    }

    if (agencyName == null || agencyName.isEmpty) {
      return agencyCode ?? '-';
    }

    if (agencyCode == null || agencyCode.isEmpty) {
      return agencyName;
    }

    return '$agencyName ($agencyCode)';
  }
}
