import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_details_request_model.dart';

class InvoiceDetailsParamEntity {
  const InvoiceDetailsParamEntity({
    this.emdadgarEvaluationId,
    this.serviceType,
  });

  final int? emdadgarEvaluationId;
  final ServiceType? serviceType;

  InvoiceDetailsRequestModel toModel() {
    return InvoiceDetailsRequestModel(
      emdadgarEvaluationId: emdadgarEvaluationId,
      serviceType: serviceType,
    );
  }
}
