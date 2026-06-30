import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/emdadgar_brief_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_report_entity.dart';

class EmdadgarBriefInfoEntity {
  String? agencyCode;
  int? aidPerCode;
  String? aidPerName;
  int? siAidPerCode;
  bool? inVacation;
  bool? isActive;
  bool? hasWithoutEmdadgarCode;
  EmdadgarReportEntity? report;

  EmdadgarBriefInfoEntity({
    this.agencyCode,
    this.aidPerCode,
    this.aidPerName,
    this.siAidPerCode,
    this.report,
    this.inVacation,
    this.isActive,
    this.hasWithoutEmdadgarCode,
  });

  EmdadgarBriefInfoEntity copyWith({
    String? agencyCode,
    int? aidPerCode,
    String? aidPerName,
    int? siAidPerCode,
    bool? inVacation,
    bool? isActive,
    bool? hasWithoutEmdadgarCode,
    EmdadgarReportEntity? report,
  }) {
    return EmdadgarBriefInfoEntity(
      agencyCode: agencyCode ?? this.agencyCode,
      aidPerCode: aidPerCode ?? this.aidPerCode,
      aidPerName: aidPerName ?? this.aidPerName,
      siAidPerCode: siAidPerCode ?? this.siAidPerCode,
      inVacation: inVacation ?? this.inVacation,
      isActive: isActive ?? this.isActive,
      hasWithoutEmdadgarCode:
      hasWithoutEmdadgarCode ?? this.hasWithoutEmdadgarCode,
      report: report ?? this.report,
    );
  }

  EmdadgarBriefInfoModel toModel() {
    return EmdadgarBriefInfoModel(
      agencyCode: agencyCode,
      aidPerCode: aidPerCode,
      aidPerName: aidPerName,
      siAidPerCode: siAidPerCode,
      report: report,
      inVacation: inVacation,
      isActive: isActive,
      hasWithoutEmdadgarCode: hasWithoutEmdadgarCode,
    );
  }
}
