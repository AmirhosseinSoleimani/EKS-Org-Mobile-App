import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_entity.dart';

class InvoiceAgencyObjectionModel extends InvoiceAgencyObjectionEntity {
  const InvoiceAgencyObjectionModel({
    super.identity,
    super.request,
    super.agency,
    super.review,
    super.audit,
  });

  factory InvoiceAgencyObjectionModel.fromJson(Map<String, dynamic> json) {
    return InvoiceAgencyObjectionModel(
      identity: InvoiceAgencyObjectionIdentityModel.fromJson(json),
      request: InvoiceAgencyObjectionRequestModel.fromJson(json),
      agency: InvoiceAgencyObjectionAgencyModel.fromJson(json),
      review: InvoiceAgencyObjectionReviewModel.fromJson(json),
      audit: InvoiceAgencyObjectionAuditModel.fromJson(json),
    );
  }
}

class InvoiceAgencyObjectionIdentityModel
    extends InvoiceAgencyObjectionIdentityEntity {
  const InvoiceAgencyObjectionIdentityModel({
    super.id,
    super.serviceType,
    super.serviceRequestId,
    super.emdadgarEvaluationId,
    super.invoiceId,
    super.objectionType,
    super.status,
    super.statusTitle,
  });

  factory InvoiceAgencyObjectionIdentityModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InvoiceAgencyObjectionIdentityModel(
      id: JsonValueReader.intValue(json['id']),
      serviceType: JsonValueReader.intValue(json['serviceType']),
      serviceRequestId: JsonValueReader.intValue(json['serviceRequestId']),
      emdadgarEvaluationId:
          JsonValueReader.intValue(json['emdadgarEvaluationId']),
      invoiceId: JsonValueReader.intValue(json['invoiceId']),
      objectionType: JsonValueReader.intValue(json['objectionType']),
      status: JsonValueReader.intValue(json['status']),
      statusTitle: JsonValueReader.stringValue(json['statusTitle']),
    );
  }
}

class InvoiceAgencyObjectionRequestModel
    extends InvoiceAgencyObjectionRequestEntity {
  const InvoiceAgencyObjectionRequestModel({
    super.serviceRequestTrackCode,
    super.emdadkhahFirstName,
    super.emdadkhahLastName,
    super.callMobileNumber,
    super.aidAddress,
    super.carName,
    super.chassisNumber,
    super.description,
  });

  factory InvoiceAgencyObjectionRequestModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InvoiceAgencyObjectionRequestModel(
      serviceRequestTrackCode:
          JsonValueReader.intValue(json['serviceRequestTrackCode']),
      emdadkhahFirstName:
          JsonValueReader.stringValue(json['emdadkhahFirstName']),
      emdadkhahLastName:
          JsonValueReader.stringValue(json['emdadkhahLastName']),
      callMobileNumber: JsonValueReader.stringValue(json['callMobileNumber']),
      aidAddress: JsonValueReader.stringValue(json['aidAddress']),
      carName: JsonValueReader.stringValue(json['carName']),
      chassisNumber: JsonValueReader.stringValue(json['chassisNumber']),
      description: JsonValueReader.stringValue(json['description']),
    );
  }
}

class InvoiceAgencyObjectionAgencyModel
    extends InvoiceAgencyObjectionAgencyEntity {
  const InvoiceAgencyObjectionAgencyModel({
    super.emdadgarInfoId,
    super.siPlanning,
    super.agencyCode,
    super.agencyName,
    super.aidPerCode,
    super.aidPerName,
    super.provinceId,
    super.provinceName,
    super.cityId,
    super.cityName,
  });

  factory InvoiceAgencyObjectionAgencyModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InvoiceAgencyObjectionAgencyModel(
      emdadgarInfoId: JsonValueReader.intValue(json['emdadgarInfoId']),
      siPlanning: JsonValueReader.intValue(json['siPlanning']),
      agencyCode: JsonValueReader.stringValue(json['agencyCode']),
      agencyName: JsonValueReader.stringValue(json['agencyName']),
      aidPerCode: JsonValueReader.stringValue(json['aidPerCode']),
      aidPerName: JsonValueReader.stringValue(json['aidPerName']),
      provinceId: JsonValueReader.intValue(json['provinceId']),
      provinceName: JsonValueReader.stringValue(json['provinceName']),
      cityId: JsonValueReader.intValue(json['cityId']),
      cityName: JsonValueReader.stringValue(json['cityName']),
    );
  }
}

class InvoiceAgencyObjectionReviewModel
    extends InvoiceAgencyObjectionReviewEntity {
  const InvoiceAgencyObjectionReviewModel({
    super.checkAuthorId,
    super.checkAuthorFullName,
    super.checkAuthorDateTime,
    super.checkAuthorDateTimeJalali,
    super.checkAuthorDescription,
  });

  factory InvoiceAgencyObjectionReviewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InvoiceAgencyObjectionReviewModel(
      checkAuthorId: JsonValueReader.intValue(json['checkAuthorId']),
      checkAuthorFullName:
          JsonValueReader.stringValue(json['checkAuthorFullName']),
      checkAuthorDateTime:
          JsonValueReader.dateTimeValue(json['checkAuthorDateTime']),
      checkAuthorDateTimeJalali:
          JsonValueReader.stringValue(json['checkAuthorDateTimeJalali']),
      checkAuthorDescription:
          JsonValueReader.stringValue(json['checkAuthorDescription']),
    );
  }
}

class InvoiceAgencyObjectionAuditModel
    extends InvoiceAgencyObjectionAuditEntity {
  const InvoiceAgencyObjectionAuditModel({
    super.insertDateTime,
    super.insertDateTimeJalali,
  });

  factory InvoiceAgencyObjectionAuditModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InvoiceAgencyObjectionAuditModel(
      insertDateTime: JsonValueReader.dateTimeValue(json['insertDateTime']),
      insertDateTimeJalali:
          JsonValueReader.stringValue(json['insertDateTimeJalali']),
    );
  }
}
