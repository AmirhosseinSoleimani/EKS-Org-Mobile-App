import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/emdadgar_brief_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/plan_id_person_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';

class EmdadgarModel extends EmdadgarEntity {
  EmdadgarModel({
    super.id,
    super.startDateText,
    super.endDateText,
    super.planningId,
    super.agencyName,
    super.plakText,
    super.khodroTypeText,
    super.lastLocationLatitude,
    super.lastLocationLongitude,
    super.distanceKmToOrigin,
    super.priority,
    super.isActive,
    super.emdadgars,
    super.planAidPeople,
  });

  factory EmdadgarModel.fromJson(Map<String, dynamic> json) {
    return EmdadgarModel(
      id: json["id"],
      startDateText: json["startDateText"],
      endDateText: json["endDateText"],
      planningId: json["planningId"],
      agencyName: json["agencyName"],
      plakText: json["plakText"],
      khodroTypeText: json["khodroTypeText"],
      lastLocationLatitude: json["lastLocationLatitude"]?.toDouble(),
      lastLocationLongitude: json["lastLocationLongitude"]?.toDouble(),
      distanceKmToOrigin: json["distanceKmToOrigin"]?.toDouble(),
      priority: json["priority"],
      isActive: json["isActive"],
      emdadgars: (json["emdadgars"] as List?)
          ?.map((e) => EmdadgarBriefInfoModel.fromJson(e))
          .toList(),
      planAidPeople: (json["planAidPeople"] as List?)
          ?.map((e) => PlanAidPersonModel.fromJson(e))
          .toList(),
    );
  }
}
