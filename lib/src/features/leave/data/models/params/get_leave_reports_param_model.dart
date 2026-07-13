import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/get_leave_reports_param_entity.dart';

class GetLeaveReportsParamModel extends GetLeaveReportsParamEntity {
  const GetLeaveReportsParamModel({
    super.emdadgarFullName,
    super.startDate,
    super.endDate,
    super.mainReason,
    super.secondaryReason,
    super.type,
    super.agencyCode,
    super.emdadgarId,
    super.status,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      'StartDate': startDate,
      'EndDate': endDate,
      'MainReason': mainReason ?? '',
      'SecondaryReason': secondaryReason ?? '',
      'Type': type ?? '',
      'AgencyCode': agencyCode ?? '',
      'EmdadgarId': emdadgarId ?? '',
      'EmdadgarFullName': emdadgarFullName,
      'Status': status ?? '',
    };
  }
}

