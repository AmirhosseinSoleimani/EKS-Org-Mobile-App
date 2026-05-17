import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/emdadgar_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_brief_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/plan_id_person_entity.dart';

class EmdadgarEntity {
  int? id;
  String? startDateText;
  String? endDateText;
  String? shiftTypeText;
  int? shiftTypeId;
  int? planningId;
  int? imeiId;
  int? khodroAgnecyId;
  int? shiftId;
  int? tarhId;
  int? nStatus;
  int? nVisible;
  int? nPlanType;
  String? tarhNameText;
  int? tarhCode;
  String? nImei;
  int? shiftCode;
  String? shiftName;
  String? plakKhodroTypeText;
  String? mahalCode;
  String? mahalNameText;
  String? agencyCode;
  int? aidPerCodeId;
  String? agencyName;
  String? aidPerName1;
  String? plakText;
  String? khodroTypeText;
  int? khodroTypeId;
  double? lastLocationLatitude;
  double? lastLocationLongitude;
  int? mahalId;
  String? ostanNamayandegiText;
  String? ostanNamayandegiCode;
  String? shahrNamayandegiText;
  String? shahrNamayandegiCode;
  String? navganTypeText;
  int? navganTypeCode;
  String? navganTypeCodeStr;
  String? nationalCode;
  bool? isDeleted;
  bool? isActive;
  int? status;
  String? statusName;
  String? statusTitle;
  bool? isDriving;
  bool? avlIsOnline;
  int? emdadgarCount;
  List<EmdadgarBriefInfoEntity>? emdadgars;
  double? distanceKmToOrigin;
  int? priority;
  bool? inShift;
  bool? inVacation;
  bool? shiftIsOffline;
  bool? isDepotEnabled;
  bool? isHomeService;
  bool? isEmdadService;
  String? limitationStateStr;
  List<PlanAidPersonEntity>? planAidPeople;
  int? emdadServiceId;

  EmdadgarEntity({
    this.id,
    this.startDateText,
    this.endDateText,
    this.shiftTypeText,
    this.shiftTypeId,
    this.planningId,
    this.imeiId,
    this.khodroAgnecyId,
    this.shiftId,
    this.tarhId,
    this.nStatus,
    this.nVisible,
    this.nPlanType,
    this.tarhNameText,
    this.tarhCode,
    this.nImei,
    this.shiftCode,
    this.shiftName,
    this.plakKhodroTypeText,
    this.mahalCode,
    this.mahalNameText,
    this.agencyCode,
    this.aidPerCodeId,
    this.agencyName,
    this.aidPerName1,
    this.plakText,
    this.khodroTypeText,
    this.khodroTypeId,
    this.lastLocationLatitude,
    this.lastLocationLongitude,
    this.mahalId,
    this.ostanNamayandegiText,
    this.ostanNamayandegiCode,
    this.shahrNamayandegiText,
    this.shahrNamayandegiCode,
    this.navganTypeText,
    this.navganTypeCode,
    this.navganTypeCodeStr,
    this.nationalCode,
    this.isDeleted,
    this.isActive,
    this.status,
    this.statusName,
    this.statusTitle,
    this.isDriving,
    this.avlIsOnline,
    this.emdadgarCount,
    this.emdadgars,
    this.distanceKmToOrigin,
    this.priority,
    this.inShift,
    this.inVacation,
    this.shiftIsOffline,
    this.isDepotEnabled,
    this.isHomeService,
    this.isEmdadService,
    this.limitationStateStr,
    this.planAidPeople,
    this.emdadServiceId,
  });

  EmdadgarEntity copyWith({
    int? id,
    String? startDateText,
    String? endDateText,
    String? shiftTypeText,
    int? shiftTypeId,
    int? planningId,
    int? imeiId,
    int? khodroAgnecyId,
    int? shiftId,
    int? tarhId,
    int? nStatus,
    int? nVisible,
    int? nPlanType,
    String? tarhNameText,
    int? tarhCode,
    String? nImei,
    int? shiftCode,
    String? shiftName,
    String? plakKhodroTypeText,
    String? mahalCode,
    String? mahalNameText,
    String? agencyCode,
    int? aidPerCodeId,
    String? agencyName,
    String? aidPerName1,
    String? plakText,
    String? khodroTypeText,
    int? khodroTypeId,
    double? lastLocationLatitude,
    double? lastLocationLongitude,
    int? mahalId,
    String? ostanNamayandegiText,
    String? ostanNamayandegiCode,
    String? shahrNamayandegiText,
    String? shahrNamayandegiCode,
    String? navganTypeText,
    int? navganTypeCode,
    String? navganTypeCodeStr,
    String? nationalCode,
    bool? isDeleted,
    bool? isActive,
    int? status,
    String? statusName,
    String? statusTitle,
    bool? isDriving,
    bool? avlIsOnline,
    int? emdadgarCount,
    List<EmdadgarBriefInfoEntity>? emdadgars,
    double? distanceKmToOrigin,
    int? priority,
    bool? inShift,
    bool? inVacation,
    bool? shiftIsOffline,
    bool? isDepotEnabled,
    bool? isHomeService,
    bool? isEmdadService,
    String? limitationStateStr,
    List<PlanAidPersonEntity>? planAidPeople,
    int? emdadServiceId,
  }) {
    return EmdadgarEntity(
      id: id ?? this.id,
      startDateText: startDateText ?? this.startDateText,
      endDateText: endDateText ?? this.endDateText,
      shiftTypeText: shiftTypeText ?? this.shiftTypeText,
      shiftTypeId: shiftTypeId ?? this.shiftTypeId,
      planningId: planningId ?? this.planningId,
      imeiId: imeiId ?? this.imeiId,
      khodroAgnecyId: khodroAgnecyId ?? this.khodroAgnecyId,
      shiftId: shiftId ?? this.shiftId,
      tarhId: tarhId ?? this.tarhId,
      nStatus: nStatus ?? this.nStatus,
      nVisible: nVisible ?? this.nVisible,
      nPlanType: nPlanType ?? this.nPlanType,
      tarhNameText: tarhNameText ?? this.tarhNameText,
      tarhCode: tarhCode ?? this.tarhCode,
      nImei: nImei ?? this.nImei,
      shiftCode: shiftCode ?? this.shiftCode,
      shiftName: shiftName ?? this.shiftName,
      plakKhodroTypeText: plakKhodroTypeText ?? this.plakKhodroTypeText,
      mahalCode: mahalCode ?? this.mahalCode,
      mahalNameText: mahalNameText ?? this.mahalNameText,
      agencyCode: agencyCode ?? this.agencyCode,
      aidPerCodeId: aidPerCodeId ?? this.aidPerCodeId,
      agencyName: agencyName ?? this.agencyName,
      aidPerName1: aidPerName1 ?? this.aidPerName1,
      plakText: plakText ?? this.plakText,
      khodroTypeText: khodroTypeText ?? this.khodroTypeText,
      khodroTypeId: khodroTypeId ?? this.khodroTypeId,
      lastLocationLatitude: lastLocationLatitude ?? this.lastLocationLatitude,
      lastLocationLongitude:
          lastLocationLongitude ?? this.lastLocationLongitude,
      mahalId: mahalId ?? this.mahalId,
      ostanNamayandegiText: ostanNamayandegiText ?? this.ostanNamayandegiText,
      ostanNamayandegiCode: ostanNamayandegiCode ?? this.ostanNamayandegiCode,
      shahrNamayandegiText: shahrNamayandegiText ?? this.shahrNamayandegiText,
      shahrNamayandegiCode: shahrNamayandegiCode ?? this.shahrNamayandegiCode,
      navganTypeText: navganTypeText ?? this.navganTypeText,
      navganTypeCode: navganTypeCode ?? this.navganTypeCode,
      navganTypeCodeStr: navganTypeCodeStr ?? this.navganTypeCodeStr,
      nationalCode: nationalCode ?? this.nationalCode,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      status: status ?? this.status,
      statusName: statusName ?? this.statusName,
      statusTitle: statusTitle ?? this.statusTitle,
      isDriving: isDriving ?? this.isDriving,
      avlIsOnline: avlIsOnline ?? this.avlIsOnline,
      emdadgarCount: emdadgarCount ?? this.emdadgarCount,
      emdadgars: emdadgars ?? this.emdadgars,
      distanceKmToOrigin: distanceKmToOrigin ?? this.distanceKmToOrigin,
      priority: priority ?? this.priority,
      inShift: inShift ?? this.inShift,
      inVacation: inVacation ?? this.inVacation,
      shiftIsOffline: shiftIsOffline ?? this.shiftIsOffline,
      isDepotEnabled: isDepotEnabled ?? this.isDepotEnabled,
      isHomeService: isHomeService ?? this.isHomeService,
      isEmdadService: isEmdadService ?? this.isEmdadService,
      limitationStateStr: limitationStateStr ?? this.limitationStateStr,
      planAidPeople: planAidPeople ?? this.planAidPeople,
      emdadServiceId: emdadServiceId ?? this.emdadServiceId,
    );
  }

  EmdadgarModel toModel() {
    return EmdadgarModel(
      id: id,
      startDateText: startDateText,
      endDateText: endDateText,
      shiftTypeText: shiftTypeText,
      shiftTypeId: shiftTypeId,
      planningId: planningId,
      imeiId: imeiId,
      khodroAgnecyId: khodroAgnecyId,
      shiftId: shiftId,
      tarhId: tarhId,
      nStatus: nStatus,
      nVisible: nVisible,
      nPlanType: nPlanType,
      tarhNameText: tarhNameText,
      tarhCode: tarhCode,
      nImei: nImei,
      shiftCode: shiftCode,
      shiftName: shiftName,
      plakKhodroTypeText: plakKhodroTypeText,
      mahalCode: mahalCode,
      mahalNameText: mahalNameText,
      agencyCode: agencyCode,
      aidPerCodeId: aidPerCodeId,
      agencyName: agencyName,
      aidPerName1: aidPerName1,
      plakText: plakText,
      khodroTypeText: khodroTypeText,
      khodroTypeId: khodroTypeId,
      lastLocationLatitude: lastLocationLatitude,
      lastLocationLongitude: lastLocationLongitude,
      mahalId: mahalId,
      ostanNamayandegiText: ostanNamayandegiText,
      ostanNamayandegiCode: ostanNamayandegiCode,
      shahrNamayandegiText: shahrNamayandegiText,
      shahrNamayandegiCode: shahrNamayandegiCode,
      navganTypeText: navganTypeText,
      navganTypeCode: navganTypeCode,
      navganTypeCodeStr: navganTypeCodeStr,
      nationalCode: nationalCode,
      isDeleted: isDeleted,
      isActive: isActive,
      status: status,
      statusName: statusName,
      statusTitle: statusTitle,
      isDriving: isDriving,
      avlIsOnline: avlIsOnline,
      emdadgarCount: emdadgarCount,
      emdadgars: emdadgars,
      distanceKmToOrigin: distanceKmToOrigin,
      priority: priority,
      inShift: inShift,
      inVacation: inVacation,
      shiftIsOffline: shiftIsOffline,
      isDepotEnabled: isDepotEnabled,
      isHomeService: isHomeService,
      isEmdadService: isEmdadService,
      limitationStateStr: limitationStateStr,
      planAidPeople: planAidPeople,
      emdadServiceId: emdadServiceId,
    );
  }
}
