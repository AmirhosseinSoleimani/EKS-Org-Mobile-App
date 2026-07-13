import '../../../data/models/params/create_plan_info_param_model.dart';

class CreatePlanInfoParamEntity {
  final int? id;
  final String title;
  final int emdadUnitId;
  final int shiftId;
  final double? latitude;
  final double? longitude;
  final String fromDate;
  final String toDate;
  final String? address;
  final int? specialPlanId;
  final int seatType;
  final bool isActive;
  final int locationId;

  const CreatePlanInfoParamEntity({
    this.id,
    required this.title,
    required this.emdadUnitId,
    required this.shiftId,
    this.latitude,
    this.longitude,
    required this.fromDate,
    required this.toDate,
    this.address,
    this.specialPlanId,
    required this.seatType,
    this.isActive = true,
    required this.locationId,
  });

  CreatePlanInfoParamModel toModel() {
    return CreatePlanInfoParamModel(
      id: id,
      title: title,
      emdadUnitId: emdadUnitId,
      shiftId: shiftId,
      latitude: latitude,
      longitude: longitude,
      fromDate: fromDate,
      toDate: toDate,
      address: address,
      specialPlanId: specialPlanId,
      seatType: seatType,
      isActive: isActive,
      locationId: locationId,
    );
  }
}
