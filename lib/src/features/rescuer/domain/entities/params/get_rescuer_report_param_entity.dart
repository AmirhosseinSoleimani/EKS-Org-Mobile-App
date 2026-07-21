import 'package:eks_sana_plus_org/src/features/rescuer/data/models/params/get_rescuer_report_param_model.dart';

class GetRescuerReportParamEntity {
  final int pageSize;

  const GetRescuerReportParamEntity({
    required this.pageSize,
  });

  GetRescuerReportParamModel toModel() {
    return GetRescuerReportParamModel(pageSize: pageSize);
  }
}
