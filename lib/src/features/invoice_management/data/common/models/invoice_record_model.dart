import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_entity.dart';

class InvoiceRecordModel extends InvoiceRecordEntity {
  const InvoiceRecordModel({
    required super.identity,
    required super.customer,
    required super.agency,
    required super.vehicle,
    required super.amounts,
    required super.state,
    required super.operation,
    required super.audit,
  });

  factory InvoiceRecordModel.fromJson(Map<String, dynamic> json) {
    return InvoiceRecordModel(
      identity: InvoiceIdentityEntity(
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
      ),
      customer: InvoiceCustomerEntity(
        firstName: JsonValueReader.stringValue(json['emdadkhahFirstName']),
        lastName: JsonValueReader.stringValue(json['emdadkhahLastName']),
        aidAddress: JsonValueReader.stringValue(json['aidAddress']),
        cityName: JsonValueReader.stringValue(json['cityName']),
        provinceName: JsonValueReader.stringValue(json['provinceName']),
      ),
      agency: InvoiceAgencyEntity(
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
      ),
      vehicle: InvoiceVehicleEntity(
        carName: JsonValueReader.stringValue(json['carName']),
        chassisNumber: JsonValueReader.stringValue(json['chassisNumber']),
        carModelId: JsonValueReader.intValue(json['carModelId']),
        customerKilometer: JsonValueReader.intValue(json['customerKilometer']),
        defectInfoTitle: JsonValueReader.stringValue(json['defectInfoTitle']),
        serviceRequestDefectTitle:
            JsonValueReader.stringValue(json['serviceRequestDefectTitle']),
      ),
      amounts: InvoiceAmountsEntity(
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
      ),
      state: InvoiceStateEntity(
        colorCode: JsonValueReader.stringValue(json['colorCode']),
        invoiceStatus: JsonValueReader.intValue(json['invoiceStatus']),
        invoiceStatusTitle:
            JsonValueReader.stringValue(json['invoiceStatusTitle']),
        type: JsonValueReader.intValue(json['type']),
        ownerType: JsonValueReader.intValue(json['ownerType']),
        ownerTypeTitle: JsonValueReader.stringValue(json['ownerTypeTitle']),
        isDeleted: JsonValueReader.boolValue(json['isDeleted']),
        isActive: JsonValueReader.boolValue(json['isActive']),
        subscription: JsonValueReader.boolValue(json['subscription']),
        isGaranty: JsonValueReader.boolValue(json['isGaranty']),
        hasObjection: JsonValueReader.boolValue(json['hasObjection']),
        isFinalized: JsonValueReader.boolValue(json['isFinalized']),
        serviceType: JsonValueReader.intValue(json['serviceType']),
        serviceTitle: JsonValueReader.stringValue(json['serviceTitle']),
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
      ),
      operation: InvoiceOperationEntity(
        hasTrafficOrPollutionPlan:
            JsonValueReader.boolValue(json['serviceRequestHasTrafficOrPollutionPlan']),
        payAvarezi: JsonValueReader.boolValue(json['payAvarezi']),
        representationCode:
            JsonValueReader.intValue(json['representaionCode']),
        representation: JsonValueReader.boolValue(json['representation']),
        useDakal: JsonValueReader.boolValue(json['useDakal']),
        stopTime: JsonValueReader.intValue(json['stopTime']),
        acceptanceCode: JsonValueReader.intValue(json['acceptanceCode']),
        arriveTrackerName:
            JsonValueReader.stringValue(json['arriveTrackerName']),
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
        cancelReasonTitle:
            JsonValueReader.stringValue(json['cancelReasonTitle']),
        cancelReasonDetailTitle:
            JsonValueReader.stringValue(json['cancelReasonDetailTitle']),
      ),
      audit: InvoiceAuditEntity(
        insertUserId: JsonValueReader.intValue(json['insertUserId']),
        insertUserName: JsonValueReader.stringValue(json['insertUserName']),
        insertDateTime: JsonValueReader.dateTimeValue(json['insertDateTime']),
        insertDateTimeJalali:
            JsonValueReader.stringValue(json['insertDateTimeJalali']),
        updateUserId: JsonValueReader.intValue(json['updateUserId']),
        updateUserName: JsonValueReader.stringValue(json['updateUserName']),
        updateDateTime: JsonValueReader.dateTimeValue(json['updateDateTime']),
        updateDateTimeJalali:
            JsonValueReader.stringValue(json['updateDateTimeJalali']),
      ),
    );
  }
}
