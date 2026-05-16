import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_check_depot_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/service_assign_use_case.dart';
import 'package:meta/meta.dart';

part 'assign_and_cancel_emdadgar_state.dart';

class AssignAndCancelEmdadgarCubit extends Cubit<AssignAndCancelEmdadgarState> {
  AssignAndCancelEmdadgarCubit(
 this._getEmdadgarListUseCase,
 this._serviceAssignUseCase,
 this._getCheckDepotUseCase,
      ) : super(AssignAndCancelEmdadgarInitial());

  final GetEmdadgarListUseCase _getEmdadgarListUseCase;
  final ServiceAssignUseCase  _serviceAssignUseCase;
  final GetCheckDepotUseCase _getCheckDepotUseCase;
}
