import 'package:eks_sana_plus_org/src/features/shift/data/models/shift_model.dart';

class ShiftEntity {
  const ShiftEntity({
    this.id,
    this.title,
    this.type,
    this.typeTitle,
    this.startDate,
    this.startDateJalali,
    this.endDate,
    this.endDateJalali,
    this.startTime,
    this.endTime,
    this.startTimeStr,
    this.endTimeStr,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTimeJalali,
    this.updateDateTimeJalali,
    this.isActive = true,
  });

  final int? id;
  final String? title;
  final int? type;
  final String? typeTitle;
  final String? startDate;
  final String? startDateJalali;
  final String? endDate;
  final String? endDateJalali;
  final String? startTime;
  final String? endTime;
  final String? startTimeStr;
  final String? endTimeStr;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTimeJalali;
  final String? updateDateTimeJalali;
  final bool isActive;

  ShiftEntity copyWith({
    int? id,
    String? title,
    int? type,
    String? typeTitle,
    String? startDate,
    String? startDateJalali,
    String? endDate,
    String? endDateJalali,
    String? startTime,
    String? endTime,
    String? startTimeStr,
    String? endTimeStr,
    String? insertUserFullName,
    String? updateUserFullName,
    String? insertDateTimeJalali,
    String? updateDateTimeJalali,
    bool? isActive,
  }) {
    return ShiftEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      typeTitle: typeTitle ?? this.typeTitle,
      startDate: startDate ?? this.startDate,
      startDateJalali: startDateJalali ?? this.startDateJalali,
      endDate: endDate ?? this.endDate,
      endDateJalali: endDateJalali ?? this.endDateJalali,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startTimeStr: startTimeStr ?? this.startTimeStr,
      endTimeStr: endTimeStr ?? this.endTimeStr,
      insertUserFullName: insertUserFullName ?? this.insertUserFullName,
      updateUserFullName: updateUserFullName ?? this.updateUserFullName,
      insertDateTimeJalali:
          insertDateTimeJalali ?? this.insertDateTimeJalali,
      updateDateTimeJalali:
          updateDateTimeJalali ?? this.updateDateTimeJalali,
      isActive: isActive ?? this.isActive,
    );
  }

  ShiftModel toModel() {
    return ShiftModel(
      id: id,
      title: title,
      type: type,
      typeTitle: typeTitle,
      startDate: startDate,
      startDateJalali: startDateJalali,
      endDate: endDate,
      endDateJalali: endDateJalali,
      startTime: startTime,
      endTime: endTime,
      startTimeStr: startTimeStr,
      endTimeStr: endTimeStr,
      insertUserFullName: insertUserFullName,
      updateUserFullName: updateUserFullName,
      insertDateTimeJalali: insertDateTimeJalali,
      updateDateTimeJalali: updateDateTimeJalali,
      isActive: isActive,
    );
  }
}
