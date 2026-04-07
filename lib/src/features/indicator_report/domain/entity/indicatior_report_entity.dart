import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/indicatior_report_model.dart';

class IndicatorReportEntity {
  const IndicatorReportEntity({
    this.id,
  });

  final int? id;

  IndicatorReportEntity copyWith({
    int? id,
  }) {
    return IndicatorReportEntity(
      id: id ?? this.id,
    );
  }

  IndicatorReportModel toModel() {
    return IndicatorReportModel(
      id: id,
    );
  }
}
