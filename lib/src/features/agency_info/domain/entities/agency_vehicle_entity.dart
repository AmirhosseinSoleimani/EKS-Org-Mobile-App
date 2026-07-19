import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_vehicle_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_vehicle_grade_detail_entity.dart';

class AgencyVehicleEntity {
  const AgencyVehicleEntity({
    this.id,
    this.agencyInfoId,
    this.vehicleInfoId,
    this.vehicleModelName,
    this.vehicleModelTitle,
    this.navganTypeTitle,
    this.imei,
    this.imeiSerial,
    this.navganTypeCode,
    this.contractStartDate,
    this.contractStartDateJalali,
    this.contractEndDate,
    this.contractEndDateJalali,
    this.startBimeDate,
    this.startBimeDateJalali,
    this.endBimeDate,
    this.endBimeDateJalali,
    this.status,
    this.statusTitle,
    this.contractCode,
    this.contractType,
    this.contractTypeTitle,
    this.labelAgencyCode,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.updateDateTime,
    this.updateDateTimeJalali,
    this.chassisNo,
    this.licensePlate,
    this.engineNumber,
    this.productYear,
    this.vehicleStatus,
    this.vehicleStatusTitle,
    this.installTypeDate,
    this.isTroubleShooter,
    this.imeiId,
    this.gradePatternCode,
    this.gradePatternName,
    this.gradeDetailsJson,
    this.gradeDetails,
    this.isActive,
    this.isDeleted,
  });

  final int? id;
  final int? agencyInfoId;
  final int? vehicleInfoId;
  final String? vehicleModelName;
  final String? vehicleModelTitle;
  final String? navganTypeTitle;
  final String? imei;
  final String? imeiSerial;
  final String? navganTypeCode;
  final String? contractStartDate;
  final String? contractStartDateJalali;
  final String? contractEndDate;
  final String? contractEndDateJalali;
  final String? startBimeDate;
  final String? startBimeDateJalali;
  final String? endBimeDate;
  final String? endBimeDateJalali;
  final int? status;
  final String? statusTitle;
  final String? contractCode;
  final int? contractType;
  final String? contractTypeTitle;
  final String? labelAgencyCode;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final String? updateDateTime;
  final String? updateDateTimeJalali;
  final String? chassisNo;
  final String? licensePlate;
  final String? engineNumber;
  final String? productYear;
  final int? vehicleStatus;
  final String? vehicleStatusTitle;
  final String? installTypeDate;
  final bool? isTroubleShooter;
  final int? imeiId;
  final int? gradePatternCode;
  final String? gradePatternName;
  final String? gradeDetailsJson;
  final List<AgencyVehicleGradeDetailEntity>? gradeDetails;
  final bool? isActive;
  final bool? isDeleted;

  AgencyVehicleModel toModel() {
    return AgencyVehicleModel(
      id: id,
      agencyInfoId: agencyInfoId,
      vehicleInfoId: vehicleInfoId,
      vehicleModelName: vehicleModelName,
      vehicleModelTitle: vehicleModelTitle,
      navganTypeTitle: navganTypeTitle,
      imei: imei,
      imeiSerial: imeiSerial,
      navganTypeCode: navganTypeCode,
      contractStartDate: contractStartDate,
      contractStartDateJalali: contractStartDateJalali,
      contractEndDate: contractEndDate,
      contractEndDateJalali: contractEndDateJalali,
      startBimeDate: startBimeDate,
      startBimeDateJalali: startBimeDateJalali,
      endBimeDate: endBimeDate,
      endBimeDateJalali: endBimeDateJalali,
      status: status,
      statusTitle: statusTitle,
      contractCode: contractCode,
      contractType: contractType,
      contractTypeTitle: contractTypeTitle,
      labelAgencyCode: labelAgencyCode,
      insertUserFullName: insertUserFullName,
      updateUserFullName: updateUserFullName,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      updateDateTime: updateDateTime,
      updateDateTimeJalali: updateDateTimeJalali,
      chassisNo: chassisNo,
      licensePlate: licensePlate,
      engineNumber: engineNumber,
      productYear: productYear,
      vehicleStatus: vehicleStatus,
      vehicleStatusTitle: vehicleStatusTitle,
      installTypeDate: installTypeDate,
      isTroubleShooter: isTroubleShooter,
      imeiId: imeiId,
      gradePatternCode: gradePatternCode,
      gradePatternName: gradePatternName,
      gradeDetailsJson: gradeDetailsJson,
      gradeDetails: gradeDetails?.map((item) => item.toModel()).toList(),
      isActive: isActive,
      isDeleted: isDeleted,
    );
  }

  AgencyVehicleEntity copyWith({
    int? id,
    int? agencyInfoId,
    int? vehicleInfoId,
    String? vehicleModelName,
    String? vehicleModelTitle,
    String? navganTypeTitle,
    String? imei,
    String? imeiSerial,
    String? navganTypeCode,
    String? contractStartDate,
    String? contractStartDateJalali,
    String? contractEndDate,
    String? contractEndDateJalali,
    String? startBimeDate,
    String? startBimeDateJalali,
    String? endBimeDate,
    String? endBimeDateJalali,
    int? status,
    String? statusTitle,
    String? contractCode,
    int? contractType,
    String? contractTypeTitle,
    String? labelAgencyCode,
    String? insertUserFullName,
    String? updateUserFullName,
    String? insertDateTime,
    String? insertDateTimeJalali,
    String? updateDateTime,
    String? updateDateTimeJalali,
    String? chassisNo,
    String? licensePlate,
    String? engineNumber,
    String? productYear,
    int? vehicleStatus,
    String? vehicleStatusTitle,
    String? installTypeDate,
    bool? isTroubleShooter,
    int? imeiId,
    int? gradePatternCode,
    String? gradePatternName,
    String? gradeDetailsJson,
    List<AgencyVehicleGradeDetailEntity>? gradeDetails,
    bool? isActive,
    bool? isDeleted,
  }) {
    return AgencyVehicleEntity(
      id: id ?? this.id,
      agencyInfoId: agencyInfoId ?? this.agencyInfoId,
      vehicleInfoId: vehicleInfoId ?? this.vehicleInfoId,
      vehicleModelName: vehicleModelName ?? this.vehicleModelName,
      vehicleModelTitle: vehicleModelTitle ?? this.vehicleModelTitle,
      navganTypeTitle: navganTypeTitle ?? this.navganTypeTitle,
      imei: imei ?? this.imei,
      imeiSerial: imeiSerial ?? this.imeiSerial,
      navganTypeCode: navganTypeCode ?? this.navganTypeCode,
      contractStartDate: contractStartDate ?? this.contractStartDate,
      contractStartDateJalali: contractStartDateJalali ?? this.contractStartDateJalali,
      contractEndDate: contractEndDate ?? this.contractEndDate,
      contractEndDateJalali: contractEndDateJalali ?? this.contractEndDateJalali,
      startBimeDate: startBimeDate ?? this.startBimeDate,
      startBimeDateJalali: startBimeDateJalali ?? this.startBimeDateJalali,
      endBimeDate: endBimeDate ?? this.endBimeDate,
      endBimeDateJalali: endBimeDateJalali ?? this.endBimeDateJalali,
      status: status ?? this.status,
      statusTitle: statusTitle ?? this.statusTitle,
      contractCode: contractCode ?? this.contractCode,
      contractType: contractType ?? this.contractType,
      contractTypeTitle: contractTypeTitle ?? this.contractTypeTitle,
      labelAgencyCode: labelAgencyCode ?? this.labelAgencyCode,
      insertUserFullName: insertUserFullName ?? this.insertUserFullName,
      updateUserFullName: updateUserFullName ?? this.updateUserFullName,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
      updateDateTime: updateDateTime ?? this.updateDateTime,
      updateDateTimeJalali: updateDateTimeJalali ?? this.updateDateTimeJalali,
      chassisNo: chassisNo ?? this.chassisNo,
      licensePlate: licensePlate ?? this.licensePlate,
      engineNumber: engineNumber ?? this.engineNumber,
      productYear: productYear ?? this.productYear,
      vehicleStatus: vehicleStatus ?? this.vehicleStatus,
      vehicleStatusTitle: vehicleStatusTitle ?? this.vehicleStatusTitle,
      installTypeDate: installTypeDate ?? this.installTypeDate,
      isTroubleShooter: isTroubleShooter ?? this.isTroubleShooter,
      imeiId: imeiId ?? this.imeiId,
      gradePatternCode: gradePatternCode ?? this.gradePatternCode,
      gradePatternName: gradePatternName ?? this.gradePatternName,
      gradeDetailsJson: gradeDetailsJson ?? this.gradeDetailsJson,
      gradeDetails: gradeDetails ?? this.gradeDetails,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
