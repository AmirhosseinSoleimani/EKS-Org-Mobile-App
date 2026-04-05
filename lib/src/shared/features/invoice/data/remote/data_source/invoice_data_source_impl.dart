import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/confirm_invoice_request_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/confirm_invoice_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/service_invoice_request_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/remote/data_source/invoice_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/remote/service/invoice_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InvoiceDataSource)
class InvoiceDataSourceImpl extends InvoiceDataSource {
  final InvoiceService _service;

  InvoiceDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<InvoiceResponseModel?>> fetchInvoice(ServiceInvoiceRequestModel? model) async{
    final result = await _service.fetchInvoice(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseSingleResponse<InvoiceResponseModel?>> fetchPreInvoice(ServiceInvoiceRequestModel? model) async{
    final result = await _service.fetchPreInvoice(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseSingleResponse<InvoiceResponseModel?>> fetchPreInvoiceOnTheFly(ServiceInvoiceRequestModel? model) async{
    final result = await _service.fetchPreInvoiceOnTheFly(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseSingleResponse<ConfirmInvoiceResponseModel?>> confirmHomeServiceInvoice(ConfirmInvoiceRequestModel? model) async{
    final result = await _service.confirmHomeServiceInvoice(model?.toJson() ?? {});
    return result;
  }

}
