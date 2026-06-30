
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/complete_urgent_param_entity.dart';

class CompleteUrgentParamModel extends CompleteUrgentParamEntity {
  const CompleteUrgentParamModel({
    super.serviceRequestId,
    super.nationalCode,
    super.firstName,
    super.lastName,
    super.gender,
    super.carModelId,
    super.carName,
    super.carColor,
    super.carProductionYear,
    super.chassisNo,
    super.engineNumber,
    super.customerKilometer,
    super.licensePlate,
  });

  factory CompleteUrgentParamModel.fromJson(Map<String, dynamic> json) {
    return CompleteUrgentParamModel(
      serviceRequestId: json['serviceRequestId'],
      nationalCode: json['nationalCode'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      carModelId: json['carModelId'],
      carName: json['carName'],
      carColor: json['carColor'],
      carProductionYear: json['carProductionYear'],
      chassisNo: json['chassisNo'],
      engineNumber: json['engineNumber'],
      customerKilometer: json['customerKilometer'],
      licensePlate: json['licensePlate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceRequestId': serviceRequestId,
      'nationalCode': nationalCode,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'carModelId': carModelId,
      'carName': carName,
      'carColor': carColor,
      'carProductionYear': carProductionYear,
      'chassisNo': chassisNo,
      'engineNumber': engineNumber,
      'customerKilometer': customerKilometer,
      'licensePlate': licensePlate,
    };
  }
}