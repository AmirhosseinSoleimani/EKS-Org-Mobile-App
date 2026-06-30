
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_mark_request_entity.dart';

class PartMarkRequestModel extends PartMarkRequestEntity {
  PartMarkRequestModel({
    super.defectId,
    super.partGroupId,
    super.personInfoId,
    super.serial,
    super.serviceRequestId,
    super.serviceType,
    super.planningId
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceRequestId'] = serviceRequestId;
    map['serial'] = serial;
    map['personInfoId'] = personInfoId;
    map['defectId'] = defectId;
    map['partGroupId'] = partGroupId;
    map['serviceType'] = serviceType;
    map['planningId'] = planningId;
    return map;
  }
}