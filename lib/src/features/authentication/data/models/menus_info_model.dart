import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/menus_info_entity.dart';

class MenusInfoModel extends MenuInfoEntity {
  MenusInfoModel({
    super.id,
    super.parentId,
    super.code,
    super.title,
    super.url,
    super.icon,
    super.children,
  });

  factory MenusInfoModel.fromJson(Map<String, dynamic> json) {
    return MenusInfoModel(
      id: json['id'],
      parentId: json['parentId'],
      code: json['code'],
      title: json['title'],
      url: json['url'],
      icon: json['icon'],
      children: json['children'] == null ? [] : List<MenusInfoModel>.from(
        json['children'].map((item) => MenusInfoModel.fromJson(item),
        ),
      ),
    );
  }
}