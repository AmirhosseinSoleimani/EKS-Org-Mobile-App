import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';

class CurrentSessionEnumItemModel extends CurrentSessionEnumItemEntity {
  const CurrentSessionEnumItemModel({super.name, super.title, super.value});

  factory CurrentSessionEnumItemModel.fromJson(Map<String, dynamic> json) {
    return CurrentSessionEnumItemModel(
      name: _read(json, 'name')?.toString(),
      title: _read(json, 'title')?.toString(),
      value: _toInt(_read(json, 'value')),
    );
  }

  static dynamic _read(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) return json[key];

    final normalizedKey = key.toLowerCase();
    for (final entry in json.entries) {
      if (entry.key.toLowerCase() == normalizedKey) {
        return entry.value;
      }
    }

    return null;
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}
