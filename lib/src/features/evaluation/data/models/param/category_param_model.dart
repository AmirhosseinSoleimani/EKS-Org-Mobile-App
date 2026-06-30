import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';

class CategoryParamModel extends CategoryParamEntity {
  CategoryParamModel({required super.planningId, required super.serviceType});

  Map<String, dynamic> toJson() => {
    "planningId": planningId,
    "ServiceType": serviceType.value,
  };
}
