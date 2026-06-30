import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/chassis_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_chassis_request_history_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chassis_request_history_cubit.freezed.dart';
part 'chassis_request_history_state.dart';

@injectable
class ChassisRequestHistoryCubit extends Cubit<ChassisRequestHistoryState> {
  final GetChassisRequestHistoryListUseCase
      _getChassisRequestHistoryListUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;

  ChassisRequestHistoryCubit(
    this._getChassisRequestHistoryListUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
  ) : super(const ChassisRequestHistoryState.idle());

  BaseRequestEntity? selectedRequest;
  final List<ChassisRequestHistoryEntity> items = [];



  Future<void> init() async {
    selectedRequest  =
        await _fetchSelectedRequestItemUseCase();
    if (selectedRequest == null) {
      _safeEmit(
        const ChassisRequestHistoryState.error(
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'در دریافت اطلاعات درخواست مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }
    emit(const ChassisRequestHistoryState.loading());

    await _refreshRequestData();

    await _loadChassisNumberHistoryList();
  }

  Future<void> _refreshRequestData() async {
    final id = selectedRequest?.id ?? 0;
    final result = selectedRequest!.isHomeService
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

    result.whenOrNull(
      success: (data, _, _) {
        selectedRequest = data;
      },
    );
  }

  Future<void> _loadChassisNumberHistoryList() async {
    items.clear();

    final result = await _getChassisRequestHistoryListUseCase(
      ChassisParamEntity(chassisNumber: selectedRequest?.chassisNumber),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        items.addAll(data);
        _safeEmit(const ChassisRequestHistoryState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          ChassisRequestHistoryState.error(
            message: BottomSheetMessageModel(
              message: msg ?? error.toString(),
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const ChassisRequestHistoryState.connectionError()),
    );
  }

  void _safeEmit(ChassisRequestHistoryState state) {
    if (!isClosed) emit(state);
  }
}
