import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/report_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';

class ReportParamModel extends ReportParamEntity {
  const ReportParamModel({
    super.serviceType,
    super.fromDateTime,
    super.toDateTime,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (serviceType != null) {
      map['serviceType'] = serviceType!.value;
    }

    if (fromDateTime != null) {
      map['fromDateTime'] = JalaliDateHelper.formatServerDateOnly(fromDateTime);
    }

    if (toDateTime != null) {
      map['toDateTime'] = JalaliDateHelper.formatServerDateOnly(toDateTime);
    }

    return map;
  }
}
