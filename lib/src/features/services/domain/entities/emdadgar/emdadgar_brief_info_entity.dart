import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/emdadgar_brief_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_report_entity.dart';

class EmdadgarBriefInfoEntity {
  String? agencyCode;
  int? aidPerCode;
  String? aidPerName;
  bool? inVacation;
  bool? isActive;
  EmdadgarReportEntity? report;

  EmdadgarBriefInfoEntity({
    this.agencyCode,
    this.aidPerCode,
    this.aidPerName,
    this.inVacation,
    this.isActive,
    this.report,
  });

  EmdadgarBriefInfoModel toModel() {
    return EmdadgarBriefInfoModel(
      agencyCode: agencyCode,
      aidPerCode: aidPerCode,
      aidPerName: aidPerName,
      inVacation: inVacation,
      isActive: isActive,
      report: report,
    );
  }
}
