import 'package:eks_sana_plus_org/src/features/rescuer/data/models/params/get_rescuers_param_model.dart';

class GetRescuersParamEntity {
  final int pageSize;

  const GetRescuersParamEntity({
    required this.pageSize,
  });

  GetRescuersParamModel toModel() {
    return GetRescuersParamModel(pageSize: pageSize);
  }

  GetRescuersParamEntity copyWith({
    int? pageSize,
  }) {
    return GetRescuersParamEntity(
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
