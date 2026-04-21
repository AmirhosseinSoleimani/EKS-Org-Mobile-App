import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar_info_model.dart';

class EmdadgarInfoEntity {
  final int? id;
  final String? startDateText;
  final String? endDateText;
  final String? shiftTypeText;
  final int? shiftTypeId;
  final int? planningId;
  final int? khodroAgnecyId;
  final int? shiftId;
  final int? tarhId;
  final int? nStatus;
  final int? nVisible;
  final int? nPlanType;
  final String? tarhNameText;
  final int? tarhCode;
  final String? nImei;
  final int? shiftCode;
  final String? shiftName;
  final String? plakKhodroTypeText;
  final String? mahalCode;
  final String? mahalNameText;
  final String? agencyCode;
  final int? aidPerCodeId;
  final String? agencyName;
  final String? agencyCodeLabel;
  final String? aidPerName1;
  final String? plakText;
  final String? khodroTypeText;
  final int? khodroTypeId;
  final double? lastLocationLatitude;
  final double? lastLocationLongitude;
  final double? nLat;
  final double? nLong;
  final String? irancellMobile;
  final String? allEmdadgarIrancellMobile;
  final String? mobile;
  final String? allEmdadgarMobile;
  final int? mahalId;
  final String? ostanNamayandegiText;
  final String? ostanNamayandegiCode;
  final String? shahrNamayandegiText;
  final String? shahrNamayandegiCode;
  final String? navganTypeText;
  final int? navganTypeCode;
  final String? navganTypeCodeStr;
  final String? nationalCode;
  final bool? isDeleted;
  final bool? isActive;
  final int? status;
  final String? statusName;
  final String? statusTitle;
  final bool? avlIsOnline;
  final int? emdadgarCount;
  final List<dynamic>? emdadgars;
  final double? distanceKmToOrigin;
  final bool? inShift;
  final bool? inVacation;
  final bool? shiftIsOffline;
  final bool? isDepotEnabled;
  final bool? isHomeService;
  final bool? isEmdadService;
  final List<dynamic>? limitationStates;
  final String? limitationStateStr;
  final List<dynamic>? limitationStateDescriptions;
  final List<dynamic>? planAidPeople;
  final int? emdadServiceId;

  const EmdadgarInfoEntity({
    this.id,
    this.startDateText,
    this.endDateText,
    this.shiftTypeText,
    this.shiftTypeId,
    this.planningId,
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
    this.agencyCodeLabel,
    this.aidPerName1,
    this.plakText,
    this.khodroTypeText,
    this.khodroTypeId,
    this.lastLocationLatitude,
    this.lastLocationLongitude,
    this.nLat,
    this.nLong,
    this.irancellMobile,
    this.allEmdadgarIrancellMobile,
    this.mobile,
    this.allEmdadgarMobile,
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
    this.avlIsOnline,
    this.emdadgarCount,
    this.emdadgars,
    this.distanceKmToOrigin,
    this.inShift,
    this.inVacation,
    this.shiftIsOffline,
    this.isDepotEnabled,
    this.isHomeService,
    this.isEmdadService,
    this.limitationStates,
    this.limitationStateStr,
    this.limitationStateDescriptions,
    this.planAidPeople,
    this.emdadServiceId,
  });

  EmdadgarInfoEntity copyWith({
    int? id,
    String? startDateText,
    String? endDateText,
    String? shiftTypeText,
    int? shiftTypeId,
    int? planningId,
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
    String? agencyCodeLabel,
    String? aidPerName1,
    String? plakText,
    String? khodroTypeText,
    int? khodroTypeId,
    double? lastLocationLatitude,
    double? lastLocationLongitude,
    double? nLat,
    double? nLong,
    String? irancellMobile,
    String? allEmdadgarIrancellMobile,
    String? mobile,
    String? allEmdadgarMobile,
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
    bool? avlIsOnline,
    int? emdadgarCount,
    List<dynamic>? emdadgars,
    double? distanceKmToOrigin,
    bool? inShift,
    bool? inVacation,
    bool? shiftIsOffline,
    bool? isDepotEnabled,
    bool? isHomeService,
    bool? isEmdadService,
    List<dynamic>? limitationStates,
    String? limitationStateStr,
    List<dynamic>? limitationStateDescriptions,
    List<dynamic>? planAidPeople,
    int? emdadServiceId,
  }) {
    return EmdadgarInfoEntity(
      id: id ?? this.id,
      startDateText: startDateText ?? this.startDateText,
      endDateText: endDateText ?? this.endDateText,
      shiftTypeText: shiftTypeText ?? this.shiftTypeText,
      shiftTypeId: shiftTypeId ?? this.shiftTypeId,
      planningId: planningId ?? this.planningId,
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
      agencyCodeLabel: agencyCodeLabel ?? this.agencyCodeLabel,
      aidPerName1: aidPerName1 ?? this.aidPerName1,
      plakText: plakText ?? this.plakText,
      khodroTypeText: khodroTypeText ?? this.khodroTypeText,
      khodroTypeId: khodroTypeId ?? this.khodroTypeId,
      lastLocationLatitude: lastLocationLatitude ?? this.lastLocationLatitude,
      lastLocationLongitude:
          lastLocationLongitude ?? this.lastLocationLongitude,
      nLat: nLat ?? this.nLat,
      nLong: nLong ?? this.nLong,
      irancellMobile: irancellMobile ?? this.irancellMobile,
      allEmdadgarIrancellMobile:
          allEmdadgarIrancellMobile ?? this.allEmdadgarIrancellMobile,
      mobile: mobile ?? this.mobile,
      allEmdadgarMobile: allEmdadgarMobile ?? this.allEmdadgarMobile,
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
      avlIsOnline: avlIsOnline ?? this.avlIsOnline,
      emdadgarCount: emdadgarCount ?? this.emdadgarCount,
      emdadgars: emdadgars ?? this.emdadgars,
      distanceKmToOrigin: distanceKmToOrigin ?? this.distanceKmToOrigin,
      inShift: inShift ?? this.inShift,
      inVacation: inVacation ?? this.inVacation,
      shiftIsOffline: shiftIsOffline ?? this.shiftIsOffline,
      isDepotEnabled: isDepotEnabled ?? this.isDepotEnabled,
      isHomeService: isHomeService ?? this.isHomeService,
      isEmdadService: isEmdadService ?? this.isEmdadService,
      limitationStates: limitationStates ?? this.limitationStates,
      limitationStateStr: limitationStateStr ?? this.limitationStateStr,
      limitationStateDescriptions:
          limitationStateDescriptions ?? this.limitationStateDescriptions,
      planAidPeople: planAidPeople ?? this.planAidPeople,
      emdadServiceId: emdadServiceId ?? this.emdadServiceId,
    );
  }

  EmdadgarInfoModel toModel() {
    return EmdadgarInfoModel(
      id: id,
      startDateText: startDateText,
      endDateText: endDateText,
      shiftTypeText: shiftTypeText,
      shiftTypeId: shiftTypeId,
      planningId: planningId,
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
      agencyCodeLabel: agencyCodeLabel,
      aidPerName1: aidPerName1,
      plakText: plakText,
      khodroTypeText: khodroTypeText,
      khodroTypeId: khodroTypeId,
      lastLocationLatitude: lastLocationLatitude,
      lastLocationLongitude: lastLocationLongitude,
      nLat: nLat,
      nLong: nLong,
      irancellMobile: irancellMobile,
      allEmdadgarIrancellMobile: allEmdadgarIrancellMobile,
      mobile: mobile,
      allEmdadgarMobile: allEmdadgarMobile,
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
      avlIsOnline: avlIsOnline,
      emdadgarCount: emdadgarCount,
      emdadgars: emdadgars,
      distanceKmToOrigin: distanceKmToOrigin,
      inShift: inShift,
      inVacation: inVacation,
      shiftIsOffline: shiftIsOffline,
      isDepotEnabled: isDepotEnabled,
      isHomeService: isHomeService,
      isEmdadService: isEmdadService,
      limitationStates: limitationStates,
      limitationStateStr: limitationStateStr,
      limitationStateDescriptions: limitationStateDescriptions,
      planAidPeople: planAidPeople,
      emdadServiceId: emdadServiceId,
    );
  }
}
