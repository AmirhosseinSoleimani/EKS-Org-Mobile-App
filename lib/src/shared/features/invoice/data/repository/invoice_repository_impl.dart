import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/remote/data_source/invoice_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/confirm_invoice_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/confirm_invoice_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/service_invoice_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/repository/invoice_repository.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: InvoiceRepository)
class InvoiceRepositoryImpl extends InvoiceRepository {
  final InvoiceDataSource _dataSource;

  InvoiceRepositoryImpl(this._dataSource);


  @override
  Future<ApiResult<InvoiceResponseEntity?>> fetchInvoice(ServiceInvoiceRequestEntity? entity) async{
    try {
      final result =
      await _dataSource.fetchInvoice(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<InvoiceResponseEntity?>> fetchPreInvoice(ServiceInvoiceRequestEntity? entity) async{
    try {
      final result = await _dataSource.fetchPreInvoice(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<InvoiceResponseEntity?>> fetchPreInvoiceOnTheFly(ServiceInvoiceRequestEntity? entity) async{
    try {
      final result = await _dataSource.fetchPreInvoiceOnTheFly(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ConfirmInvoiceResponseEntity?>> confirmHomeServiceInvoice(ConfirmHomeServiceRequest? entity) async{
    try {
      final result = await _dataSource.confirmHomeServiceInvoice(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
