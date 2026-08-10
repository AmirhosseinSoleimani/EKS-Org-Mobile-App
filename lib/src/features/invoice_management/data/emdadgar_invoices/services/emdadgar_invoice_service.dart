import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_details_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_list_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_result_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_invoice_page_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EmdadgarInvoiceService {
  const EmdadgarInvoiceService(this._dio);

  final Dio _dio;

  ///real method
  /*
  Future<EmdadgarInvoicePageModel> getInitialInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportEmdadgarPreInvoice',
      data: request.toJson(),
    );
    return EmdadgarInvoicePageModel.fromResponse(response.data);
  }
  */

  ///fake method
  Future<EmdadgarInvoicePageModel> getInitialInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    return _fakeInvoicePage();
  }

  Future<BaseSingleResponse<InvoiceModel?>> getInitialInvoiceDetails(
    InvoiceDetailsRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/EmdadgarPreInvoice',
      data: request.toJson(),
    );
    final data = ResponseJsonReader.object(response.data);
    return BaseSingleResponse<InvoiceModel?>(
      resultCode: ResponseJsonReader.resultCode(response.data),
      data: data.isEmpty ? null : InvoiceModel.fromJson(data),
      failures: ResponseJsonReader.failures(response.data),
    );
  }

  Future<BulkInvoiceAcceptResultModel> acceptInitialInvoices(
    BulkInvoiceAcceptParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/AidServiceEvaluation/BulkInvoiceOperatorInvoiceAccept',
      data: request.toJson(),
    );
    return BulkInvoiceAcceptResultModel.fromResponse(response.data);
  }

  ///real method
  /*
  Future<EmdadgarInvoicePageModel> getInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportEmdadgarInvoice',
      data: request.toJson(),
    );
    return EmdadgarInvoicePageModel.fromResponse(response.data);
  }
  */

  ///fake method
  Future<EmdadgarInvoicePageModel> getInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    return _fakeInvoicePage();
  }

  Future<BulkInvoiceAcceptResultModel> acceptInvoices(
    BulkInvoiceAcceptParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/AidServiceEvaluation/BulkAdminOperatorInvoiceAccept',
      data: request.toJson(),
    );
    return BulkInvoiceAcceptResultModel.fromResponse(response.data);
  }

  ///real method
  /*
  Future<EmdadgarInvoicePageModel> getFinalApprovalInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportEmdadgarAmaliatFinalInvoice',
      data: request.toJson(),
    );
    return EmdadgarInvoicePageModel.fromResponse(response.data);
  }
  */

  ///fake method
  Future<EmdadgarInvoicePageModel> getFinalApprovalInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    return _fakeInvoicePage();
  }

  ///real method
  /*
  Future<EmdadgarInvoicePageModel> getFinalCorrectionInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportEmdadgarFinalInvoice',
      data: request.toJson(),
    );
    return EmdadgarInvoicePageModel.fromResponse(response.data);
  }
  */

  ///fake method
  Future<EmdadgarInvoicePageModel> getFinalCorrectionInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    return _fakeInvoicePage();
  }

  ///real method
  /*
  Future<EmdadgarInvoicePageModel> getDefiniteInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportEmdadgarDefiniteInvoice',
      data: request.toJson(),
    );
    return EmdadgarInvoicePageModel.fromResponse(response.data);
  }
  */

  ///fake method
  Future<EmdadgarInvoicePageModel> getDefiniteInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    return _fakeInvoicePage();
  }

  EmdadgarInvoicePageModel _fakeInvoicePage() {
    final records = <Map<String, dynamic>>[
      {
        'id': 1,
        'invoiceId': 91001,
        'serviceRequestId': 12001,
        'requestTrackCode': 14020175001,
        'evaluationId': 81001,
        'requestDateTimeJalali': '1405/05/19 10:30:00',
        'customerInvoiceDateTimeJalali': '1405/05/19 10:34:00',
        'emdadkhahFirstName': 'اصغر',
        'emdadkhahLastName': 'سعیدی نیکو',
        'agencyName': 'ابراهیم فرجی',
        'agencyCode': '687',
        'emdadgarName': 'محمد حسینی',
        'invoiceStatusTitle': 'ارزیابی شده',
        'ownerTypeTitle': 'نماینده',
        'subscription': true,
        'isGaranty': true,
        'serviceType': 1,
        'companyTotalPrice': 28500000,
        'emdadgarTotalPrice': 28500000,
        'insertUserName': 'امیر حسینی',
        'insertDateTimeJalali': '1405/05/19 10:35:00',
      },
      {
        'id': 2,
        'invoiceId': 91002,
        'serviceRequestId': 12002,
        'requestTrackCode': 14020175002,
        'evaluationId': 81002,
        'requestDateTimeJalali': '1405/05/18 14:20:00',
        'customerInvoiceDateTimeJalali': '1405/05/18 14:26:00',
        'emdadkhahFirstName': 'مریم',
        'emdadkhahLastName': 'احمدی',
        'agencyName': 'نمایندگی آزادی',
        'agencyCode': '421',
        'emdadgarName': 'علی رضایی',
        'invoiceStatusTitle': 'در انتظار بررسی',
        'ownerTypeTitle': 'نماینده',
        'subscription': false,
        'isGaranty': true,
        'serviceType': 1,
        'companyTotalPrice': 16450000,
        'emdadgarTotalPrice': 16450000,
        'insertUserName': 'رضا اکبری',
        'insertDateTimeJalali': '1405/05/18 14:28:00',
      },
      {
        'id': 3,
        'invoiceId': 91003,
        'serviceRequestId': 12003,
        'requestTrackCode': 14020175003,
        'evaluationId': 81003,
        'requestDateTimeJalali': '1405/05/17 09:10:00',
        'customerInvoiceDateTimeJalali': '1405/05/17 09:14:00',
        'emdadkhahFirstName': 'حسین',
        'emdadkhahLastName': 'کریمی',
        'agencyName': 'نمایندگی مرکزی',
        'agencyCode': '105',
        'emdadgarName': 'سعید محمدی',
        'invoiceStatusTitle': 'تایید شده',
        'ownerTypeTitle': 'نماینده',
        'subscription': true,
        'isGaranty': false,
        'serviceType': 1,
        'companyTotalPrice': 39700000,
        'emdadgarTotalPrice': 39700000,
        'insertUserName': 'مهدی احمدپور',
        'insertDateTimeJalali': '1405/05/17 09:16:00',
      },
    ];

    return EmdadgarInvoicePageModel.fromResponse({
      'data': {
        'records': records,
        'count': records.length,
      },
    });
  }

}
