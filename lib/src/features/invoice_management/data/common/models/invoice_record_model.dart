import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_entity.dart';

class InvoiceRecordModel extends InvoiceRecordEntity {
  const InvoiceRecordModel({
    super.identity,
    super.customer,
    super.agency,
    super.vehicle,
    super.amounts,
    super.state,
    super.operation,
    super.audit,
  });

  factory InvoiceRecordModel.fromJson(Map<String, dynamic> json) {
    return InvoiceRecordModel(
      identity: InvoiceIdentityModel.fromJson(json),
      customer: InvoiceCustomerModel.fromJson(json),
      agency: InvoiceAgencyModel.fromJson(json),
      vehicle: InvoiceVehicleModel.fromJson(json),
      amounts: InvoiceAmountsModel.fromJson(json),
      state: InvoiceStateModel.fromJson(json),
      operation: InvoiceOperationModel.fromJson(json),
      audit: InvoiceAuditModel.fromJson(json),
    );
  }
}

class InvoiceIdentityModel extends InvoiceIdentityEntity {
  const InvoiceIdentityModel({
    super.id,
    super.invoiceId,
    super.serviceRequestId,
    super.serviceRequestTrackCode,
    super.requestTrackCode,
    super.evaluationId,
    super.serviceRequestInsertDataTime,
    super.serviceRequestInsertDataTimeJalali,
    super.serviceRequestInsertDate,
    super.requestDateTimeJalali,
    super.evaluationInsertDateTime,
    super.customerInvoiceDateTime,
    super.customerInvoiceDateTimeJalali,
    super.assignDate,
    super.assignDateJalali,
    super.assignDateTimeJalali,
    super.arriveDate,
    super.arriveDateJalali,
    super.endWorkDate,
    super.endWorkDateJalali,
  });

  factory InvoiceIdentityModel.fromJson(Map<String, dynamic> json) {
    return InvoiceIdentityModel(
      id: JsonValueReader.intValue(json['id']),
      invoiceId: JsonValueReader.intValue(json['invoiceID'] ?? json['invoiceId']),
      serviceRequestId: JsonValueReader.intValue(json['serviceRequestId']),
      serviceRequestTrackCode:
          JsonValueReader.intValue(json['serviceRequestTrackCode']),
      requestTrackCode: JsonValueReader.intValue(json['requestTrackCode']),
      evaluationId: JsonValueReader.intValue(json['evaluationId']),
      serviceRequestInsertDataTime:
          JsonValueReader.dateTimeValue(json['serviceRequestInsertDataTime']),
      serviceRequestInsertDataTimeJalali:
          JsonValueReader.stringValue(json['serviceRequestInsertDataTimeJalali']),
      serviceRequestInsertDate:
          JsonValueReader.dateTimeValue(json['serviceRequestInsertDate']),
      requestDateTimeJalali:
          JsonValueReader.stringValue(json['requestDateTimeJalali']),
      evaluationInsertDateTime:
          JsonValueReader.dateTimeValue(json['evaluationInsertDateTime']),
      customerInvoiceDateTime:
          JsonValueReader.dateTimeValue(json['customerInvoiceDateTime']),
      customerInvoiceDateTimeJalali:
          JsonValueReader.stringValue(json['customerInvoiceDateTimeJalali']),
      assignDate: JsonValueReader.dateTimeValue(json['assignDate']),
      assignDateJalali: JsonValueReader.stringValue(json['assignDateJalali']),
      assignDateTimeJalali:
          JsonValueReader.stringValue(json['assignDateTimeJalali']),
      arriveDate: JsonValueReader.dateTimeValue(json['arriveDate']),
      arriveDateJalali: JsonValueReader.stringValue(json['arriveDateJalali']),
      endWorkDate: JsonValueReader.dateTimeValue(json['endWorkDate']),
      endWorkDateJalali: JsonValueReader.stringValue(json['endWorkDateJalali']),
    );
  }
}

class InvoiceCustomerModel extends InvoiceCustomerEntity {
  const InvoiceCustomerModel({
    super.firstName,
    super.lastName,
    super.aidAddress,
    super.cityName,
    super.provinceName,
  });

  factory InvoiceCustomerModel.fromJson(Map<String, dynamic> json) {
    return InvoiceCustomerModel(
      firstName: JsonValueReader.stringValue(json['emdadkhahFirstName']),
      lastName: JsonValueReader.stringValue(json['emdadkhahLastName']),
      aidAddress: JsonValueReader.stringValue(json['aidAddress']),
      cityName: JsonValueReader.stringValue(json['cityName']),
      provinceName: JsonValueReader.stringValue(json['provinceName']),
    );
  }
}

class InvoiceAgencyModel extends InvoiceAgencyEntity {
  const InvoiceAgencyModel({
    super.agencyName,
    super.agencyCode,
    super.emdadgarId,
    super.emdadgarName,
    super.representationName,
    super.representationCode,
    super.agencyProvinceName,
    super.agencyCityName,
    super.agencyCityCode,
    super.emdadgarPlate,
    super.navganType,
  });

  factory InvoiceAgencyModel.fromJson(Map<String, dynamic> json) {
    return InvoiceAgencyModel(
      agencyName: JsonValueReader.stringValue(json['agencyName']),
      agencyCode: JsonValueReader.stringValue(json['agencyCode']),
      emdadgarId: JsonValueReader.intValue(json['emdadgarId']),
      emdadgarName: JsonValueReader.stringValue(json['emdadgarName']),
      representationName:
          JsonValueReader.stringValue(json['emdadgarRepresentationName']),
      representationCode:
          JsonValueReader.stringValue(json['emdadgarRepresentationCode']),
      agencyProvinceName:
          JsonValueReader.stringValue(json['agencyProvinceName']),
      agencyCityName: JsonValueReader.stringValue(json['agencyCityName']),
      agencyCityCode: JsonValueReader.stringValue(json['agencyCityCode']),
      emdadgarPlate: JsonValueReader.stringValue(json['emdadgarPalak']),
      navganType: JsonValueReader.stringValue(json['navganType']),
    );
  }
}

class InvoiceVehicleModel extends InvoiceVehicleEntity {
  const InvoiceVehicleModel({
    super.carName,
    super.chassisNumber,
    super.carModelId,
    super.customerKilometer,
    super.defectInfoTitle,
    super.serviceRequestDefectTitle,
  });

  factory InvoiceVehicleModel.fromJson(Map<String, dynamic> json) {
    return InvoiceVehicleModel(
      carName: JsonValueReader.stringValue(json['carName']),
      chassisNumber: JsonValueReader.stringValue(json['chassisNumber']),
      carModelId: JsonValueReader.intValue(json['carModelId']),
      customerKilometer: JsonValueReader.intValue(json['customerKilometer']),
      defectInfoTitle: JsonValueReader.stringValue(json['defectInfoTitle']),
      serviceRequestDefectTitle:
          JsonValueReader.stringValue(json['serviceRequestDefectTitle']),
    );
  }
}

class InvoiceAmountsModel extends InvoiceAmountsEntity {
  const InvoiceAmountsModel({
    super.customerAidPrice,
    super.companyAidPrice,
    super.customerLaborPrice,
    super.companyLaborPrice,
    super.customerPartPrice,
    super.companyPartPrice,
    super.customerTotalPrice,
    super.companyTotalPrice,
    super.customerTotalPriceTax,
    super.companyTotalPriceTax,
  });

  factory InvoiceAmountsModel.fromJson(Map<String, dynamic> json) {
    return InvoiceAmountsModel(
      customerAidPrice: JsonValueReader.intValue(json['customerAidPrice']),
      companyAidPrice: JsonValueReader.intValue(json['companyAidPrice']),
      customerLaborPrice: JsonValueReader.intValue(json['customerOjratPrice']),
      companyLaborPrice: JsonValueReader.intValue(json['companyOjratPrice']),
      customerPartPrice: JsonValueReader.intValue(json['customerPartPrice']),
      companyPartPrice: JsonValueReader.intValue(json['companyPartPrice']),
      customerTotalPrice: JsonValueReader.intValue(json['customerTotalPrice']),
      companyTotalPrice: JsonValueReader.intValue(json['companyTotalPrice']),
      customerTotalPriceTax:
          JsonValueReader.intValue(json['customerTotalPriceTax']),
      companyTotalPriceTax:
          JsonValueReader.intValue(json['companyTotalPriceTax']),
    );
  }
}

class InvoiceStateModel extends InvoiceStateEntity {
  const InvoiceStateModel({
    super.colorCode,
    super.invoiceStatus,
    super.invoiceStatusTitle,
    super.type,
    super.ownerType,
    super.ownerTypeTitle,
    super.isDeleted,
    super.isActive,
    super.subscription,
    super.subscriptionCode,
    super.isGaranty,
    super.hasObjection,
    super.isFinalized,
    super.serviceType,
    super.serviceTypeTitle,
    super.serviceTitle,
    super.productTitle,
    super.serviceGivenCode,
    super.serviceGivenTitle,
    super.serviceCategoryTitle,
    super.requestStatus,
    super.invoiceType,
    super.invoiceTypeTitle,
    super.customerPreInvoiceVisible,
    super.checkCustomerInvoiceVisible,
    super.customerInvoiceVisible,
  });

  factory InvoiceStateModel.fromJson(Map<String, dynamic> json) {
    return InvoiceStateModel(
      colorCode: JsonValueReader.stringValue(json['colorCode']),
      invoiceStatus: JsonValueReader.intValue(json['invoiceStatus']),
      invoiceStatusTitle: JsonValueReader.stringValue(json['invoiceStatusTitle']),
      type: JsonValueReader.intValue(json['type']),
      ownerType: JsonValueReader.intValue(json['ownerType']),
      ownerTypeTitle: JsonValueReader.stringValue(json['ownerTypeTitle']),
      isDeleted: JsonValueReader.boolValue(json['isDeleted']),
      isActive: JsonValueReader.boolValue(json['isActive']),
      subscription: JsonValueReader.boolValue(json['subscription']),
      subscriptionCode: JsonValueReader.intValue(
        json['subscribtionCode'] ?? json['subscriptionCode'],
      ),
      isGaranty: JsonValueReader.boolValue(json['isGaranty']),
      hasObjection: JsonValueReader.boolValue(json['hasObjection']),
      isFinalized: JsonValueReader.boolValue(json['isFinalized']),
      serviceType: JsonValueReader.intValue(json['serviceType']),
      serviceTypeTitle: JsonValueReader.stringValue(json['serviceTypeTitle']),
      serviceTitle: JsonValueReader.stringValue(json['serviceTitle']),
      productTitle: JsonValueReader.stringValue(json['productTitle']),
      serviceGivenCode: JsonValueReader.intValue(json['serviceGivenCode']),
      serviceGivenTitle: JsonValueReader.stringValue(json['serviceGivenTitle']),
      serviceCategoryTitle:
          JsonValueReader.stringValue(json['serviceCategoryTitle']),
      requestStatus: JsonValueReader.intValue(json['requestStatus']),
      invoiceType: JsonValueReader.intValue(json['invoiceType']),
      invoiceTypeTitle: JsonValueReader.stringValue(json['invoiceTypeTitle']),
      customerPreInvoiceVisible:
          JsonValueReader.boolValue(json['customerPreInvoiceVisible']),
      checkCustomerInvoiceVisible:
          JsonValueReader.boolValue(json['checkCustmerInvoiceVisible']),
      customerInvoiceVisible:
          JsonValueReader.boolValue(json['customerInvoiceVisible']),
    );
  }
}

class InvoiceOperationModel extends InvoiceOperationEntity {
  const InvoiceOperationModel({
    super.hasTrafficOrPollutionPlan,
    super.payAvarezi,
    super.representationCode,
    super.representation,
    super.useDakal,
    super.stopTime,
    super.acceptanceCode,
    super.arriveTrackerName,
    super.distanceHamlCustomer,
    super.distanceToCustomer,
    super.cityId,
    super.evaluationFinalizedBy,
    super.evaluationFinalizedByTitle,
    super.nightOrHoliday,
    super.nightOrHolidayTitle,
    super.wageGroupType,
    super.wageGroupTypeTitle,
    super.emdadServiceCategoryId,
    super.description,
    super.cancelReasonTitle,
    super.cancelReasonDetailTitle,
  });

  factory InvoiceOperationModel.fromJson(Map<String, dynamic> json) {
    return InvoiceOperationModel(
      hasTrafficOrPollutionPlan: JsonValueReader.boolValue(
        json['serviceRequestHasTrafficOrPollutionPlan'],
      ),
      payAvarezi: JsonValueReader.boolValue(json['payAvarezi']),
      representationCode: JsonValueReader.intValue(json['representaionCode']),
      representation: JsonValueReader.boolValue(json['representation']),
      useDakal: JsonValueReader.boolValue(json['useDakal']),
      stopTime: JsonValueReader.intValue(json['stopTime']),
      acceptanceCode: JsonValueReader.intValue(json['acceptanceCode']),
      arriveTrackerName: JsonValueReader.stringValue(json['arriveTrackerName']),
      distanceHamlCustomer:
          JsonValueReader.doubleValue(json['distanceHamlCustomer']),
      distanceToCustomer:
          JsonValueReader.doubleValue(json['distanceToCustomer']),
      cityId: JsonValueReader.intValue(json['cityId']),
      evaluationFinalizedBy:
          JsonValueReader.intValue(json['evaluationFinilizedBy']),
      evaluationFinalizedByTitle:
          JsonValueReader.stringValue(json['evaluationFinilizedByTitle']),
      nightOrHoliday: JsonValueReader.boolValue(json['nightOrHoliday']),
      nightOrHolidayTitle:
          JsonValueReader.stringValue(json['nightOrHolidayTitle']),
      wageGroupType: JsonValueReader.intValue(json['wageGroupType']),
      wageGroupTypeTitle:
          JsonValueReader.stringValue(json['wageGroupTypeTitle']),
      emdadServiceCategoryId:
          JsonValueReader.intValue(json['emdadServiceCategoryId']),
      description: JsonValueReader.stringValue(json['description']),
      cancelReasonTitle: JsonValueReader.stringValue(json['cancelReasonTitle']),
      cancelReasonDetailTitle:
          JsonValueReader.stringValue(json['cancelReasonDetailTitle']),
    );
  }
}

class InvoiceAuditModel extends InvoiceAuditEntity {
  const InvoiceAuditModel({
    super.insertUserId,
    super.insertUserName,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.updateUserId,
    super.updateUserName,
    super.updateDateTime,
    super.updateDateTimeJalali,
  });

  factory InvoiceAuditModel.fromJson(Map<String, dynamic> json) {
    return InvoiceAuditModel(
      insertUserId: JsonValueReader.intValue(json['insertUserId']),
      insertUserName: JsonValueReader.stringValue(json['insertUserName']),
      insertDateTime: JsonValueReader.dateTimeValue(json['insertDateTime']),
      insertDateTimeJalali: JsonValueReader.stringValue(
        json['insertDateTimeJalali'] ?? json['insertJalaliDate'],
      ),
      updateUserId: JsonValueReader.intValue(json['updateUserId']),
      updateUserName: JsonValueReader.stringValue(json['updateUserName']),
      updateDateTime: JsonValueReader.dateTimeValue(json['updateDateTime']),
      updateDateTimeJalali:
          JsonValueReader.stringValue(json['updateDateTimeJalali']),
    );
  }
}
