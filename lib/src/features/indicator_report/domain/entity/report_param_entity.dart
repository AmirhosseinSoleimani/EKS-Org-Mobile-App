import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/report_param_model.dart';

class ReportParamEntity {
  const ReportParamEntity({
    this.serviceType,
    this.fromDateTime,
    this.toDateTime,
  });

  final ServiceType? serviceType;
  final DateTime? fromDateTime;
  final DateTime? toDateTime;

  ReportParamEntity copyWith({
    ServiceType? serviceType,
    DateTime? fromDateTime,
    DateTime? toDateTime,
  }) {
    return ReportParamEntity(
      serviceType: serviceType ?? this.serviceType,
      fromDateTime: fromDateTime ?? this.fromDateTime,
      toDateTime: toDateTime ?? this.toDateTime,
    );
  }

  ReportParamModel toModel() {
    return ReportParamModel(
      serviceType: serviceType,
      fromDateTime: fromDateTime,
      toDateTime: toDateTime,
    );
  }
}