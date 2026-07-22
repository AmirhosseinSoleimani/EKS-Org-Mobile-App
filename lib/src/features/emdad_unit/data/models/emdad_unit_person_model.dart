import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_person_entity.dart';

class EmdadUnitPersonModel extends EmdadUnitPersonEntity {
  const EmdadUnitPersonModel({
    super.id,
    super.emdadUnitId,
    super.emdadUnitTitle,
    super.agencyInfoId,
    super.agencyInfoTitle,
    super.agencyPersonId,
    super.personInfoId,
    super.code,
    super.mobile,
    super.firstName,
    super.lastName,
    super.nationalNumber,
    super.isActive,
    super.agencyInfoName,
    super.grade,
    super.gradeTitle,
    super.seatType,
    super.locationId,
    super.locationTitle,
    super.latitude,
    super.longitude,
    super.address,
    super.insertUserFullName,
    super.updateUserFullName,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.seatTypeTitle,
    super.gradeCoefficient,
    super.managmentCommisionPercent,
    super.name,
    super.agencyPersonIds,
    super.personInfoFullName,
    super.agencyVehicleId,
    super.vehicleInfoId,
    super.vehicleInfoTitle,
    super.score,
  });

  factory EmdadUnitPersonModel.fromJson(Map<String, dynamic> json) {
    return EmdadUnitPersonModel(
      id: _toInt(json['id']),
      emdadUnitId: _toInt(json['emdadUnitId']),
      emdadUnitTitle: _toString(json['emdadUnitTitle']),
      agencyInfoId: _toInt(json['agencyInfoId']),
      agencyInfoTitle: _toString(json['agencyInfoTitle']),
      agencyPersonId: _toInt(json['agencyPersonId']),
      personInfoId: _toInt(json['personInfoId']),
      code: _toString(json['code']),
      mobile: _toString(json['mobile']),
      firstName: _toString(json['firstName']),
      lastName: _toString(json['lastName']),
      nationalNumber: _toString(json['nationalNumber']),
      isActive: _toBool(json['isActive']),
      agencyInfoName: _toString(json['agencyInfoName']),
      grade: _toInt(json['grade']),
      gradeTitle: _toString(json['gradeTitle']),
      seatType: _toInt(json['seatType']),
      locationId: _toInt(json['locationId']),
      locationTitle: _toString(json['locationTitle']),
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
      address: _toString(json['address']),
      insertUserFullName: _toString(json['insertUserFullName']),
      updateUserFullName: _toString(json['updateUserFullName']),
      insertDateTime: _toString(json['insertDateTime']),
      insertDateTimeJalali: _toString(json['insertDateTimeJalali']),
      seatTypeTitle: _toString(json['seatTypeTitle']),
      gradeCoefficient: _toDouble(json['gradeCoefficient']),
      managmentCommisionPercent:
      _toDouble(json['managmentCommisionPercent']),
      name: _toString(json['name']),
      agencyPersonIds: _toIntList(json['agencyPersonIds']),
      personInfoFullName: _toString(json['personInfoFullName']),
      agencyVehicleId: _toInt(json['agencyVehicleId']),
      vehicleInfoId: _toInt(json['vehicleInfoId']),
      vehicleInfoTitle: _toString(json['vehicleInfoTitle']),
      score: _toDouble(json['score']),
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;

    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value.toString());
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;

    if (value is double) {
      return value;
    }

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString());
  }

  static bool? _toBool(dynamic value) {
    if (value == null) return null;

    if (value is bool) {
      return value;
    }

    if (value is num) {
      return value == 1;
    }

    final normalizedValue = value.toString().trim().toLowerCase();

    if (normalizedValue == 'true' || normalizedValue == '1') {
      return true;
    }

    if (normalizedValue == 'false' || normalizedValue == '0') {
      return false;
    }

    return null;
  }

  static String? _toString(dynamic value) {
    if (value == null) return null;

    return value.toString();
  }

  static List<int> _toIntList(dynamic value) {
    if (value is! List) {
      return const [];
    }

    return value
        .map(_toInt)
        .whereType<int>()
        .toList();
  }
}