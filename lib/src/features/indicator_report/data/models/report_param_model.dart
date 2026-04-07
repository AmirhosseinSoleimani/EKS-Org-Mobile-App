import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/report_param_entity.dart';

class ReportParamModel extends ReportParamEntity {
  const ReportParamModel({
    super.serviceType,
    super.fromDateTime,
    super.toDateTime,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (serviceType != null) {
      map['serviceType'] = serviceType;
    }

    if (fromDateTime != null) {
      map['fromDateTime'] = _formatDate(fromDateTime!);
    }

    if (toDateTime != null) {
      map['toDateTime'] = _formatDate(toDateTime!);
    }

    return map;
  }

  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }
}
