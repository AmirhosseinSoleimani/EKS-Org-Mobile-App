import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_marks_param_entity.dart';


class PartMarksParamModel extends PartMarksParamEntity {
  const PartMarksParamModel({
    super.serial,
    super.serviceRequestId,
    super.defectId,
    super.partGroupId,
    required super.serviceType,
  });

  Map<String, dynamic> toJson() {
    return {
      'Serial': serial,
      'ServiceRequestId': serviceRequestId,
      'defectId': defectId,
      'partGroupId': partGroupId,
      'serviceType': serviceType.value,
    };
  }
}