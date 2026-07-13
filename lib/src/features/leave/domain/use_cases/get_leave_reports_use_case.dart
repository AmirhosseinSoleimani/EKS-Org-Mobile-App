import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_list_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/get_leave_reports_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/repositories/leave_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLeaveReportsUseCase extends BaseUseCase<
    ApiResult<List<LeaveListItemEntity>>, GetLeaveReportsParamEntity> {
  GetLeaveReportsUseCase(this._repository);

  final LeaveRepository _repository;

  @override
  Future<ApiResult<List<LeaveListItemEntity>>> call(arg) {
    return _repository.getLeaveReports(arg);
  }
}

