import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/non_cooperation_param_entity.dart';

class NonCooperationParamModel extends NonCooperationParamEntity {
  const NonCooperationParamModel({
    required super.serviceType,
    required super.requestId,
    super.pageSize,
    super.page,
  });

  factory NonCooperationParamModel.fromJson(Map<String, dynamic> json) {
    return NonCooperationParamModel(
      serviceType: json['serviceType'],
      requestId: json['serviceRequestId'],
      pageSize: json['pageSize'],
      page: json['page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "serviceType": serviceType.value,
      "serviceRequestId": requestId,
      "pageSize": pageSize,
      "page": page,
    };
  }
}
