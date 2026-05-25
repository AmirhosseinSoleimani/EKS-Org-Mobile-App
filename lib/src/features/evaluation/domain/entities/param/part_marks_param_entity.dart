import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/part_marks_param_model.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';

class PartMarksParamEntity {
  final int? serial;
  final int? serviceRequestId;
  final int? defectId;
  final int? partGroupId;
  final ServiceType serviceType;

  const PartMarksParamEntity({
    this.serial,
    this.serviceRequestId,
    this.defectId,
    this.partGroupId,
    required this.serviceType,
  });

  PartMarksParamModel toModel() {
    return PartMarksParamModel(
      serial: serial,
      serviceRequestId: serviceRequestId,
      defectId: defectId,
      partGroupId: partGroupId,
      serviceType: serviceType,
    );
  }

  PartMarksParamEntity copyWith({
    int? serial,
    int? serviceRequestId,
    int? defectId,
    int? partGroupId,
    ServiceType? serviceType,
  }) {
    return PartMarksParamEntity(
      serial: serial ?? this.serial,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      defectId: defectId ?? this.defectId,
      partGroupId: partGroupId ?? this.partGroupId,
      serviceType: serviceType ?? this.serviceType,
    );
  }
}