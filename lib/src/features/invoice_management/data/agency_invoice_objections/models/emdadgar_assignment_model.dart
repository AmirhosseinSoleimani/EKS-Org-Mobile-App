import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/emdadgar_assignment_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';

class EmdadgarAssignmentModel extends EmdadgarAssignmentEntity {
  const EmdadgarAssignmentModel({
    super.id,
    super.startDateText,
    super.endDateText,
    super.shiftTypeText,
    super.shiftTypeId,
    super.planningId,
    super.shiftId,
    super.planId,
    super.planName,
    super.shiftName,
    super.agency,
    super.vehicle,
    super.contact,
    super.location,
    super.status,
    super.statusName,
    super.statusTitle,
    super.isDeleted,
    super.isActive,
    super.avlIsOnline,
    super.inShift,
    super.inVacation,
    super.shiftIsOffline,
    super.isDepotEnabled,
    super.isHomeService,
    super.isEmdadService,
    super.emdadgarCount,
    super.distanceKmToOrigin,
    super.emdadServiceId,
  });

  factory EmdadgarAssignmentModel.fromJson(Map<String, dynamic> json) {
    return EmdadgarAssignmentModel(
      id: JsonValueReader.intValue(json['id']),
      startDateText: JsonValueReader.stringValue(json['startDateText']),
      endDateText: JsonValueReader.stringValue(json['endDateText']),
      shiftTypeText: JsonValueReader.stringValue(json['shiftTypeText']),
      shiftTypeId: JsonValueReader.intValue(json['shiftTypeId']),
      planningId: JsonValueReader.intValue(json['planningId']),
      shiftId: JsonValueReader.intValue(json['shiftId']),
      planId: JsonValueReader.intValue(json['tarhId']),
      planName: JsonValueReader.stringValue(json['tarhNameText']),
      shiftName: JsonValueReader.stringValue(json['shiftName']),
      agency: EmdadgarAgencyEntity(
        code: JsonValueReader.stringValue(json['agencyCode']),
        name: JsonValueReader.stringValue(json['agencyName']),
        labelCode: JsonValueReader.stringValue(json['agencyCodeLabel']),
        provinceName:
            JsonValueReader.stringValue(json['ostanNamayandegiText']),
        provinceCode:
            JsonValueReader.stringValue(json['ostanNamayandegiCode']),
        cityName: JsonValueReader.stringValue(json['shahrNamayandegiText']),
        cityCode: JsonValueReader.stringValue(json['shahrNamayandegiCode']),
      ),
      vehicle: EmdadgarVehicleEntity(
        agencyVehicleId: JsonValueReader.intValue(json['khodroAgnecyId']),
        imei: JsonValueReader.stringValue(json['nImei']),
        plate: JsonValueReader.stringValue(json['plakText']),
        vehicleType: JsonValueReader.stringValue(json['khodroTypeText']),
        vehicleTypeId: JsonValueReader.intValue(json['khodroTypeId']),
        navganType: JsonValueReader.stringValue(json['navganTypeText']),
        navganTypeCode: JsonValueReader.intValue(json['navganTypeCode']),
      ),
      contact: EmdadgarContactEntity(
        irancellMobile: JsonValueReader.stringValue(
          json['allEmdadgarIrancellMobile'] ?? json['irancellMobile'],
        ),
        mobile: JsonValueReader.stringValue(
          json['allEmdadgarMobile'] ?? json['mobile'],
        ),
        nationalCode: JsonValueReader.stringValue(json['nationalCode']),
      ),
      location: EmdadgarLocationEntity(
        lastLatitude:
            JsonValueReader.doubleValue(json['lastLocationLatitude']),
        lastLongitude:
            JsonValueReader.doubleValue(json['lastLocationLongitude']),
        latitude: JsonValueReader.doubleValue(json['nLat']),
        longitude: JsonValueReader.doubleValue(json['nLong']),
        locationId: JsonValueReader.intValue(json['mahalId']),
        locationCode: JsonValueReader.stringValue(json['mahalCode']),
        locationName: JsonValueReader.stringValue(json['mahalNameText']),
      ),
      status: JsonValueReader.intValue(json['status']),
      statusName: JsonValueReader.stringValue(json['statusName']),
      statusTitle: JsonValueReader.stringValue(json['statusTitle']),
      isDeleted: JsonValueReader.boolValue(json['isDeleted']),
      isActive: JsonValueReader.boolValue(json['isActive']),
      avlIsOnline: JsonValueReader.boolValue(json['avlIsOnline']),
      inShift: JsonValueReader.boolValue(json['inShift']),
      inVacation: JsonValueReader.boolValue(json['inVacation']),
      shiftIsOffline: JsonValueReader.boolValue(json['shiftIsOffline']),
      isDepotEnabled: JsonValueReader.boolValue(json['isDepotEnabled']),
      isHomeService: JsonValueReader.boolValue(json['isHomeService']),
      isEmdadService: JsonValueReader.boolValue(json['isEmdadService']),
      emdadgarCount: JsonValueReader.intValue(json['emdadgarCount']),
      distanceKmToOrigin:
          JsonValueReader.doubleValue(json['distanceKmToOrigin']),
      emdadServiceId: JsonValueReader.intValue(json['emdadServiceId']),
    );
  }
}
