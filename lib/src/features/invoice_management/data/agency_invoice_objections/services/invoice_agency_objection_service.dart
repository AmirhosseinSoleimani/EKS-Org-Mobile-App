import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/emdadgar_assignment_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_filter_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_page_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_compact_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_operation_access_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InvoiceAgencyObjectionService {
  const InvoiceAgencyObjectionService(this._dio);

  final Dio _dio;

  ///real method
  /*
  Future<InvoiceAgencyObjectionPageModel> getObjections(
    InvoiceAgencyObjectionFilterParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/InvoiceAgencyObjection/GetByFilterJson',
      data: request.toJson(),
    );
    return InvoiceAgencyObjectionPageModel.fromResponse(response.data);
  }
  */

  ///fake method
  Future<InvoiceAgencyObjectionPageModel> getObjections(
    InvoiceAgencyObjectionFilterParamModel request,
  ) async {
    if ((request.skip ?? 0) > 0) {
      return const InvoiceAgencyObjectionPageModel(
        records: [],
        count: 3,
      );
    }

    return const InvoiceAgencyObjectionPageModel(
      count: 3,
      records: [
        InvoiceAgencyObjectionModel(
          identity: InvoiceAgencyObjectionIdentityModel(
            id: 101,
            serviceType: 1,
            serviceRequestId: 140501,
            emdadgarEvaluationId: 8101,
            invoiceId: 9101,
            objectionType: 1,
            status: 0,
            statusTitle: 'در انتظار بررسی',
          ),
          request: InvoiceAgencyObjectionRequestModel(
            serviceRequestTrackCode: 140501,
            emdadkhahFirstName: 'علی',
            emdadkhahLastName: 'رضایی',
            callMobileNumber: '09121234567',
            aidAddress: 'تهران، خیابان آزادی',
            carName: 'شاهین',
            chassisNumber: 'CH-140501',
            description: 'درخواست اصلاح مبلغ سرویس ثبت شده است.',
          ),
          agency: InvoiceAgencyObjectionAgencyModel(
            emdadgarInfoId: 501,
            agencyCode: '1001',
            agencyName: 'نمایندگی مرکزی تهران',
            aidPerCode: 'E101',
            aidPerName: 'حسین احمدی',
            provinceName: 'تهران',
            cityName: 'تهران',
          ),
          review: InvoiceAgencyObjectionReviewModel(
            checkAuthorFullName: '---',
            checkAuthorDescription: 'در انتظار بررسی کارشناس',
          ),
          audit: InvoiceAgencyObjectionAuditModel(
            insertDateTimeJalali: '1405/05/18 - 09:15',
          ),
        ),
        InvoiceAgencyObjectionModel(
          identity: InvoiceAgencyObjectionIdentityModel(
            id: 102,
            serviceType: 1,
            serviceRequestId: 140502,
            emdadgarEvaluationId: 8102,
            invoiceId: 9102,
            objectionType: 1,
            status: 1,
            statusTitle: 'تایید شده',
          ),
          request: InvoiceAgencyObjectionRequestModel(
            serviceRequestTrackCode: 140502,
            emdadkhahFirstName: 'مریم',
            emdadkhahLastName: 'کاظمی',
            callMobileNumber: '09123334455',
            aidAddress: 'کرج، بلوار جمهوری',
            carName: 'کوییک',
            chassisNumber: 'CH-140502',
            description: 'اصلاح اطلاعات سرویس مورد تایید قرار گرفت.',
          ),
          agency: InvoiceAgencyObjectionAgencyModel(
            emdadgarInfoId: 502,
            agencyCode: '2045',
            agencyName: 'نمایندگی سایپا البرز',
            aidPerCode: 'E202',
            aidPerName: 'رضا محمدی',
            provinceName: 'البرز',
            cityName: 'کرج',
          ),
          review: InvoiceAgencyObjectionReviewModel(
            checkAuthorId: 71,
            checkAuthorFullName: 'کارشناس مالی',
            checkAuthorDateTimeJalali: '1405/05/18 - 11:40',
            checkAuthorDescription: 'درخواست بررسی و تایید شد.',
          ),
          audit: InvoiceAgencyObjectionAuditModel(
            insertDateTimeJalali: '1405/05/17 - 16:20',
          ),
        ),
        InvoiceAgencyObjectionModel(
          identity: InvoiceAgencyObjectionIdentityModel(
            id: 103,
            serviceType: 2,
            serviceRequestId: 140503,
            emdadgarEvaluationId: 8103,
            invoiceId: 9103,
            objectionType: 2,
            status: 2,
            statusTitle: 'رد شده',
          ),
          request: InvoiceAgencyObjectionRequestModel(
            serviceRequestTrackCode: 140503,
            emdadkhahFirstName: 'محمد',
            emdadkhahLastName: 'حسینی',
            callMobileNumber: '09125556677',
            aidAddress: 'قم، بلوار امین',
            carName: 'اطلس',
            chassisNumber: 'CH-140503',
            description: 'درخواست اصلاح به دلیل مغایرت اطلاعات رد شد.',
          ),
          agency: InvoiceAgencyObjectionAgencyModel(
            emdadgarInfoId: 503,
            agencyCode: '3078',
            agencyName: 'نمایندگی قم',
            aidPerCode: 'E303',
            aidPerName: 'امیر کریمی',
            provinceName: 'قم',
            cityName: 'قم',
          ),
          review: InvoiceAgencyObjectionReviewModel(
            checkAuthorId: 72,
            checkAuthorFullName: 'کارشناس ارزیابی',
            checkAuthorDateTimeJalali: '1405/05/18 - 13:05',
            checkAuthorDescription: 'اطلاعات درخواست با ارزیابی ثبت شده مطابقت ندارد.',
          ),
          audit: InvoiceAgencyObjectionAuditModel(
            insertDateTimeJalali: '1405/05/16 - 10:30',
          ),
        ),
      ],
    );
  }

  Future<EmdadgarAssignmentModel?> getEmdadgar(
    ServiceRequestParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/NewEmdadgar/GetEmdadgarByServiceRequestId',
      data: request.toJson(),
    );
    final data = ResponseJsonReader.object(response.data);
    return data.isEmpty ? null : EmdadgarAssignmentModel.fromJson(data);
  }

  Future<InvoiceAgencyObjectionModel> getObjection(
    ServiceRequestParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/InvoiceAgencyObjection/GetInvoiceAgencyObjectionByServiceRequestId',
      data: request.toJson(),
    );
    return InvoiceAgencyObjectionModel.fromJson(
      ResponseJsonReader.object(response.data),
    );
  }

  Future<ServiceRequestCompactModel?> getServiceRequest(
    ServiceRequestParamModel request,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/AidServiceRequest/GetServiceRequestCompactById',
      queryParameters: <String, dynamic>{
        'serviceRequestId': request.serviceRequestId,
      },
    );
    final data = ResponseJsonReader.object(response.data);
    return data.isEmpty ? null : ServiceRequestCompactModel.fromJson(data);
  }

  Future<ServiceRequestOperationAccessModel> getOperationAccess() async {
    final response = await _dio.get<dynamic>(
      '/api/AidServiceRequest/GetServiceRequestOperationAccess',
    );
    return ServiceRequestOperationAccessModel.fromJson(
      ResponseJsonReader.object(response.data),
    );
  }
}
