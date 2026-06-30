import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/emdadgar_report_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_brief_info_entity.dart';


class EmdadgarBriefInfoModel extends EmdadgarBriefInfoEntity {
  EmdadgarBriefInfoModel({
    super.agencyCode,
    super.aidPerCode,
    super.aidPerName,
    super.siAidPerCode,
    super.report,
    super.inVacation,
    super.isActive,
    super.hasWithoutEmdadgarCode,
  });

  factory EmdadgarBriefInfoModel.fromJson(Map<String, dynamic> json) {
    return EmdadgarBriefInfoModel(
      agencyCode: json["agencyCode"],
      aidPerCode: json["aidPerCode"],
      aidPerName: json["aidPerName"],
      siAidPerCode: json["siAidPerCode"],
      inVacation: json["inVacation"],
      isActive: json["isActive"],
      hasWithoutEmdadgarCode: json["hasWithoutEmdadgarCode"],
      report: json["report"] != null
          ? EmdadgarReportModel.fromJson(json["report"])
          : null,
    );
  }
}