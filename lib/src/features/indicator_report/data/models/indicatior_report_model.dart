import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/indicatior_report_entity.dart';

class IndicatorReportModel extends IndicatorReportEntity {
  const IndicatorReportModel({
    super.id,
  });

  factory IndicatorReportModel.fromJson(Map<String, dynamic> json) {
    return IndicatorReportModel(
      id: json['id'],
    );
  }
}
