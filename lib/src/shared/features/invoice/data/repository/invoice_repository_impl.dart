import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/remote/data_source/invoice_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/params/service_invoice_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/repository/invoice_repository.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: InvoiceRepository)
class InvoiceRepositoryImpl extends InvoiceRepository {
  final InvoiceDataSource _dataSource;

  InvoiceRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<InvoiceEntity?>> getPreInvoice(
      ServiceInvoiceParamEntity? entity) async {
    try {
      final result = await _dataSource.getPreInvoice(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<InvoiceEntity?>> getEmdadgardInvoice(
      ServiceInvoiceParamEntity? entity) async {
    try {
      final result = await _dataSource.getEmdadgarInvoice(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<InvoiceEntity?>> customerPreInvoiceOnTheFly(
      AcceptEvaluationParamEntity param) async {
    try {
      final result = await _dataSource.customerPreInvoiceOnTheFly(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
