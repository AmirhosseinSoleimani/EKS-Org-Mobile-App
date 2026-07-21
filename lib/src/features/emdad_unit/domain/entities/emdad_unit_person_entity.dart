import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_person_model.dart';

class EmdadUnitPersonEntity {
  const EmdadUnitPersonEntity({
    this.id,
    this.emdadUnitId,
    this.emdadUnitTitle,
    this.agencyInfoId,
    this.agencyInfoTitle,
    this.agencyPersonId,
    this.personInfoId,
    this.code,
    this.mobile,
    this.firstName,
    this.lastName,
    this.nationalNumber,
    this.isActive,
    this.agencyInfoName,
    this.grade,
    this.gradeTitle,
    this.seatType,
    this.locationId,
    this.locationTitle,
    this.latitude,
    this.longitude,
    this.address,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.seatTypeTitle,
    this.gradeCoefficient,
    this.managmentCommisionPercent,
    this.name,
    this.agencyPersonIds = const [],
    this.personInfoFullName,
    this.agencyVehicleId,
    this.vehicleInfoId,
    this.vehicleInfoTitle,
    this.score,
  });

  final int? id;
  final int? emdadUnitId;
  final String? emdadUnitTitle;
  final int? agencyInfoId;
  final String? agencyInfoTitle;
  final int? agencyPersonId;
  final int? personInfoId;
  final String? code;
  final String? mobile;
  final String? firstName;
  final String? lastName;
  final String? nationalNumber;
  final bool? isActive;
  final String? agencyInfoName;
  final int? grade;
  final String? gradeTitle;
  final int? seatType;
  final int? locationId;
  final String? locationTitle;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final String? seatTypeTitle;
  final double? gradeCoefficient;
  final double? managmentCommisionPercent;
  final String? name;
  final List<int> agencyPersonIds;
  final String? personInfoFullName;
  final int? agencyVehicleId;
  final int? vehicleInfoId;
  final String? vehicleInfoTitle;
  final double? score;



  String get fullName => [firstName, lastName]
      .where((item) => item != null && item.trim().isNotEmpty)
      .join(' ');
  EmdadUnitPersonModel toModel(){
    return EmdadUnitPersonModel(
     id:id,
     emdadUnitId:emdadUnitId,
     emdadUnitTitle:emdadUnitTitle,
     agencyInfoId:agencyInfoId,
     agencyInfoTitle:agencyInfoTitle,
     agencyPersonId:agencyPersonId,
     personInfoId:personInfoId,
     code:code,
     mobile:mobile,
     firstName:firstName,
     lastName:lastName,
     nationalNumber:nationalNumber,
     isActive:isActive,
    );
  }

}
