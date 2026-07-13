import '../../domain/entities/plan_info_entity.dart';

class PlanInfoListModel extends PlanInfoListEntity {
  const PlanInfoListModel({
    required super.items,
    required super.totalCount,
  });

  factory PlanInfoListModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const PlanInfoListModel(items: [], totalCount: 0);
    }

    final rawRecords = json['records'];
    return PlanInfoListModel(
      items: rawRecords is List
          ? rawRecords
              .whereType<Map<String, dynamic>>()
              .map((item) => PlanInfoModel.fromJson(item))
              .toList()
          : const [],
      totalCount: _asInt(json['count']) ?? 0,
    );
  }
}

class PlanPersonModel extends PlanPersonEntity {
  const PlanPersonModel({
    super.fullName,
    super.nationalNumber,
  });

  factory PlanPersonModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PlanPersonModel();

    return PlanPersonModel(
      fullName: _asString(json['fullName']),
      nationalNumber: _asString(json['nationalNumber']),
    );
  }
}

class PlanInfoModel extends PlanInfoEntity {
  const PlanInfoModel({
    super.id,
    super.planId,
    super.title,
    super.emdadUnitId,
    super.emdadUnitName,
    super.shiftId,
    super.shiftTitle,
    super.specialPlanId,
    super.specialPlanTitle,
    super.fromDate,
    super.fromDateJalali,
    super.toDate,
    super.toDateJalali,
    super.seatType,
    super.seatTypeTitle,
    super.locationId,
    super.locationTitle,
    super.latitude,
    super.longitude,
    super.address,
    super.isActive,
    super.status,
    super.statusTitle,
    super.reasonId,
    super.reasonTitle,
    super.description,
    super.insertUserFullName,
    super.insertDateTimeJalali,
    super.updateUserFullName,
    super.updateDateTimeJalali,
    super.emdadUnitPersons,
    super.emdadUnitPersonNames,
  });

  factory PlanInfoModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PlanInfoModel();

    final rawPersons = json['emdadUnitPersons'];
    return PlanInfoModel(
      id: _asInt(json['id']) ?? _asInt(json['planId']),
      planId: _asInt(json['planId']),
      title: _asString(json['title']),
      emdadUnitId: _asInt(json['emdadUnitId']),
      emdadUnitName: _asString(json['emdadUnitName'] ?? json['agencyInfoName']),
      shiftId: _asInt(json['shiftId']),
      shiftTitle: _asString(json['shiftTitle']),
      specialPlanId: _asInt(json['specialPlanId']),
      specialPlanTitle: _asString(json['specialPlanTitle']),
      fromDate: _asString(json['fromDate']),
      fromDateJalali: _asString(json['fromDateJalali']),
      toDate: _asString(json['toDate']),
      toDateJalali: _asString(json['toDateJalali']),
      seatType: _asInt(json['seatType']) ?? _asInt(json['planSeatType']),
      seatTypeTitle: _asString(json['seatTypeTitle'] ?? json['planSeatTypeTitle']),
      locationId: _asInt(json['locationId']) ?? _asInt(json['planLocationId']),
      locationTitle:
          _asString(json['locationTitle'] ?? json['planLocationTitle']),
      latitude: _asDouble(json['latitude'] ?? json['planLatitude']),
      longitude: _asDouble(json['longitude'] ?? json['planLongitude']),
      address: _asString(json['address'] ?? json['planAddress']),
      isActive: _asBool(json['isActive'] ?? json['planIsActive']) ?? true,
      status: _asInt(json['status']),
      statusTitle: _asString(json['statusTitle']),
      reasonId: _asInt(json['reasonId']),
      reasonTitle: _asString(json['reasonTitle']),
      description: _asString(json['description']),
      insertUserFullName: _asString(json['insertUserFullName']),
      insertDateTimeJalali: _asString(json['insertDateTimeJalali']),
      updateUserFullName: _asString(json['updateUserFullName']),
      updateDateTimeJalali: _asString(json['updateDateTimeJalali']),
      emdadUnitPersons: rawPersons is List
          ? rawPersons
              .whereType<Map<String, dynamic>>()
              .map((item) => PlanPersonModel.fromJson(item))
              .toList()
          : const [],
      emdadUnitPersonNames: _asString(json['emdadUnitPersonNames']),
    );
  }
}

int? _asInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

double? _asDouble(Object? value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

bool? _asBool(Object? value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'true' || normalized == '1') return true;
    if (normalized == 'false' || normalized == '0') return false;
  }
  return null;
}

String? _asString(Object? value) {
  if (value == null) return null;
  return value.toString();
}
