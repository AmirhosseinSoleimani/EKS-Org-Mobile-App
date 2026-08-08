import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_model.dart';

class InvoiceAgencyObjectionEntity {
  const InvoiceAgencyObjectionEntity({
    this.identity,
    this.request,
    this.agency,
    this.review,
    this.audit,
  });

  final InvoiceAgencyObjectionIdentityEntity? identity;
  final InvoiceAgencyObjectionRequestEntity? request;
  final InvoiceAgencyObjectionAgencyEntity? agency;
  final InvoiceAgencyObjectionReviewEntity? review;
  final InvoiceAgencyObjectionAuditEntity? audit;

  bool get exists => (identity?.id ?? 0) > 0;

  InvoiceAgencyObjectionModel toModel() {
    return InvoiceAgencyObjectionModel(
      identity: identity?.toModel(),
      request: request?.toModel(),
      agency: agency?.toModel(),
      review: review?.toModel(),
      audit: audit?.toModel(),
    );
  }
}

class InvoiceAgencyObjectionIdentityEntity {
  const InvoiceAgencyObjectionIdentityEntity({
    this.id,
    this.serviceType,
    this.serviceRequestId,
    this.emdadgarEvaluationId,
    this.invoiceId,
    this.objectionType,
    this.status,
    this.statusTitle,
  });

  final int? id;
  final int? serviceType;
  final int? serviceRequestId;
  final int? emdadgarEvaluationId;
  final int? invoiceId;
  final int? objectionType;
  final int? status;
  final String? statusTitle;

  InvoiceAgencyObjectionIdentityModel toModel() {
    return InvoiceAgencyObjectionIdentityModel(
      id: id,
      serviceType: serviceType,
      serviceRequestId: serviceRequestId,
      emdadgarEvaluationId: emdadgarEvaluationId,
      invoiceId: invoiceId,
      objectionType: objectionType,
      status: status,
      statusTitle: statusTitle,
    );
  }
}

class InvoiceAgencyObjectionRequestEntity {
  const InvoiceAgencyObjectionRequestEntity({
    this.serviceRequestTrackCode,
    this.emdadkhahFirstName,
    this.emdadkhahLastName,
    this.callMobileNumber,
    this.aidAddress,
    this.carName,
    this.chassisNumber,
    this.description,
  });

  final int? serviceRequestTrackCode;
  final String? emdadkhahFirstName;
  final String? emdadkhahLastName;
  final String? callMobileNumber;
  final String? aidAddress;
  final String? carName;
  final String? chassisNumber;
  final String? description;

  String get emdadkhahFullName => [emdadkhahFirstName, emdadkhahLastName]
      .where((item) => item?.trim().isNotEmpty == true)
      .join(' ');

  InvoiceAgencyObjectionRequestModel toModel() {
    return InvoiceAgencyObjectionRequestModel(
      serviceRequestTrackCode: serviceRequestTrackCode,
      emdadkhahFirstName: emdadkhahFirstName,
      emdadkhahLastName: emdadkhahLastName,
      callMobileNumber: callMobileNumber,
      aidAddress: aidAddress,
      carName: carName,
      chassisNumber: chassisNumber,
      description: description,
    );
  }
}

class InvoiceAgencyObjectionAgencyEntity {
  const InvoiceAgencyObjectionAgencyEntity({
    this.emdadgarInfoId,
    this.siPlanning,
    this.agencyCode,
    this.agencyName,
    this.aidPerCode,
    this.aidPerName,
    this.provinceId,
    this.provinceName,
    this.cityId,
    this.cityName,
  });

  final int? emdadgarInfoId;
  final int? siPlanning;
  final String? agencyCode;
  final String? agencyName;
  final String? aidPerCode;
  final String? aidPerName;
  final int? provinceId;
  final String? provinceName;
  final int? cityId;
  final String? cityName;

  InvoiceAgencyObjectionAgencyModel toModel() {
    return InvoiceAgencyObjectionAgencyModel(
      emdadgarInfoId: emdadgarInfoId,
      siPlanning: siPlanning,
      agencyCode: agencyCode,
      agencyName: agencyName,
      aidPerCode: aidPerCode,
      aidPerName: aidPerName,
      provinceId: provinceId,
      provinceName: provinceName,
      cityId: cityId,
      cityName: cityName,
    );
  }
}

class InvoiceAgencyObjectionReviewEntity {
  const InvoiceAgencyObjectionReviewEntity({
    this.checkAuthorId,
    this.checkAuthorFullName,
    this.checkAuthorDateTime,
    this.checkAuthorDateTimeJalali,
    this.checkAuthorDescription,
  });

  final int? checkAuthorId;
  final String? checkAuthorFullName;
  final DateTime? checkAuthorDateTime;
  final String? checkAuthorDateTimeJalali;
  final String? checkAuthorDescription;

  InvoiceAgencyObjectionReviewModel toModel() {
    return InvoiceAgencyObjectionReviewModel(
      checkAuthorId: checkAuthorId,
      checkAuthorFullName: checkAuthorFullName,
      checkAuthorDateTime: checkAuthorDateTime,
      checkAuthorDateTimeJalali: checkAuthorDateTimeJalali,
      checkAuthorDescription: checkAuthorDescription,
    );
  }
}

class InvoiceAgencyObjectionAuditEntity {
  const InvoiceAgencyObjectionAuditEntity({
    this.insertDateTime,
    this.insertDateTimeJalali,
  });

  final DateTime? insertDateTime;
  final String? insertDateTimeJalali;

  InvoiceAgencyObjectionAuditModel toModel() {
    return InvoiceAgencyObjectionAuditModel(
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
    );
  }
}
