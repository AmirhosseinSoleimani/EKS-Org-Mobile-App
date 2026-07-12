import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_model.dart';

class EmdadUnitEntity {
  const EmdadUnitEntity({
    this.id,
    this.agencyInfoId,
    this.parentId,
    this.type,
    this.grade,
    this.typeTitle,
    this.name,
    this.agencyPersonId,
    this.agencyVehicleId,
    this.vehicleInfoId,
    this.agencyInfoName,
    this.vehicleInfoTitle,
    this.personInfoFullName,
    this.imageBase64,
    this.seatType,
    this.seatTypeTitle,
    this.score,
    this.latitude,
    this.longitude,
    this.locationId,
    this.locationTitle,
    this.address,
    this.imageGuid,
    this.isActive,
    this.gradeTitle,
    this.gradePatternName,
    this.gradePatternCode,
    this.gradeCoefficient,
    this.managmentCommisionPercent,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTimeJalali,
    this.updateDateTimeJalali,
  });

  final int? id;
  final int? agencyInfoId;
  final int? parentId;
  final int? type;
  final int? grade;
  final String? typeTitle;
  final String? name;
  final int? agencyPersonId;
  final int? agencyVehicleId;
  final int? vehicleInfoId;
  final String? agencyInfoName;
  final String? vehicleInfoTitle;
  final String? personInfoFullName;
  final String? imageBase64;
  final int? seatType;
  final String? seatTypeTitle;
  final int? score;
  final double? latitude;
  final double? longitude;
  final int? locationId;
  final String? locationTitle;
  final String? address;
  final String? imageGuid;
  final bool? isActive;
  final String? gradeTitle;
  final String? gradePatternName;
  final int? gradePatternCode;
  final num? gradeCoefficient;
  final num? managmentCommisionPercent;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTimeJalali;
  final String? updateDateTimeJalali;

  EmdadUnitModel toModel() {
    return EmdadUnitModel(
      id: id,
      agencyInfoId: agencyInfoId,
      parentId: parentId,
      type: type,
      grade: grade,
      typeTitle: typeTitle,
      name: name,
      agencyPersonId: agencyPersonId,
      agencyVehicleId: agencyVehicleId,
      vehicleInfoId: vehicleInfoId,
      agencyInfoName: agencyInfoName,
      vehicleInfoTitle: vehicleInfoTitle,
      personInfoFullName: personInfoFullName,
      imageBase64: imageBase64,
      seatType: seatType,
      seatTypeTitle: seatTypeTitle,
      score: score,
      latitude: latitude,
      longitude: longitude,
      locationId: locationId,
      locationTitle: locationTitle,
      address: address,
      imageGuid: imageGuid,
      isActive: isActive,
      gradeTitle: gradeTitle,
      gradePatternName: gradePatternName,
      gradePatternCode: gradePatternCode,
      gradeCoefficient: gradeCoefficient,
      managmentCommisionPercent: managmentCommisionPercent,
      insertUserFullName: insertUserFullName,
      updateUserFullName: updateUserFullName,
      insertDateTimeJalali: insertDateTimeJalali,
      updateDateTimeJalali: updateDateTimeJalali,
    );
  }
}
