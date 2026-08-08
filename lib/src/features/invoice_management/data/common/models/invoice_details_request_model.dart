import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_details_param_entity.dart';

class InvoiceDetailsRequestModel extends InvoiceDetailsParamEntity {
  const InvoiceDetailsRequestModel({
    required super.emdadgarEvaluationId,
    required super.serviceType,
  });

  factory InvoiceDetailsRequestModel.fromEntity(
    InvoiceDetailsParamEntity entity,
  ) {
    return InvoiceDetailsRequestModel(
      emdadgarEvaluationId: entity.emdadgarEvaluationId,
      serviceType: entity.serviceType,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'emdadgarEvaluationId': emdadgarEvaluationId,
      'serviceType': serviceType,
    };
  }
}
