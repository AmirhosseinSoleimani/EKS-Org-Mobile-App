import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_menu_entity.dart';

class CurrentSessionMenuModel extends CurrentSessionMenuEntity {
  const CurrentSessionMenuModel({
    super.code,
    super.title,
    super.url,
    super.icon,
    super.children,
  });

  factory CurrentSessionMenuModel.fromJson(Map<String, dynamic> json) {
    return CurrentSessionMenuModel(
      code: json['code']?.toString(),
      title: json['title']?.toString(),
      url: json['url']?.toString(),
      icon: json['icon']?.toString(),
      children: (json['children'] as List?)
          ?.whereType<Map<String, dynamic>>()
          .map(CurrentSessionMenuModel.fromJson)
          .toList(),
    );
  }
}
