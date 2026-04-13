import 'package:eks_sana_plus_org/src/features/dashboard/data/models/chart_data_model.dart';

class ChartDataEntity {
  final String title;
  final String code;
  final int count;
  final double percent;
  final String? color;

  const ChartDataEntity({
    required this.title,
    required this.code,
    required this.count,
    required this.percent,
    this.color,
  });

  ChartDataEntity copyWith({
    String? title,
    String? code,
    int? count,
    double? percent,
    String? color,
  }) {
    return ChartDataEntity(
      title: title ?? this.title,
      code: code ?? this.code,
      count: count ?? this.count,
      percent: percent ?? this.percent,
      color: color ?? this.color,
    );
  }

  ChartDataModel toModel() {
    return ChartDataModel(
      title: title,
      code: code,
      count: count,
      percent: percent,
      color: color,
    );
  }
}
