
import 'package:eks_sana_plus_org/src/features/authentication/data/models/menus_info_model.dart';

class MenuInfoEntity {
  const MenuInfoEntity({
    this.id,
    this.parentId,
    this.code,
    this.title,
    this.url,
    this.icon,
    this.children = const [],
  });

  final int? id;
  final int? parentId;
  final String? code;
  final String? title;
  final String? url;
  final String? icon;
  final List<MenuInfoEntity> children;

  MenuInfoEntity copyWith({
    int? id,
    int? parentId,
    String? code,
    String? title,
    String? url,
    String? icon,
    List<MenuInfoEntity>? children,
  }) {
    return MenuInfoEntity(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      code: code ?? this.code,
      title: title ?? this.title,
      url: url ?? this.url,
      icon: icon ?? this.icon,
      children: children ?? this.children,
    );
  }

  MenusInfoModel toModel() {
    return MenusInfoModel(
      id: id,
      parentId: parentId,
      code: code,
      title: title,
      url: url,
      icon: icon,
      children: children.map((e) => e.toModel()).toList(),
    );
  }
}