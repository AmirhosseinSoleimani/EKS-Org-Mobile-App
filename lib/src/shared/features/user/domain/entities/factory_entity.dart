import 'package:eks_sana_plus_org/src/shared/features/user/data/models/factory_model.dart';

class FactoryEntity {
  const FactoryEntity({
    this.factoryId,
    this.factoryTitle,
  });

  final int? factoryId;
  final String? factoryTitle;

  FactoryModel toModel() {
    return FactoryModel(factoryId: factoryId, factoryTitle: factoryTitle);
  }
}
