import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/params/invoice_agency_objection_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/repositories/invoice_agency_objection_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetInvoiceAgencyObjectionsUseCase {
  const GetInvoiceAgencyObjectionsUseCase(this._repository);

  final InvoiceAgencyObjectionRepository _repository;

  Future<ApiResult<InvoiceAgencyObjectionPageEntity>> call(
    InvoiceAgencyObjectionFilterParamEntity param,
  ) {
    return _repository.getObjections(param);
  }
}
