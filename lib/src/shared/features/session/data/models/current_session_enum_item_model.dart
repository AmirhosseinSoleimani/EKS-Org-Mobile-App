import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';

class CurrentSessionEnumItemModel extends CurrentSessionEnumItemEntity {
  const CurrentSessionEnumItemModel({super.name, super.title, super.value});

  factory CurrentSessionEnumItemModel.fromJson(Map<String, dynamic> json) {
    return CurrentSessionEnumItemModel(
      name: json['name']?.toString(),
      title: json['title']?.toString(),
      value: _toInt(json['value']),
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}
