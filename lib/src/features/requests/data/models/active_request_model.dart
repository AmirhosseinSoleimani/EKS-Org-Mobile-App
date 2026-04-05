import 'package:eks_sana_plus_org/src/features/requests/data/models/location_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';

class ActiveRequestModel extends RequestEntity {
  const ActiveRequestModel({
    super.id,
    super.requestNo,
    super.requestDate,
    super.status,
    super.statusTitle,
    super.type,
    super.chassisNo,
    super.licensePlate,
    super.distanceTraveledKm,
    super.lastName,
    super.khedmatResanFullName,
    super.khedmatResanCode,
    super.typeTitle,
    super.actions,
    super.defectId,
    super.defectTitle,
    super.defectDescription,
    super.nationalCode,
    super.firstName,
    super.submitDate,
    super.submitTime,
    super.serviceDate,
    super.serviceTime,
    super.hasSubscription,
    super.isGuaranty,
    super.carName,
    super.carModelId,
    super.location,
    super.callLogId,
    super.channelType,
    super.cityId,
    super.vin,
    super.gender,
    super.kilometer,
    super.evaluationKilometer,
    super.customerDisability,
    super.trackCode,
    super.carColor,
    super.customerDisabilityTitle,
    super.customerMobileNumber,
    super.carEngineNumber,
    super.carColorTitle,
    super.foreigner,
    super.vip,
  });

  factory ActiveRequestModel.fromJson(Map<String, dynamic> json) =>
      ActiveRequestModel(
          type: json['serviceType'],
          id: json["id"],
          defectId: json["defectId"],
          defectTitle: json["defectTitle"],
          chassisNo: json["chassisNumber"],
          nationalCode: json["nationalNumber"],
          location: LocationModel(
            address: json["aidAddress"],
            latitude: json["latitude"],
            longitude: json["longitude"],
          ),
          callLogId: json["callLogId"],
          channelType: json["channelType"],
          firstName: json["firstName"],
          lastName: json["lastName"],
          cityId: json["cityId"],
          gender: json["gender"],
          licensePlate: json["licensePlate"],
          kilometer: json["kilometer"],
          evaluationKilometer: json["evaluationKilometer"],
          customerMobileNumber: json["customerMobileNumber"],
          carModelId: json["carModelId"],
          requestNo: json["trackCode"].toString(),
          carName: json["carName"],
          carEngineNumber: json["carEngineNumber"],
          foreigner: json["foreigner"],
          status: json["requestStatus"],
          hasSubscription: json["subscription"],
          carColor: json["carColor"],
          carColorTitle: json["carColorTitle"],
          vip: json["vip"],
          isGuaranty: json["garanty_IsGaranty"],
          customerDisability: json["customerDisability"],
          customerDisabilityTitle: json["customerDisabilityTitle"],

          // توضیحات اضافی درخواست
          defectDescription: json["description"],
          // تاریخ و زمان ثبت درخواست
          submitDate: json["insertDateTimeJalali"]?.split(" ").first,
          submitTime: json["insertDateTimeJalali"]?.split(" ").length > 1
              ? json["insertDateTimeJalali"]?.split(" ")[1]
              : null,
          // تاریخ و زمان سرویس — فعلاً مشابه submit چون در JSON نیست
          serviceDate: json["updateDateTimeJalali"]?.split(" ").first,
          serviceTime: json["updateDateTimeJalali"]?.split(" ").length > 1
              ? json["updateDateTimeJalali"]?.split(" ")[1]
              : null,
          // requestDate همون تاریخ ثبت
          requestDate: json["insertDateTimeJalali"]?.split(" ").first,
          // عناوین وضعیت و تخصیص
          statusTitle: json["requestStatusTitle"],
          typeTitle: json["assignTypeStr"],
          vin: json["vin"]

          /*  hamlReasonTitle: json["hamlReasonTitle"],
        wheelQuestionId: json["wheelQuestionId"],
        wheelQuestionTitle: json["wheelQuestionTitle"],
        assignDateJalali: json["assignDateJalali"],
        insertDateTimeJalali: json["insertDateTimeJalali"],
        description: json["description"],
        emdadgarNavganType: json["emdadgarNavganType"],
        emdadgarCarModel: json["emdadgarCarModel"],
        agencyCode: json["agencyCode"],
        emdadgarName: json["emdadgarName"],
        emdadgarLat: json["emdadgarLat"],
        emdadgarLng: json["emdadgarLng"],
        emdadgarMobileNumber: json["emdadgarMobileNumber"],
         serviceTitle: json["serviceTitle"],
        assignDate: json["assignDate"],
        insertDateTime: json["insertDateTime"],
        requestStatusName: json["requestStatusName"],
        requestStatusTitle: json["requestStatusTitle"],*/
          );
}
