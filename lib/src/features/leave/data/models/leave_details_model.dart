import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_details_entity.dart';

class LeaveDetailsModel extends LeaveDetailsEntity {
  const LeaveDetailsModel({
    super.emdadgarFullName,
    super.personInfoMobile,
    super.planTitle,
    super.shiftTitle,
    super.agencyCode,
    super.agencyName,
    super.agencyManagerFullName,
    super.agencyProvince,
    super.agencyCity,
    super.agencyAddress,
    super.agencyMobile,
    super.startDateJalali,
    super.endDateJalali,
    super.startTime,
    super.endTime,
    super.description,
    super.leaveType,
    super.leaveTypeText,
    super.mainReasonText,
    super.secondaryReasonText,
    super.image,
    super.statusCode,
    super.statusText,
  });

  factory LeaveDetailsModel.fromJson(Map<String, dynamic> json) {
    return LeaveDetailsModel(
      emdadgarFullName: json['emdadgarFullName'] as String?,
      personInfoMobile: json['personInfoMobile'] as String?,
      planTitle: json['planTitle'] as String?,
      shiftTitle: json['shiftTitle'] as String?,
      agencyCode: json['agencyCode']?.toString(),
      agencyName: json['agencyName'] as String?,
      agencyManagerFullName: json['agencyManagerFullName'] as String?,
      agencyProvince: json['agencyProvince'] as String?,
      agencyCity: json['agencyCity'] as String?,
      agencyAddress: json['agencyAddress'] as String?,
      agencyMobile: json['agencyMobile'] as String?,
      startDateJalali: json['startDateJalali'] as String?,
      endDateJalali: json['endDateJalali'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      description: json['description'] as String?,
      leaveType: _asInt(json['leaveType']),
      leaveTypeText: json['leaveTypeText'] as String?,
      mainReasonText: json['mainReasonText'] as String?,
      secondaryReasonText: json['secondaryReasonText'] as String?,
      image: json['image'] as String?,
      statusCode: _asInt(json['statusCode']),
      statusText: json['statusText'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emdadgarFullName': emdadgarFullName,
      'personInfoMobile': personInfoMobile,
      'planTitle': planTitle,
      'shiftTitle': shiftTitle,
      'agencyCode': agencyCode,
      'agencyName': agencyName,
      'agencyManagerFullName': agencyManagerFullName,
      'agencyProvince': agencyProvince,
      'agencyCity': agencyCity,
      'agencyAddress': agencyAddress,
      'agencyMobile': agencyMobile,
      'startDateJalali': startDateJalali,
      'endDateJalali': endDateJalali,
      'startTime': startTime,
      'endTime': endTime,
      'description': description,
      'leaveType': leaveType,
      'leaveTypeText': leaveTypeText,
      'mainReasonText': mainReasonText,
      'secondaryReasonText': secondaryReasonText,
      'image': image,
      'statusCode': statusCode,
      'statusText': statusText,
    };
  }

  static int? _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

