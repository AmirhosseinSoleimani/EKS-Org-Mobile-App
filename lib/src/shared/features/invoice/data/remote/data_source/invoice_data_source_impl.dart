import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/accept_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/params/service_invoice_param_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/remote/data_source/invoice_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/remote/service/invoice_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InvoiceDataSource)
class InvoiceDataSourceImpl extends InvoiceDataSource {
  final InvoiceService _service;

  InvoiceDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<InvoiceModel?>> getPreInvoice(
      ServiceInvoiceParamModel? param) async {
    final result = await _service.getPreInvoice(param?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseSingleResponse<InvoiceModel?>> getEmdadgarInvoice(
          ServiceInvoiceParamModel? param) async =>
      await _service.getEmdadgarInvoice(param?.toJson() ?? {});

  @override
  Future<BaseSingleResponse<InvoiceModel?>> customerPreInvoiceOnTheFly(
      AcceptEvaluationParamModel param) async =>
      await _service.customerPreInvoiceOnTheFly(param.toJson());
}
