import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_active_vehicle_models_param_entity.dart';

class GetActiveVehicleModelsParamModel
    extends GetActiveVehicleModelsParamEntity {
  const GetActiveVehicleModelsParamModel({
    super.pageSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'Sort': <dynamic>[],
      'Filter': {
        'Logic': 'and',
        'Filters': [
          {
            'Field': 'IsActive',
            'Operator': 'eq',
            'Value': 'true',
          },
        ],
      },
      'Skip': 0,
      'PageSize': pageSize ?? 0,
    };
  }
}
