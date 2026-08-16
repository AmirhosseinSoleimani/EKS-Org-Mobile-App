import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_details_param_entity.dart';

class InvoiceDetailsRequestModel extends InvoiceDetailsParamEntity {
  const InvoiceDetailsRequestModel({
    super.emdadgarEvaluationId,
    super.serviceType,
  });

  factory InvoiceDetailsRequestModel.fromEntity(
    InvoiceDetailsParamEntity entity,
  ) => entity.toModel();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'emdadgarEvaluationId': emdadgarEvaluationId,
      'serviceType': serviceType?.value,
    };
  }
}
