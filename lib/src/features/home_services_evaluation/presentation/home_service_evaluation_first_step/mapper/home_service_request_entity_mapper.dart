import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';

extension HomeServiceRequestEntityMapper on HomeServiceRequestEntity {
  ActiveServiceRequestResponseEntity toActiveServiceRequestResponseEntity() {
    return ActiveServiceRequestResponseEntity(
      id: id,
      serviceType: serviceType?.value,
      planningId: planningId,
      emdadgarId: emdadgarId,
      trackCode: trackCode,
      firstName: firstName,
      lastName: lastName,
      requestStatus: requestStatus,
      requestStatusTitle: requestStatusTitle,
      personTypeTitle: personTypeTitle,
      subscription: isSubscription,
      guaranty: isGuaranty,
      invoiceDocumentGuid: invoiceDocumentGuid,
      chassisNumber: chassisNumber,
      kilometer: kilometer,
      carName: carName,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      requestDateTimeJalali: requestDateTimeJalali,
      latitude: latitude,
      longitude: longitude,
      aidAddress: aidAddress,
      licensePlate: licensePlate,
      description: description,
      customerMobileNumber: customerMobileNumber,
      carModelId: carModelId,
      carEngineNumber: carEngineNumber,
      carGuid: carInfoGuid,
      carColorTitle: carColorTitle,
      vip: vip,
      vipConditionTitle: vipConditionTitle,
      assignDate: assignDate,
      cityId: cityId,
      nationalNumber: nationalCode,
    );
  }
}
