import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/get_rescuers_param_entity.dart';

class GetRescuersParamModel extends GetRescuersParamEntity {
  const GetRescuersParamModel({
    required super.pageSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'Sort': <dynamic>[],
      'Filter': {
        'Logic': 'and',
        'Filters': <dynamic>[],
      },
      'Skip': 0,
      'PageSize': pageSize,
    };
  }
}
