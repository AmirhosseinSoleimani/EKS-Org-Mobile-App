import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_list_item_entity.dart';

class LeaveListItemModel extends LeaveListItemEntity {
  const LeaveListItemModel({
    super.id,
    super.planTitle,
    super.agencyCode,
    super.agencyName,
    super.emdadgarFullName,
    super.personInfoMobile,
    super.personId,
    super.leaveTypeText,
    super.mainReasonText,
    super.secondReasonText,
    super.statusCode,
    super.statusText,
    super.startDateJalali,
    super.endDateJalali,
    super.startTime,
    super.endTime,
    super.isActive,
    super.insertUserFullName,
    super.insertDateTimeJalali,
    super.updateUserFullName,
    super.updateDateTimeJalali,
  });

  factory LeaveListItemModel.fromJson(Map<String, dynamic> json) {
    return LeaveListItemModel(
      id: json['id'] as int?,
      planTitle: json['planTitle'] as String?,
      agencyCode: _asInt(json['agencyCode']),
      agencyName: json['agencyName'] as String?,
      emdadgarFullName: json['emdadgarFullName'] as String?,
      personInfoMobile: json['personInfoMobile'] as String?,
      personId: _asInt(json['personId']),
      leaveTypeText: json['leaveTypeText'] as String?,
      mainReasonText: json['mainReasonText'] as String?,
      secondReasonText: json['secondReasonText'] as String?,
      statusCode: _asInt(json['statusCode']),
      statusText: json['statusText'] as String?,
      startDateJalali: json['startDateJalali'] as String?,
      endDateJalali: json['endDateJalali'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      isActive: json['isActive'] as bool?,
      insertUserFullName: json['insertUserFullName'] as String?,
      insertDateTimeJalali: json['insertDateTimeJalali'] as String?,
      updateUserFullName: json['updateUserFullName'] as String?,
      updateDateTimeJalali: json['updateDateTimeJalali'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'planTitle': planTitle,
      'agencyCode': agencyCode,
      'agencyName': agencyName,
      'emdadgarFullName': emdadgarFullName,
      'personInfoMobile': personInfoMobile,
      'personId': personId,
      'leaveTypeText': leaveTypeText,
      'mainReasonText': mainReasonText,
      'secondReasonText': secondReasonText,
      'statusCode': statusCode,
      'statusText': statusText,
      'startDateJalali': startDateJalali,
      'endDateJalali': endDateJalali,
      'startTime': startTime,
      'endTime': endTime,
      'isActive': isActive,
      'insertUserFullName': insertUserFullName,
      'insertDateTimeJalali': insertDateTimeJalali,
      'updateUserFullName': updateUserFullName,
      'updateDateTimeJalali': updateDateTimeJalali,
    };
  }

  static int? _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

