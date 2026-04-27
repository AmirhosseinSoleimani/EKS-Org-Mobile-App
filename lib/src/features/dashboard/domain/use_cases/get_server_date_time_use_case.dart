import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/server_date_time_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/repositories/dashboard_report_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetServerDateTimeUseCase
    extends BaseUseCaseNoArgs<ApiResult<ServerDateTimeEntity?>> {
  GetServerDateTimeUseCase(this._repository);

  final DashboardReportRepository _repository;

  @override
  Future<ApiResult<ServerDateTimeEntity?>> call() async {
    return await _repository.getServerDateTime();
  }
}
