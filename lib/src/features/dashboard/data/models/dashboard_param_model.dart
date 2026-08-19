import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';

class DashboardParamModel extends DashboardParamEntity {
  const DashboardParamModel({
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
