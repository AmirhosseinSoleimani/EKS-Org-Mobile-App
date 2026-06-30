import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_mark_request_model.dart';

class PartMarkRequestEntity {
  final int? serviceRequestId;
  final String? serial;
  final int? personInfoId;
  final int? defectId;
  final int? partGroupId;
  final int? serviceType;
  final int? planningId;

  PartMarkRequestEntity copyWith({
    int? serviceRequestId,
    String? serial,
    int? personInfoId,
    int? defectId,
    int? partGroupId,
    int? serviceType,
    int? planningId,
  }) {
    return PartMarkRequestEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serial: serial ?? this.serial,
      personInfoId: personInfoId ?? this.personInfoId,
      defectId: defectId ?? this.defectId,
      partGroupId: partGroupId ?? this.partGroupId,
      serviceType: serviceType ?? this.serviceType,
      planningId: planningId ?? this.planningId,
    );
  }

  PartMarkRequestModel toModel() {
    return PartMarkRequestModel(
      serviceRequestId: serviceRequestId,
      serial: serial,
      personInfoId: personInfoId,
      defectId: defectId,
      partGroupId: partGroupId,
      serviceType: serviceType,
      planningId: planningId,
    );
  }

  const PartMarkRequestEntity({
    this.serviceRequestId,
    this.serial,
    this.personInfoId,
    this.defectId,
    this.partGroupId,
    this.serviceType,
    this.planningId,
  });
}
