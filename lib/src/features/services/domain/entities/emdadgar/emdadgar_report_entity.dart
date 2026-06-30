import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/emdadgar_report_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_report_detail_entity.dart';

class EmdadgarReportEntity {
  EmdadgarReportDetailEntity? daily;
  EmdadgarReportDetailEntity? weekly;

  EmdadgarReportEntity({this.daily, this.weekly});

  EmdadgarReportModel toModel() {
    return EmdadgarReportModel(
      daily: daily,
      weekly: weekly,
    );
  }
}
