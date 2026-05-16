import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/emdadgar_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_brief_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/plan_id_person_entity.dart';

class EmdadgarEntity {
  int? id;
  String? startDateText;
  String? endDateText;
  int? planningId;
  String? agencyName;
  String? plakText;
  String? khodroTypeText;
  double? lastLocationLatitude;
  double? lastLocationLongitude;
  double? distanceKmToOrigin;
  int? priority;
  bool? isActive;
  List<EmdadgarBriefInfoEntity>? emdadgars;
  List<PlanAidPersonEntity>? planAidPeople;

  EmdadgarEntity({
    this.id,
    this.startDateText,
    this.endDateText,
    this.planningId,
    this.agencyName,
    this.plakText,
    this.khodroTypeText,
    this.lastLocationLatitude,
    this.lastLocationLongitude,
    this.distanceKmToOrigin,
    this.priority,
    this.isActive,
    this.emdadgars,
    this.planAidPeople,
  });

  EmdadgarModel toModel() {
    return EmdadgarModel(
      id: id,
      startDateText: startDateText,
      endDateText: endDateText,
      planningId: planningId,
      agencyName: agencyName,
      plakText: plakText,
      khodroTypeText: khodroTypeText,
      lastLocationLatitude: lastLocationLatitude,
      lastLocationLongitude: lastLocationLongitude,
      distanceKmToOrigin: distanceKmToOrigin,
      priority: priority,
      isActive: isActive,
      emdadgars: emdadgars,
      planAidPeople: planAidPeople,
    );
  }
}
