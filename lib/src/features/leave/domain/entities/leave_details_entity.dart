import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_details_model.dart';

class LeaveDetailsEntity {
  const LeaveDetailsEntity({
    this.emdadgarFullName,
    this.personInfoMobile,
    this.planTitle,
    this.shiftTitle,
    this.agencyCode,
    this.agencyName,
    this.agencyManagerFullName,
    this.agencyProvince,
    this.agencyCity,
    this.agencyAddress,
    this.agencyMobile,
    this.startDateJalali,
    this.endDateJalali,
    this.startTime,
    this.endTime,
    this.description,
    this.leaveType,
    this.leaveTypeText,
    this.mainReasonText,
    this.secondaryReasonText,
    this.image,
    this.statusCode,
    this.statusText,
  });

  final String? emdadgarFullName;
  final String? personInfoMobile;
  final String? planTitle;
  final String? shiftTitle;
  final String? agencyCode;
  final String? agencyName;
  final String? agencyManagerFullName;
  final String? agencyProvince;
  final String? agencyCity;
  final String? agencyAddress;
  final String? agencyMobile;
  final String? startDateJalali;
  final String? endDateJalali;
  final String? startTime;
  final String? endTime;
  final String? description;
  final int? leaveType;
  final String? leaveTypeText;
  final String? mainReasonText;
  final String? secondaryReasonText;
  final String? image;
  final int? statusCode;
  final String? statusText;

  String get startDateTime => _joinDateTime(startDateJalali, startTime);

  String get endDateTime => _joinDateTime(endDateJalali, endTime);

  String _joinDateTime(String? date, String? time) {
    final safeDate = date?.trim() ?? '';
    final safeTime = time?.trim() ?? '';

    if (safeDate.isEmpty) return safeTime;
    if (safeTime.isEmpty || leaveType == 1) return safeDate;
    return '$safeDate $safeTime';
  }

  LeaveDetailsModel toModel() {
    return LeaveDetailsModel(
      emdadgarFullName: emdadgarFullName,
      personInfoMobile: personInfoMobile,
      planTitle: planTitle,
      shiftTitle: shiftTitle,
      agencyCode: agencyCode,
      agencyName: agencyName,
      agencyManagerFullName: agencyManagerFullName,
      agencyProvince: agencyProvince,
      agencyCity: agencyCity,
      agencyAddress: agencyAddress,
      agencyMobile: agencyMobile,
      startDateJalali: startDateJalali,
      endDateJalali: endDateJalali,
      startTime: startTime,
      endTime: endTime,
      description: description,
      leaveType: leaveType,
      leaveTypeText: leaveTypeText,
      mainReasonText: mainReasonText,
      secondaryReasonText: secondaryReasonText,
      image: image,
      statusCode: statusCode,
      statusText: statusText,
    );
  }
}

