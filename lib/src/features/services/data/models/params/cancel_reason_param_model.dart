import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_reason_param_entity.dart';

class CancelReasonParamModel extends CancelReasonParamEntity {
  const CancelReasonParamModel({
    required super.type,
    required super.serviceType,
  });

  factory CancelReasonParamModel.fromJson(Map<String, dynamic> json) {
    final filter = json['Filter'] as Map<String, dynamic>?;
    final filters = filter?['Filters'] as List<dynamic>?;
    final typeFilter = filters?.cast<Map<String, dynamic>>().firstWhere(
          (item) => item['Field'] == 'type',
          orElse: () => <String, dynamic>{},
        );

    return CancelReasonParamModel(
      type: int.tryParse(typeFilter?['Value']?.toString() ?? '') ?? 0,
      serviceType: ServiceType.fromValue(json['serviceType'] as int?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Sort': <dynamic>[],
      'Filter': {
        'Logic': 'and',
        'Filters': [
          {
            'Field': 'type',
            'Operator': 'eq',
            'Value': type.toString(),
          },
        ],
      },
      'serviceType': serviceType.value,
    };
  }
}
