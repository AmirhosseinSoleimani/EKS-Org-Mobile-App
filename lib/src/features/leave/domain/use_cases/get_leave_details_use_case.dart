import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_details_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/repositories/leave_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLeaveDetailsUseCase
    extends BaseUseCase<ApiResult<LeaveDetailsEntity>, int> {
  GetLeaveDetailsUseCase(this._repository);

  final LeaveRepository _repository;

  @override
  Future<ApiResult<LeaveDetailsEntity>> call(arg) {
    return _repository.getLeaveDetails(arg);
  }
}

