import 'package:eks_sana_plus_org/src/features/leave/data/models/params/get_leave_reports_param_model.dart';

class GetLeaveReportsParamEntity {
  const GetLeaveReportsParamEntity({
    this.emdadgarFullName = '',
    this.startDate = '',
    this.endDate = '',
    this.mainReason,
    this.secondaryReason,
    this.type,
    this.agencyCode,
    this.emdadgarId,
    this.status,
  });

  final String emdadgarFullName;
  final String startDate;
  final String endDate;
  final int? mainReason;
  final int? secondaryReason;
  final int? type;
  final int? agencyCode;
  final int? emdadgarId;
  final int? status;

  GetLeaveReportsParamModel toModel() {
    return GetLeaveReportsParamModel(
      emdadgarFullName: emdadgarFullName,
      startDate: startDate,
      endDate: endDate,
      mainReason: mainReason,
      secondaryReason: secondaryReason,
      type: type,
      agencyCode: agencyCode,
      emdadgarId: emdadgarId,
      status: status,
    );
  }
}

