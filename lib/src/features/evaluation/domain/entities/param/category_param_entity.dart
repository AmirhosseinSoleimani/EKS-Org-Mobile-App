import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/category_param_model.dart';

class CategoryParamEntity {
  final int planningId;
  final ServiceType serviceType;

  CategoryParamEntity({required this.planningId, required this.serviceType});

  CategoryParamEntity copyWith({int? planningId, ServiceType? serviceType}) {
    return CategoryParamEntity(
      planningId: planningId ?? this.planningId,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  CategoryParamModel toModel() {
    return CategoryParamModel(planningId: planningId, serviceType: serviceType);
  }
}
