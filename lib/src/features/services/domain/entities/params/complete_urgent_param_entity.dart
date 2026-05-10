import 'package:eks_sana_plus_org/src/features/services/data/models/params/complete_urgent_param_model.dart';

class CompleteUrgentParamEntity {
  final int? serviceRequestId;
  final String? nationalCode;
  final String? firstName;
  final String? lastName;
  final int? gender;
  final int? carModelId;
  final String? carName;
  final int? carColor;
  final String? carProductionYear;
  final String? chassisNo;
  final String? engineNumber;
  final String? customerKilometer;
  final String? licensePlate;

  const CompleteUrgentParamEntity({
    this.serviceRequestId,
    this.nationalCode,
    this.firstName,
    this.lastName,
    this.gender,
    this.carModelId,
    this.carName,
    this.carColor,
    this.carProductionYear,
    this.chassisNo,
    this.engineNumber,
    this.customerKilometer,
    this.licensePlate,
  });

  CompleteUrgentParamEntity copyWith({
    int? serviceRequestId,
    String? nationalCode,
    String? firstName,
    String? lastName,
    int? gender,
    int? carModelId,
    String? carName,
    int? carColor,
    String? carProductionYear,
    String? chassisNo,
    String? engineNumber,
    String? customerKilometer,
    String? licensePlate,
  }) {
    return CompleteUrgentParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      nationalCode: nationalCode ?? this.nationalCode,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      carModelId: carModelId ?? this.carModelId,
      carName: carName ?? this.carName,
      carColor: carColor ?? this.carColor,
      carProductionYear: carProductionYear ?? this.carProductionYear,
      chassisNo: chassisNo ?? this.chassisNo,
      engineNumber: engineNumber ?? this.engineNumber,
      customerKilometer: customerKilometer ?? this.customerKilometer,
      licensePlate: licensePlate ?? this.licensePlate,
    );
  }

  CompleteUrgentParamModel toModel() {
    return CompleteUrgentParamModel(
      serviceRequestId: serviceRequestId,
      nationalCode: nationalCode,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      carModelId: carModelId,
      carName: carName,
      carColor: carColor,
      carProductionYear: carProductionYear,
      chassisNo: chassisNo,
      engineNumber: engineNumber,
      customerKilometer: customerKilometer,
      licensePlate: licensePlate,
    );
  }
}


