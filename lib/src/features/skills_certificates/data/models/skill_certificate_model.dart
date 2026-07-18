import '../../domain/entities/skill_certificate_entity.dart';

class SkillCertificateListModel extends SkillCertificateListEntity {
  const SkillCertificateListModel({
    required super.items,
    required super.totalCount,
  });

  factory SkillCertificateListModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const SkillCertificateListModel(items: [], totalCount: 0);
    }

    final rawRecords = json['records'] ?? json['Records'];

    return SkillCertificateListModel(
      items: rawRecords is List
          ? rawRecords
              .whereType<Map<String, dynamic>>()
              .map(SkillCertificateModel.fromJson)
              .toList()
          : const [],
      totalCount: _asInt(json['count'] ?? json['Count']) ?? 0,
    );
  }
}

class SkillCertificateModel extends SkillCertificateEntity {
  const SkillCertificateModel({
    super.id,
    super.title,
    super.isActive,
    super.insertUserFullName,
    super.updateUserFullName,
    super.insertDateTimeJalali,
    super.updateDateTimeJalali,
  });

  factory SkillCertificateModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SkillCertificateModel();

    return SkillCertificateModel(
      id: _asInt(json['id'] ?? json['Id']),
      title: _asString(json['title'] ?? json['Title']),
      isActive: _asBool(json['isActive'] ?? json['IsActive']) ?? false,
      insertUserFullName: _asString(
        json['insertUserFullName'] ?? json['InsertUserFullName'],
      ),
      updateUserFullName: _asString(
        json['updateUserFullName'] ?? json['UpdateUserFullName'],
      ),
      insertDateTimeJalali: _asString(
        json['insertDateTimeJalali'] ?? json['InsertDateTimeJalali'],
      ),
      updateDateTimeJalali: _asString(
        json['updateDateTimeJalali'] ?? json['UpdateDateTimeJalali'],
      ),
    );
  }
}

int? _asInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
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
