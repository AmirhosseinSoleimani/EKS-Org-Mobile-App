
import '../../data/models/current_session_enum_item_model.dart';

class CurrentSessionEnumItemEntity {
  final String? name;
  final String? title;
  final int? value;

  const CurrentSessionEnumItemEntity({
    this.name,
    this.title,
    this.value,
  });

  CurrentSessionEnumItemEntity copyWith({
    String? name,
    String? title,
    int? value,
  }) {
    return CurrentSessionEnumItemEntity(
      name: name ?? this.name,
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }

  CurrentSessionEnumItemModel toModel() {
    return CurrentSessionEnumItemModel(
      name: name,
      title: title,
      value: value,
    );
  }
}
