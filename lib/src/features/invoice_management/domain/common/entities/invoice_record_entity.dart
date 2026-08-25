import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_record_model.dart';

class InvoiceRecordEntity {
  const InvoiceRecordEntity({
    this.identity,
    this.customer,
    this.agency,
    this.vehicle,
    this.amounts,
    this.state,
    this.operation,
    this.audit,
  });

  final InvoiceIdentityEntity? identity;
  final InvoiceCustomerEntity? customer;
  final InvoiceAgencyEntity? agency;
  final InvoiceVehicleEntity? vehicle;
  final InvoiceAmountsEntity? amounts;
  final InvoiceStateEntity? state;
  final InvoiceOperationEntity? operation;
  final InvoiceAuditEntity? audit;

  InvoiceRecordEntity  toModel() {
    return InvoiceRecordModel(
      identity: identity?.toModel(),
      customer: customer?.toModel(),
      agency: agency?.toModel(),
      vehicle: vehicle?.toModel(),
      amounts: amounts?.toModel(),
      state: state?.toModel(),
      operation: operation?.toModel(),
      audit: audit?.toModel(),
    );
  }
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

  InvoiceIdentityModel toModel() {
    return InvoiceIdentityModel(
      id: id,
      invoiceId: invoiceId,
      serviceRequestId: serviceRequestId,
      serviceRequestTrackCode: serviceRequestTrackCode,
      requestTrackCode: requestTrackCode,
      evaluationId: evaluationId,
      serviceRequestInsertDataTime: serviceRequestInsertDataTime,
      serviceRequestInsertDataTimeJalali: serviceRequestInsertDataTimeJalali,
      serviceRequestInsertDate: serviceRequestInsertDate,
      requestDateTimeJalali: requestDateTimeJalali,
      evaluationInsertDateTime: evaluationInsertDateTime,
      customerInvoiceDateTime: customerInvoiceDateTime,
      customerInvoiceDateTimeJalali: customerInvoiceDateTimeJalali,
      assignDate: assignDate,
      assignDateJalali: assignDateJalali,
      assignDateTimeJalali: assignDateTimeJalali,
      arriveDate: arriveDate,
      arriveDateJalali: arriveDateJalali,
      endWorkDate: endWorkDate,
      endWorkDateJalali: endWorkDateJalali,
    );
  }
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

  InvoiceCustomerModel toModel() {
    return InvoiceCustomerModel(
      firstName: firstName,
      lastName: lastName,
      aidAddress: aidAddress,
      cityName: cityName,
      provinceName: provinceName,
    );
  }
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

  InvoiceAgencyModel toModel() {
    return InvoiceAgencyModel(
      agencyName: agencyName,
      agencyCode: agencyCode,
      emdadgarId: emdadgarId,
      emdadgarName: emdadgarName,
      representationName: representationName,
      representationCode: representationCode,
      agencyProvinceName: agencyProvinceName,
      agencyCityName: agencyCityName,
      agencyCityCode: agencyCityCode,
      emdadgarPlate: emdadgarPlate,
      navganType: navganType,
    );
  }
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

  InvoiceVehicleModel toModel() {
    return InvoiceVehicleModel(
      carName: carName,
      chassisNumber: chassisNumber,
      carModelId: carModelId,
      customerKilometer: customerKilometer,
      defectInfoTitle: defectInfoTitle,
      serviceRequestDefectTitle: serviceRequestDefectTitle,
    );
  }
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

  InvoiceAmountsModel toModel() {
    return InvoiceAmountsModel(
      customerAidPrice: customerAidPrice,
      companyAidPrice: companyAidPrice,
      customerLaborPrice: customerLaborPrice,
      companyLaborPrice: companyLaborPrice,
      customerPartPrice: customerPartPrice,
      companyPartPrice: companyPartPrice,
      customerTotalPrice: customerTotalPrice,
      companyTotalPrice: companyTotalPrice,
      customerTotalPriceTax: customerTotalPriceTax,
      companyTotalPriceTax: companyTotalPriceTax,
    );
  }
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
    this.subscriptionCode,
    this.isGaranty,
    this.hasObjection,
    this.isFinalized,
    this.serviceType,
    this.serviceTypeTitle,
    this.serviceTitle,
    this.productTitle,
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
  final int? subscriptionCode;
  final bool? isGaranty;
  final bool? hasObjection;
  final bool? isFinalized;
  final int? serviceType;
  final String? serviceTypeTitle;
  final String? serviceTitle;
  final String? productTitle;
  final int? serviceGivenCode;
  final String? serviceGivenTitle;
  final String? serviceCategoryTitle;
  final int? requestStatus;
  final int? invoiceType;
  final String? invoiceTypeTitle;
  final bool? customerPreInvoiceVisible;
  final bool? checkCustomerInvoiceVisible;
  final bool? customerInvoiceVisible;

  InvoiceStateModel toModel() {
    return InvoiceStateModel(
      colorCode: colorCode,
      invoiceStatus: invoiceStatus,
      invoiceStatusTitle: invoiceStatusTitle,
      type: type,
      ownerType: ownerType,
      ownerTypeTitle: ownerTypeTitle,
      isDeleted: isDeleted,
      isActive: isActive,
      subscription: subscription,
      subscriptionCode: subscriptionCode,
      isGaranty: isGaranty,
      hasObjection: hasObjection,
      isFinalized: isFinalized,
      serviceType: serviceType,
      serviceTypeTitle: serviceTypeTitle,
      serviceTitle: serviceTitle,
      productTitle: productTitle,
      serviceGivenCode: serviceGivenCode,
      serviceGivenTitle: serviceGivenTitle,
      serviceCategoryTitle: serviceCategoryTitle,
      requestStatus: requestStatus,
      invoiceType: invoiceType,
      invoiceTypeTitle: invoiceTypeTitle,
      customerPreInvoiceVisible: customerPreInvoiceVisible,
      checkCustomerInvoiceVisible: checkCustomerInvoiceVisible,
      customerInvoiceVisible: customerInvoiceVisible,
    );
  }
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

  InvoiceOperationModel toModel() {
    return InvoiceOperationModel(
      hasTrafficOrPollutionPlan: hasTrafficOrPollutionPlan,
      payAvarezi: payAvarezi,
      representationCode: representationCode,
      representation: representation,
      useDakal: useDakal,
      stopTime: stopTime,
      acceptanceCode: acceptanceCode,
      arriveTrackerName: arriveTrackerName,
      distanceHamlCustomer: distanceHamlCustomer,
      distanceToCustomer: distanceToCustomer,
      cityId: cityId,
      evaluationFinalizedBy: evaluationFinalizedBy,
      evaluationFinalizedByTitle: evaluationFinalizedByTitle,
      nightOrHoliday: nightOrHoliday,
      nightOrHolidayTitle: nightOrHolidayTitle,
      wageGroupType: wageGroupType,
      wageGroupTypeTitle: wageGroupTypeTitle,
      emdadServiceCategoryId: emdadServiceCategoryId,
      description: description,
      cancelReasonTitle: cancelReasonTitle,
      cancelReasonDetailTitle: cancelReasonDetailTitle,
    );
  }
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

  InvoiceAuditModel toModel() {
    return InvoiceAuditModel(
      insertUserId: insertUserId,
      insertUserName: insertUserName,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      updateUserId: updateUserId,
      updateUserName: updateUserName,
      updateDateTime: updateDateTime,
      updateDateTimeJalali: updateDateTimeJalali,
    );
  }
}
