import '../../domain/entities/skill_service_entity.dart';

class SkillServiceModel extends SkillServiceEntity {
  const SkillServiceModel({
    super.id,
    super.title,
    super.type,
    super.selectable,
    super.insertDateTimeJalali,
    super.updateDateTimeJalali,
    super.insertUserFullName,
    super.updateUserFullName,
  });

  factory SkillServiceModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SkillServiceModel();

    return SkillServiceModel(
      id: _asInt(json['id'] ?? json['Id']),
      title: _asString(json['title'] ?? json['Title']),
      type: _asInt(json['type'] ?? json['Type']),
      selectable: _asInt(json['selectable'] ?? json['Selectable']),
      insertDateTimeJalali: _asString(
        json['insertDateTimeJalali'] ?? json['InsertDateTimeJalali'],
      ),
      updateDateTimeJalali: _asString(
        json['updateDateTimeJalali'] ?? json['UpdateDateTimeJalali'],
      ),
      insertUserFullName: _asString(
        json['insertUserFullName'] ?? json['InsertUserFullName'],
      ),
      updateUserFullName: _asString(
        json['updateUserFullName'] ?? json['UpdateUserFullName'],
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

String? _asString(Object? value) {
  if (value == null) return null;
  return value.toString();
}
