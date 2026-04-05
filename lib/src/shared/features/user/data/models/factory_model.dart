import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/factory_entity.dart';

class FactoryModel extends FactoryEntity {
  FactoryModel({
    super.factoryId,
    super.factoryTitle,
  });

  factory FactoryModel.fromJson(Map<String, dynamic> json) {
    return FactoryModel(
      factoryId: json['id'],
      factoryTitle: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': factoryId,
        'title': factoryTitle,
      };
}
