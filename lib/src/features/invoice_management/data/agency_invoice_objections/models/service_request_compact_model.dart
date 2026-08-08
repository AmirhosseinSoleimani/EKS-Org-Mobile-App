import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/service_request_compact_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';

class ServiceRequestCompactModel extends ServiceRequestCompactEntity {
  const ServiceRequestCompactModel({
    required super.customer,
    required super.vehicle,
    required super.assignment,
    super.serviceRequestId,
    super.trackCode,
    super.description,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.requestDateTime,
    super.requestDateTimeJalali,
    super.requestStatus,
    super.requestStatusTitle,
    super.subscription,
    super.dispatcher,
    super.defectId,
    super.defectTitle,
    super.invoiceDocumentGuid,
  });

  factory ServiceRequestCompactModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestCompactModel(
      serviceRequestId: JsonValueReader.intValue(json['serviceRequestId']),
      trackCode: JsonValueReader.intValue(json['trackCode']),
      description: JsonValueReader.stringValue(json['description']),
      insertDateTime: JsonValueReader.dateTimeValue(json['insertDateTime']),
      insertDateTimeJalali:
          JsonValueReader.stringValue(json['insertDateTimeJalali']),
      requestDateTime: JsonValueReader.dateTimeValue(json['requestDateTime']),
      requestDateTimeJalali:
          JsonValueReader.stringValue(json['requestDateTimeJalali']),
      requestStatus: JsonValueReader.intValue(json['requestStatus']),
      requestStatusTitle:
          JsonValueReader.stringValue(json['requestStatusTitle']),
      subscription: JsonValueReader.boolValue(json['subscription']),
      dispatcher: JsonValueReader.stringValue(json['dispatcher']),
      defectId: JsonValueReader.intValue(json['defectId']),
      defectTitle: JsonValueReader.stringValue(json['defectTitle']),
      invoiceDocumentGuid:
          JsonValueReader.stringValue(json['invoiceDocumentGuid']),
      customer: ServiceRequestCustomerEntity(
        firstName: JsonValueReader.stringValue(json['firstName']),
        lastName: JsonValueReader.stringValue(json['lastName']),
        callMobileNumber:
            JsonValueReader.stringValue(json['callMobileNumber']),
        customerMobileNumber:
            JsonValueReader.stringValue(json['customerMobileNumber']),
        personType: JsonValueReader.intValue(json['personType']),
        nationalNumber: JsonValueReader.stringValue(json['nationalNumber']),
        aidAddress: JsonValueReader.stringValue(json['aidAddress']),
      ),
      vehicle: ServiceRequestVehicleEntity(
        agencyVehicleLabelCode:
            JsonValueReader.stringValue(json['agencyVehicleLabelCode']),
        chassisNumber: JsonValueReader.stringValue(json['chassisNumber']),
        licensePlate: JsonValueReader.stringValue(json['licensePlate']),
        kilometer: JsonValueReader.intValue(json['kilometer']),
        carInfoId: JsonValueReader.intValue(json['carInfoId']),
        carModelId: JsonValueReader.intValue(json['carModelId']),
        carInfoGuid: JsonValueReader.stringValue(json['carInfoGuid']),
        carName: JsonValueReader.stringValue(json['carName']),
        carEngineNumber:
            JsonValueReader.stringValue(json['carEngineNumber']),
        carGroupTitle: JsonValueReader.stringValue(json['carGroupTitle']),
        carFactory: JsonValueReader.intValue(json['carFactory']),
        carFactoryTitle:
            JsonValueReader.stringValue(json['carFactoryTitle']),
        isSaipa: JsonValueReader.boolValue(json['isSaipa']),
        carProductionYear:
            JsonValueReader.intValue(json['carProductionYear']),
        vehicleUsageId: JsonValueReader.intValue(json['vehicleUsageId']),
        vehicleUsageTitle:
            JsonValueReader.stringValue(json['vehicleUsageTitle']),
        wageGroupType: JsonValueReader.intValue(json['wageGroupType']),
        weightGroupTitle:
            JsonValueReader.stringValue(json['weightGroupTitle']),
        isGaranty: JsonValueReader.boolValue(json['garanty_IsGaranty']),
      ),
      assignment: ServiceRequestAssignmentEntity(
        hasEmdadgar: JsonValueReader.boolValue(json['hasEmdadgar']),
        planningId: JsonValueReader.intValue(json['planningId']),
        emdadgarId: JsonValueReader.intValue(json['emdadgarId']),
        emdadgarName: JsonValueReader.stringValue(json['emdadgarName']),
        emdadgarMobile: JsonValueReader.stringValue(json['emdadgarMobile']),
        emdadgarNavganType:
            JsonValueReader.stringValue(json['emdadgarNavganType']),
        emdadgarVehicleType:
            JsonValueReader.stringValue(json['emdadgarKhodroType']),
        agencyName: JsonValueReader.stringValue(json['agencyName']),
        agencyCode: JsonValueReader.stringValue(json['agencyCode']),
        assignDate: JsonValueReader.dateTimeValue(json['assignDate']),
        assignDateTimeJalali:
            JsonValueReader.stringValue(json['assignDateTimeJalali']),
      ),
    );
  }
}
