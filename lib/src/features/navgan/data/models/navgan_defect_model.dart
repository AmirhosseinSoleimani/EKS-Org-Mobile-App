import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_defect_entity.dart';

class NavganDefectModel extends NavganDefectEntity {
  const NavganDefectModel({
    super.id,
    super.parentCode,
    super.title,
    super.selected,
    super.isActive,
  });

  factory NavganDefectModel.fromJson(Map<String, dynamic> json) {
    return NavganDefectModel(
      id: NavganJsonHelper.integer(json['id'] ?? json['Id']),
      parentCode:
          NavganJsonHelper.integer(json['parentCode'] ?? json['ParentCode']),
      title: NavganJsonHelper.string(json['title'] ?? json['Title']),
      selected: NavganJsonHelper.boolean(json['selected'] ?? json['Selected']) ??
          false,
      isActive: NavganJsonHelper.boolean(json['isActive'] ?? json['IsActive']),
    );
  }
}
