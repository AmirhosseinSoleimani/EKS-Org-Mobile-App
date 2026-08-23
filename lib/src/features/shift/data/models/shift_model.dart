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
    final insertDateTime = _toString(
      _readAny(
        json,
        const [
          'insertDateTime',
          'InsertDateTime',
        ],
      ),
    );

    final insertDateTimeJalali = _toString(
      _readAny(
        json,
        const [
          'insertDateTimeJalali',
          'InsertDateTimeJalali',
        ],
      ),
    );

    final updateDateTime = _toString(
      _readAny(
        json,
        const [
          'updateDateTime',
          'UpdateDateTime',
        ],
      ),
    );

    final updateDateTimeJalali = _toString(
      _readAny(
        json,
        const [
          'updateDateTimeJalali',
          'UpdateDateTimeJalali',
        ],
      ),
    );

    final rawStartDate = _toString(
      _readAny(
        json,
        const [
          'startDate',
          'StartDate',
        ],
      ),
    ) ??
        insertDateTime;

    final rawStartDateJalali = _toString(
      _readAny(
        json,
        const [
          'startDateJalali',
          'StartDateJalali',
        ],
      ),
    ) ??
        insertDateTimeJalali;

    final rawEndDate = _toString(
      _readAny(
        json,
        const [
          'endDate',
          'EndDate',
        ],
      ),
    ) ??
        updateDateTime;

    final rawEndDateJalali = _toString(
      _readAny(
        json,
        const [
          'endDateJalali',
          'EndDateJalali',
        ],
      ),
    ) ??
        updateDateTimeJalali;

    final directStartTime = _toString(
      _readAny(
        json,
        const [
          'startTime',
          'StartTime',
        ],
      ),
    );

    final directEndTime = _toString(
      _readAny(
        json,
        const [
          'endTime',
          'EndTime',
        ],
      ),
    );

    final directStartTimeStr = _toString(
      _readAny(
        json,
        const [
          'startTimeStr',
          'StartTimeStr',
        ],
      ),
    );

    final directEndTimeStr = _toString(
      _readAny(
        json,
        const [
          'endTimeStr',
          'EndTimeStr',
        ],
      ),
    );

    final resolvedStartTime = directStartTime ??
        directStartTimeStr ??
        _extractTime(rawStartDateJalali) ??
        _extractTime(rawStartDate);

    final resolvedEndTime = directEndTime ??
        directEndTimeStr ??
        _extractTime(rawEndDateJalali) ??
        _extractTime(rawEndDate);

    return ShiftModel(
      id: _toInt(
        _readAny(
          json,
          const [
            'id',
            'Id',
            'ID',
          ],
        ),
      ),
      title: _toString(
        _readAny(
          json,
          const [
            'title',
            'Title',
          ],
        ),
      ),
      type: _toInt(
        _readAny(
          json,
          const [
            'type',
            'Type',
          ],
        ),
      ),
      typeTitle: _toString(
        _readAny(
          json,
          const [
            'typeTitle',
            'TypeTitle',
          ],
        ),
      ),

      // Backend list response may return these through InsertDateTime.
      startDate: _extractDate(rawStartDate),
      startDateJalali: _extractDate(rawStartDateJalali),

      // Backend list response may return these through UpdateDateTime.
      endDate: _extractDate(rawEndDate),
      endDateJalali: _extractDate(rawEndDateJalali),

      startTime: resolvedStartTime,
      endTime: resolvedEndTime,

      startTimeStr:
      directStartTimeStr ?? _normalizeTime(resolvedStartTime),
      endTimeStr:
      directEndTimeStr ?? _normalizeTime(resolvedEndTime),

      insertUserFullName: _toString(
        _readAny(
          json,
          const [
            'insertUserFullName',
            'InsertUserFullName',
          ],
        ),
      ),
      updateUserFullName: _toString(
        _readAny(
          json,
          const [
            'updateUserFullName',
            'UpdateUserFullName',
          ],
        ),
      ),

      // Audit values are also preserved completely.
      insertDateTimeJalali: insertDateTimeJalali,
      updateDateTimeJalali: updateDateTimeJalali,

      isActive: _toBool(
        _readAny(
          json,
          const [
            'isActive',
            'IsActive',
          ],
        ),
      ),
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

  static dynamic _readAny(
      Map<String, dynamic> json,
      List<String> keys,
      ) {
    for (final key in keys) {
      if (json.containsKey(key) && json[key] != null) {
        return json[key];
      }
    }

    return null;
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;

    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value.toString().trim());
  }

  static bool _toBool(dynamic value) {
    if (value == null) {
      return true;
    }

    if (value is bool) {
      return value;
    }

    if (value is num) {
      return value != 0;
    }

    final normalized = value.toString().trim().toLowerCase();

    if (normalized == 'true' || normalized == '1') {
      return true;
    }

    if (normalized == 'false' || normalized == '0') {
      return false;
    }

    return true;
  }

  static String? _toString(dynamic value) {
    if (value == null) return null;

    final normalized = value.toString().trim();

    return normalized.isEmpty ? null : normalized;
  }

  static String? _extractDate(String? value) {
    final normalized = _toString(value);

    if (normalized == null) {
      return null;
    }

    final dateTime = normalized.replaceFirst('T', ' ');
    final parts = dateTime.split(RegExp(r'\s+'));

    if (parts.isEmpty) {
      return null;
    }

    return _toString(parts.first);
  }

  static String? _extractTime(String? value) {
    final normalized = _toString(value);

    if (normalized == null) {
      return null;
    }

    final dateTime = normalized.replaceFirst('T', ' ');
    final parts = dateTime.split(RegExp(r'\s+'));

    if (parts.length < 2) {
      return null;
    }

    return _normalizeTime(parts[1]);
  }

  static String? _normalizeTime(String? value) {
    final normalized = _toString(value);

    if (normalized == null) {
      return null;
    }

    final match = RegExp(
      r'(\d{1,2}):(\d{2})',
    ).firstMatch(normalized);

    if (match == null) {
      return normalized;
    }

    final hour = match.group(1)!.padLeft(2, '0');
    final minute = match.group(2)!;

    return '$hour:$minute';
  }
}