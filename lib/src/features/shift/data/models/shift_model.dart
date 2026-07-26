import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';

class ShiftModel extends ShiftEntity {
  const ShiftModel({
    super.id,
    super.title,
    super.type,
    super.typeTitle,
    super.startDate,
    super.startDateJalali,
    super.endDate,
    super.endDateJalali,
    super.startTime,
    super.endTime,
    super.startTimeStr,
    super.endTimeStr,
    super.insertUserFullName,
    super.updateUserFullName,
    super.insertDateTimeJalali,
    super.updateDateTimeJalali,
    super.isActive,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      id: _toInt(_read(json, 'id', 'Id')),
      title: _toString(_read(json, 'title', 'Title')),
      type: _toInt(_read(json, 'type', 'Type')),
      typeTitle: _toString(_read(json, 'typeTitle', 'TypeTitle')),
      startDate: _toString(_read(json, 'startDate', 'StartDate')),
      startDateJalali:
          _toString(_read(json, 'startDateJalali', 'StartDateJalali')),
      endDate: _toString(_read(json, 'endDate', 'EndDate')),
      endDateJalali: _toString(_read(json, 'endDateJalali', 'EndDateJalali')),
      startTime: _toString(_read(json, 'startTime', 'StartTime')),
      endTime: _toString(_read(json, 'endTime', 'EndTime')),
      startTimeStr: _toString(_read(json, 'startTimeStr', 'StartTimeStr')),
      endTimeStr: _toString(_read(json, 'endTimeStr', 'EndTimeStr')),
      insertUserFullName:
          _toString(_read(json, 'insertUserFullName', 'InsertUserFullName')),
      updateUserFullName:
          _toString(_read(json, 'updateUserFullName', 'UpdateUserFullName')),
      insertDateTimeJalali: _toString(
        _read(json, 'insertDateTimeJalali', 'InsertDateTimeJalali'),
      ),
      updateDateTimeJalali: _toString(
        _read(json, 'updateDateTimeJalali', 'UpdateDateTimeJalali'),
      ),
      isActive: _toBool(_read(json, 'isActive', 'IsActive')),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'title': title,
      'type': type,
      'typeTitle': typeTitle,
      'startDate': startDate,
      'startDateJalali': startDateJalali,
      'endDate': endDate,
      'endDateJalali': endDateJalali,
      'startTime': startTime,
      'endTime': endTime,
      'startTimeStr': startTimeStr,
      'endTimeStr': endTimeStr,
      'insertUserFullName': insertUserFullName,
      'updateUserFullName': updateUserFullName,
      'insertDateTimeJalali': insertDateTimeJalali,
      'updateDateTimeJalali': updateDateTimeJalali,
      'isActive': isActive,
    };
  }

  Map<String, dynamic> toMutationJson() {
    return {
      'id': id ?? 0,
      'title': title,
      'type': type,
      'startTime': startTime,
      'endTime': endTime,
      'isActive': isActive,
    };
  }

  static dynamic _read(
    Map<String, dynamic> json,
    String camelCaseKey,
    String pascalCaseKey,
  ) {
    return json[camelCaseKey] ?? json[pascalCaseKey];
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static bool _toBool(dynamic value) {
    if (value is bool) return value;
    if (value == null) return true;
    return value.toString().toLowerCase() == 'true';
  }

  static String? _toString(dynamic value) {
    if (value == null) return null;
    final normalized = value.toString();
    return normalized.trim().isEmpty ? null : normalized;
  }
}
