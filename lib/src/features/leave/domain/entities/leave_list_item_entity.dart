import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_list_item_model.dart';

class LeaveListItemEntity {
  const LeaveListItemEntity({
    this.id,
    this.planTitle,
    this.agencyCode,
    this.agencyName,
    this.emdadgarFullName,
    this.personInfoMobile,
    this.personId,
    this.leaveTypeText,
    this.mainReasonText,
    this.secondReasonText,
    this.statusCode,
    this.statusText,
    this.startDateJalali,
    this.endDateJalali,
    this.startTime,
    this.endTime,
    this.isActive,
    this.insertUserFullName,
    this.insertDateTimeJalali,
    this.updateUserFullName,
    this.updateDateTimeJalali,
  });

  final int? id;
  final String? planTitle;
  final int? agencyCode;
  final String? agencyName;
  final String? emdadgarFullName;
  final String? personInfoMobile;
  final int? personId;
  final String? leaveTypeText;
  final String? mainReasonText;
  final String? secondReasonText;
  final int? statusCode;
  final String? statusText;
  final String? startDateJalali;
  final String? endDateJalali;
  final String? startTime;
  final String? endTime;
  final bool? isActive;
  final String? insertUserFullName;
  final String? insertDateTimeJalali;
  final String? updateUserFullName;
  final String? updateDateTimeJalali;

  LeaveListItemModel toModel() {
    return LeaveListItemModel(
      id: id,
      planTitle: planTitle,
      agencyCode: agencyCode,
      agencyName: agencyName,
      emdadgarFullName: emdadgarFullName,
      personInfoMobile: personInfoMobile,
      personId: personId,
      leaveTypeText: leaveTypeText,
      mainReasonText: mainReasonText,
      secondReasonText: secondReasonText,
      statusCode: statusCode,
      statusText: statusText,
      startDateJalali: startDateJalali,
      endDateJalali: endDateJalali,
      startTime: startTime,
      endTime: endTime,
      isActive: isActive,
      insertUserFullName: insertUserFullName,
      insertDateTimeJalali: insertDateTimeJalali,
      updateUserFullName: updateUserFullName,
      updateDateTimeJalali: updateDateTimeJalali,
    );
  }
}

