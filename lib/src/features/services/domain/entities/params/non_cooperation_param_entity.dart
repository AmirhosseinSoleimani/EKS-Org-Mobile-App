import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/non_cooperation_param_model.dart';

class NonCooperationParamEntity {
  final ServiceType serviceType;
  final int requestId;
  final int? pageSize;
  final int? page;

  const NonCooperationParamEntity({
    required this.serviceType,
   required this.requestId,
    this.pageSize,
    this.page,
  });

  NonCooperationParamEntity copyWith({
    ServiceType? serviceType,
    int? requestId,
    int? pageSize,
    int? page,
  }) {
    return NonCooperationParamEntity(
      serviceType: serviceType ?? this.serviceType,
      requestId: requestId ?? this.requestId,
      pageSize: pageSize ?? this.pageSize,
      page: page ?? this.page,
    );
  }

  NonCooperationParamModel toModel() {
    return NonCooperationParamModel(
      serviceType: serviceType,
      requestId: requestId,
      pageSize: pageSize,
      page: page,
    );
  }
}
