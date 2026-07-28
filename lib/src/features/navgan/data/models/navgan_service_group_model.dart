import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_service_group_entity.dart';

class EmdadServiceCategoryModel extends EmdadServiceCategoryEntity {
  const EmdadServiceCategoryModel({
    super.id,
    super.title,
    super.serviceTypeId,
    super.serviceTypeTitle,
    super.selected,
  });

  factory EmdadServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return EmdadServiceCategoryModel(
      id: NavganJsonHelper.integer(json['id'] ?? json['Id']),
      title: NavganJsonHelper.string(json['title'] ?? json['Title']),
      serviceTypeId: NavganJsonHelper.integer(
        json['serviceTypeId'] ?? json['ServiceTypeId'],
      ),
      serviceTypeTitle: NavganJsonHelper.string(
        json['serviceTypeTitle'] ?? json['ServiceTypeTitle'],
      ),
      selected: NavganJsonHelper.boolean(json['selected'] ?? json['Selected']) ??
          false,
    );
  }
}

class NavganServiceGroupModel extends NavganServiceGroupEntity {
  const NavganServiceGroupModel({
    super.serviceType,
    super.serviceTypeTitle,
    super.emdadCategories,
  });

  factory NavganServiceGroupModel.fromJson(Map<String, dynamic> json) {
    final categories = NavganJsonHelper.mapList(
      json['emdadCategories'] ?? json['EmdadCategories'],
    ).map(EmdadServiceCategoryModel.fromJson).toList();

    return NavganServiceGroupModel(
      serviceType: NavganJsonHelper.integer(
        json['serviceType'] ?? json['ServiceType'],
      ),
      serviceTypeTitle: NavganJsonHelper.string(
        json['serviceTypeTitle'] ?? json['ServiceTypeTitle'],
      ),
      emdadCategories: categories,
    );
  }
}
