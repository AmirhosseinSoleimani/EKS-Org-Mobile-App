import 'package:eks_sana_plus_org/src/features/services/data/models/params/cancel_reason_param_model.dart';

class CancelReasonParamEntity {
  final int? reasonId;

  const CancelReasonParamEntity({
    this.reasonId,
  });

  CancelReasonParamModel toModel() {
    return CancelReasonParamModel(
      reasonId: reasonId,
    );
  }

  CancelReasonParamEntity copyWith({
    int? reasonId,
  }) {
    return CancelReasonParamEntity(
      reasonId: reasonId ?? this.reasonId,
    );
  }
}
