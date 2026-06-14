import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/emdadgar_evaluation_accept_response_model.dart';

class EmdadgarEvaluationAcceptResponseEntity {
  final ExportUrls? exportUrls;
  final String? invoiceGuid;

  EmdadgarEvaluationAcceptResponseEntity({this.exportUrls, this.invoiceGuid});

  EmdadgarEvaluationAcceptResponseModel toModel() {
    return EmdadgarEvaluationAcceptResponseModel(
      exportUrls: exportUrls,
      invoiceGuid: invoiceGuid,
    );
  }
}
