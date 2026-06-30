import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_param_model.dart';

class DashboardParamEntity {
  const DashboardParamEntity({
    this.serviceType,
    this.fromDateTime,
    this.toDateTime,
  });

  final ServiceType? serviceType;
  final DateTime? fromDateTime;
  final DateTime? toDateTime;

  DashboardParamEntity copyWith({
    ServiceType? serviceType,
    DateTime? fromDateTime,
    DateTime? toDateTime,
  }) {
    return DashboardParamEntity(
      serviceType: serviceType ?? this.serviceType,
      fromDateTime: fromDateTime ?? this.fromDateTime,
      toDateTime: toDateTime ?? this.toDateTime,
    );
  }

  DashboardParamModel toModel() {
    return DashboardParamModel(
      serviceType: serviceType,
      fromDateTime: fromDateTime,
      toDateTime: toDateTime,
    );
  }
}
