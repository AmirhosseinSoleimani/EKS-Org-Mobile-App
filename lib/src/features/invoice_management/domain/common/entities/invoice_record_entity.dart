class InvoiceRecordEntity {
  const InvoiceRecordEntity({
    required this.identity,
    required this.customer,
    required this.agency,
    required this.vehicle,
    required this.amounts,
    required this.state,
    required this.operation,
    required this.audit,
  });

  final InvoiceIdentityEntity identity;
  final InvoiceCustomerEntity customer;
  final InvoiceAgencyEntity agency;
  final InvoiceVehicleEntity vehicle;
  final InvoiceAmountsEntity amounts;
  final InvoiceStateEntity state;
  final InvoiceOperationEntity operation;
  final InvoiceAuditEntity audit;
}

class InvoiceIdentityEntity {
  const InvoiceIdentityEntity({
    this.id,
    this.invoiceId,
    this.serviceRequestId,
    this.serviceRequestTrackCode,
    this.requestTrackCode,
    this.evaluationId,
    this.serviceRequestInsertDataTime,
    this.serviceRequestInsertDataTimeJalali,
    this.serviceRequestInsertDate,
    this.requestDateTimeJalali,
    this.evaluationInsertDateTime,
    this.customerInvoiceDateTime,
    this.customerInvoiceDateTimeJalali,
    this.assignDate,
    this.assignDateJalali,
    this.assignDateTimeJalali,
    this.arriveDate,
    this.arriveDateJalali,
    this.endWorkDate,
    this.endWorkDateJalali,
  });

  final int? id;
  final int? invoiceId;
  final int? serviceRequestId;
  final int? serviceRequestTrackCode;
  final int? requestTrackCode;
  final int? evaluationId;
  final DateTime? serviceRequestInsertDataTime;
  final String? serviceRequestInsertDataTimeJalali;
  final DateTime? serviceRequestInsertDate;
  final String? requestDateTimeJalali;
  final DateTime? evaluationInsertDateTime;
  final DateTime? customerInvoiceDateTime;
  final String? customerInvoiceDateTimeJalali;
  final DateTime? assignDate;
  final String? assignDateJalali;
  final String? assignDateTimeJalali;
  final DateTime? arriveDate;
  final String? arriveDateJalali;
  final DateTime? endWorkDate;
  final String? endWorkDateJalali;
}

class InvoiceCustomerEntity {
  const InvoiceCustomerEntity({
    this.firstName,
    this.lastName,
    this.aidAddress,
    this.cityName,
    this.provinceName,
  });

  final String? firstName;
  final String? lastName;
  final String? aidAddress;
  final String? cityName;
  final String? provinceName;

  String get fullName => [firstName, lastName]
      .where((value) => value?.trim().isNotEmpty == true)
      .join(' ');
}

class InvoiceAgencyEntity {
  const InvoiceAgencyEntity({
    this.agencyName,
    this.agencyCode,
    this.emdadgarId,
    this.emdadgarName,
    this.representationName,
    this.representationCode,
    this.agencyProvinceName,
    this.agencyCityName,
    this.agencyCityCode,
    this.emdadgarPlate,
    this.navganType,
  });

  final String? agencyName;
  final String? agencyCode;
  final int? emdadgarId;
  final String? emdadgarName;
  final String? representationName;
  final String? representationCode;
  final String? agencyProvinceName;
  final String? agencyCityName;
  final String? agencyCityCode;
  final String? emdadgarPlate;
  final String? navganType;
}

class InvoiceVehicleEntity {
  const InvoiceVehicleEntity({
    this.carName,
    this.chassisNumber,
    this.carModelId,
    this.customerKilometer,
    this.defectInfoTitle,
    this.serviceRequestDefectTitle,
  });

  final String? carName;
  final String? chassisNumber;
  final int? carModelId;
  final int? customerKilometer;
  final String? defectInfoTitle;
  final String? serviceRequestDefectTitle;
}

class InvoiceAmountsEntity {
  const InvoiceAmountsEntity({
    this.customerAidPrice,
    this.companyAidPrice,
    this.customerLaborPrice,
    this.companyLaborPrice,
    this.customerPartPrice,
    this.companyPartPrice,
    this.customerTotalPrice,
    this.companyTotalPrice,
    this.customerTotalPriceTax,
    this.companyTotalPriceTax,
  });

  final int? customerAidPrice;
  final int? companyAidPrice;
  final int? customerLaborPrice;
  final int? companyLaborPrice;
  final int? customerPartPrice;
  final int? companyPartPrice;
  final int? customerTotalPrice;
  final int? companyTotalPrice;
  final int? customerTotalPriceTax;
  final int? companyTotalPriceTax;
}

class InvoiceStateEntity {
  const InvoiceStateEntity({
    this.colorCode,
    this.invoiceStatus,
    this.invoiceStatusTitle,
    this.type,
    this.ownerType,
    this.ownerTypeTitle,
    this.isDeleted,
    this.isActive,
    this.subscription,
    this.isGaranty,
    this.hasObjection,
    this.isFinalized,
    this.serviceType,
    this.serviceTitle,
    this.serviceGivenCode,
    this.serviceGivenTitle,
    this.serviceCategoryTitle,
    this.requestStatus,
    this.invoiceType,
    this.invoiceTypeTitle,
    this.customerPreInvoiceVisible,
    this.checkCustomerInvoiceVisible,
    this.customerInvoiceVisible,
  });

  final String? colorCode;
  final int? invoiceStatus;
  final String? invoiceStatusTitle;
  final int? type;
  final int? ownerType;
  final String? ownerTypeTitle;
  final bool? isDeleted;
  final bool? isActive;
  final bool? subscription;
  final bool? isGaranty;
  final bool? hasObjection;
  final bool? isFinalized;
  final int? serviceType;
  final String? serviceTitle;
  final int? serviceGivenCode;
  final String? serviceGivenTitle;
  final String? serviceCategoryTitle;
  final int? requestStatus;
  final int? invoiceType;
  final String? invoiceTypeTitle;
  final bool? customerPreInvoiceVisible;
  final bool? checkCustomerInvoiceVisible;
  final bool? customerInvoiceVisible;
}

class InvoiceOperationEntity {
  const InvoiceOperationEntity({
    this.hasTrafficOrPollutionPlan,
    this.payAvarezi,
    this.representationCode,
    this.representation,
    this.useDakal,
    this.stopTime,
    this.acceptanceCode,
    this.arriveTrackerName,
    this.distanceHamlCustomer,
    this.distanceToCustomer,
    this.cityId,
    this.evaluationFinalizedBy,
    this.evaluationFinalizedByTitle,
    this.nightOrHoliday,
    this.nightOrHolidayTitle,
    this.wageGroupType,
    this.wageGroupTypeTitle,
    this.emdadServiceCategoryId,
    this.description,
    this.cancelReasonTitle,
    this.cancelReasonDetailTitle,
  });

  final bool? hasTrafficOrPollutionPlan;
  final bool? payAvarezi;
  final int? representationCode;
  final bool? representation;
  final bool? useDakal;
  final int? stopTime;
  final int? acceptanceCode;
  final String? arriveTrackerName;
  final double? distanceHamlCustomer;
  final double? distanceToCustomer;
  final int? cityId;
  final int? evaluationFinalizedBy;
  final String? evaluationFinalizedByTitle;
  final bool? nightOrHoliday;
  final String? nightOrHolidayTitle;
  final int? wageGroupType;
  final String? wageGroupTypeTitle;
  final int? emdadServiceCategoryId;
  final String? description;
  final String? cancelReasonTitle;
  final String? cancelReasonDetailTitle;
}

class InvoiceAuditEntity {
  const InvoiceAuditEntity({
    this.insertUserId,
    this.insertUserName,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.updateUserId,
    this.updateUserName,
    this.updateDateTime,
    this.updateDateTimeJalali,
  });

  final int? insertUserId;
  final String? insertUserName;
  final DateTime? insertDateTime;
  final String? insertDateTimeJalali;
  final int? updateUserId;
  final String? updateUserName;
  final DateTime? updateDateTime;
  final String? updateDateTimeJalali;
}
