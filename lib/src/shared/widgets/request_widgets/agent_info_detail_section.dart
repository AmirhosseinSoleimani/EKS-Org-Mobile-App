import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
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
    final relief = _reliefRequest;

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
          value: _fleetTypeValue,
        ),
        KeyValueRow(
          label: 'نوع خودرو',
          value: _vehicleTypeValue,
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
        if (relief?.distanceHamlCustomer != null)
          KeyValueRow(
            label: 'مسافت حمل شده خودرو',
            value: relief!.distanceHamlCustomer.toString(),
          ),
        if (relief?.emdadgarAssignDistanceTitle?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'فاصله تقریبی (اعزام)',
            value: relief!.emdadgarAssignDistanceTitle!,
          ),
        if (relief?.emdadgarAssignDurationTitle?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'زمان تقریبی (اعزام)',
            value: relief!.emdadgarAssignDurationTitle!,
          ),
        KeyValueRow(
          label: 'اعزام کننده',
          value: selectedRequest?.dispatcher ?? '-',
        ),
        KeyValueRow(
          label: 'نمایندگی (کد نمایندگی)',
          value: _agencyValue,
        ),
        if (relief?.emdadgarEvaluationDefectTitle?.trim().isNotEmpty == true)
          KeyValueRow(
            label: 'ایراد ارزیابی شده',
            value: relief!.emdadgarEvaluationDefectTitle!,
          ),
        if (relief?.emdadServiceGivenTitle?.trim().isNotEmpty == true)
          KeyValueRow(
            label: _providedServiceLabel,
            value: relief!.emdadServiceGivenTitle!,
          ),
        KeyValueRow(
          label: 'توضیحات $agentTitle',
          value: selectedRequest != null
              ? (selectedRequest?.emdadgarEvaluationDescription ?? '-')
              : (agentInfo?.statusTitle ?? '-'),
        ),
      ],
    );
  }

  ReliefRequestEntity? get _reliefRequest =>
      selectedRequest is ReliefRequestEntity
          ? selectedRequest as ReliefRequestEntity
          : null;

  String get _fleetTypeValue {
    if (selectedRequest?.isHomeService == true) {
      return selectedRequest?.emVehicleTypeTitle ??
          agentInfo?.navganTypeText ??
          '-';
    }

    // SanaPlus relief detail maps emVehicleSubTypeTitle to "نوع ناوگان".
    return selectedRequest?.emVehicleSubTypeTitle ??
        agentInfo?.navganTypeText ??
        '-';
  }

  String get _vehicleTypeValue {
    if (selectedRequest?.isHomeService == true) {
      return selectedRequest?.emVehicleSubTypeTitle ??
          agentInfo?.khodroTypeText ??
          '-';
    }

    // SanaPlus relief detail maps emVehicleTypeTitle to "نوع خودرو".
    return selectedRequest?.emVehicleTypeTitle ??
        agentInfo?.khodroTypeText ??
        '-';
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

  String get _providedServiceLabel {
    final category = _reliefRequest?.emdadServiceCategoryGivenTitle?.trim();
    if (category == null || category.isEmpty) return 'سرویس ارائه شده';
    return 'سرویس ارائه شده ($category)';
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
