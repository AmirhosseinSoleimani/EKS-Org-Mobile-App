class PlanInfoListEntity {
  final List<PlanInfoEntity> items;
  final int totalCount;

  const PlanInfoListEntity({
    required this.items,
    required this.totalCount,
  });
}

class PlanPersonEntity {
  final String? fullName;
  final String? nationalNumber;

  const PlanPersonEntity({
    this.fullName,
    this.nationalNumber,
  });
}

class PlanInfoEntity {
  final int? id;
  final int? planId;
  final String? title;
  final int? emdadUnitId;
  final String? emdadUnitName;
  final int? shiftId;
  final String? shiftTitle;
  final int? specialPlanId;
  final String? specialPlanTitle;
  final String? fromDate;
  final String? fromDateJalali;
  final String? toDate;
  final String? toDateJalali;
  final int? seatType;
  final String? seatTypeTitle;
  final int? locationId;
  final String? locationTitle;
  final double? latitude;
  final double? longitude;
  final String? address;
  final bool isActive;
  final int? status;
  final String? statusTitle;
  final int? reasonId;
  final String? reasonTitle;
  final String? description;
  final String? insertUserFullName;
  final String? insertDateTimeJalali;
  final String? updateUserFullName;
  final String? updateDateTimeJalali;
  final List<PlanPersonEntity> emdadUnitPersons;
  final String? emdadUnitPersonNames;
  final Map<String, dynamic> reportFields;

  const PlanInfoEntity({
    this.id,
    this.planId,
    this.title,
    this.emdadUnitId,
    this.emdadUnitName,
    this.shiftId,
    this.shiftTitle,
    this.specialPlanId,
    this.specialPlanTitle,
    this.fromDate,
    this.fromDateJalali,
    this.toDate,
    this.toDateJalali,
    this.seatType,
    this.seatTypeTitle,
    this.locationId,
    this.locationTitle,
    this.latitude,
    this.longitude,
    this.address,
    this.isActive = true,
    this.status,
    this.statusTitle,
    this.reasonId,
    this.reasonTitle,
    this.description,
    this.insertUserFullName,
    this.insertDateTimeJalali,
    this.updateUserFullName,
    this.updateDateTimeJalali,
    this.emdadUnitPersons = const [],
    this.emdadUnitPersonNames,
    this.reportFields = const {},
  });

  int? get resolvedId => id ?? planId;

  String get dateRangeText {
    final start = fromDateJalali ?? fromDate ?? '---';
    final end = toDateJalali ?? toDate ?? '---';
    return '$start تا $end';
  }

  String get personsText {
    final normalizedNames = emdadUnitPersonNames?.trim();
    if (normalizedNames != null && normalizedNames.isNotEmpty) {
      return normalizedNames;
    }

    final names = emdadUnitPersons
        .map((item) => item.fullName?.trim())
        .whereType<String>()
        .where((item) => item.isNotEmpty)
        .join('، ');

    return names.isEmpty ? '---' : names;
  }

  Object? reportValue(String key) {
    if (reportFields.containsKey(key)) return reportFields[key];
    if (key.isEmpty) return null;
    final pascalKey = '${key[0].toUpperCase()}${key.substring(1)}';
    return reportFields[pascalKey];
  }
}
