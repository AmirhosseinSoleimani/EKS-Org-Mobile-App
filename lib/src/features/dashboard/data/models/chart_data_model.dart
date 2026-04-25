import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/chart_data_entity.dart';

class ChartDataModel extends ChartDataEntity {
 const ChartDataModel({
    required super.title,
    required super.code,
    required super.count,
    required super.percent,
    super.color,
  });

  factory ChartDataModel.fromJson(Map<String, dynamic> json) {
    return ChartDataModel(
      title: json['title'],
      code: json['code'] ?? '',
      count: json['count'],
      percent: (json['percent'] ?? 0).toDouble(),
      color: json['color'],
    );
  }
}
