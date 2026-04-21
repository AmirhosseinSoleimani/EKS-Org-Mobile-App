import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_evaluation_history_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'evaluation_history_cubit.freezed.dart';

part 'evaluation_history_state.dart';

@injectable
class EvaluationHistoryCubit extends Cubit<EvaluationHistoryState> {
  final GetEvaluationHistoryListUseCase _getEvaluationHistoryListUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;

  EvaluationHistoryCubit(
    this._getEvaluationHistoryListUseCase,
    this._fetchSelectedRequestItemUseCase,
  ) : super(const EvaluationHistoryState.idle());

  BaseRequestEntity? selectedRequest;
  final List<EvaluationHistoryItemEntity> items = [];

  int? requestId;


  Future<void> init() async {
    emit(const EvaluationHistoryState.loading());

    final BaseRequestEntity? cachedRequest =
        await _fetchSelectedRequestItemUseCase();

    if (cachedRequest == null) {
      _safeEmit(
        const EvaluationHistoryState.error(
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'در دریافت اطلاعات درخواست مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }

    selectedRequest = cachedRequest;
    requestId = cachedRequest.id;

    await _loadEvaluationHistoryList();
  }

  Future<void> _loadEvaluationHistoryList() async {

    items.clear();

    final result = await _getEvaluationHistoryListUseCase(
      ServiceRequestParamEntity(
        serviceType: selectedRequest is HomeServiceRequestEntity
            ? ServiceType.homeService.value
            : ServiceType.reliefService.value,
        serviceRequestId: selectedRequest?.id,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        items.addAll(data);
        _safeEmit(const EvaluationHistoryState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          EvaluationHistoryState.error(
            message: BottomSheetMessageModel(
              message: msg ?? 'خطای غیر منتظره',
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const EvaluationHistoryState.connectionError()),
    );
  }



  void _safeEmit(EvaluationHistoryState state) {
    if (!isClosed) emit(state);
  }
}
