import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_report_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_report_entity.dart';

class EmdadgarReportModel extends EmdadgarReportEntity {
  EmdadgarReportModel({super.daily, super.weekly});

  factory EmdadgarReportModel.fromJson(Map<String, dynamic> json) {
    return EmdadgarReportModel(
      daily: json["daily"] != null
          ? EmdadgarReportDetailModel.fromJson(json["daily"])
          : null,
      weekly: json["weekly"] != null
          ? EmdadgarReportDetailModel.fromJson(json["weekly"])
          : null,
    );
  }
}
