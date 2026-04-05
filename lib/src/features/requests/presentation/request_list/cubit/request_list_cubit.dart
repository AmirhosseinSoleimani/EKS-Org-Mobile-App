import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_status.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_type.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/use_case/get_all_request_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/use_case/set_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/cubit/request_list_state.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RequestListCubit extends Cubit<RequestListState> {
  final GetAllRequestListUseCase _fetchRequestHistoryUseCase;
  final SetSelectedRequestItemUseCase _setSelectedRequestItemUseCase;

  RequestListCubit(this._fetchRequestHistoryUseCase,
      this._setSelectedRequestItemUseCase)
      : super(const RequestListState.idle());

  final List<RequestEntity> reliefHistoryRequests = [];
  final List<RequestEntity> reliefActiveRequests = [];

  final List<RequestEntity> homeServiceHistoryRequests = [];
  final List<RequestEntity> homeServiceActiveRequests = [];

  init() async {
    _fetchRequestsHistory();
  }

  void selectTab(RequestType tab) {
    emit(RequestListState.tabSelected(tab));
  }

  void setSelectedRequest(RequestEntity item) async {
    await _setSelectedRequestItemUseCase(item);
  }

  Future<void> _fetchRequestsHistory() async {
    emit(const RequestListState.fetchRequestListLoading());
    reliefHistoryRequests.clear();
    reliefActiveRequests.clear();

    homeServiceHistoryRequests.clear();
    homeServiceActiveRequests.clear();

    final result = await _fetchRequestHistoryUseCase();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        for (final item in data) {
          if (item == null) continue;

          final requestType = RequestType.fromValue(item.type);
          final requestStatus = RequestStatus.fromValue(item.status);

          if (requestType == null) continue;

          final isActive = requestStatus.isActive;

          switch (requestType) {
            case RequestType.reliefService:
              (isActive ? reliefActiveRequests : reliefHistoryRequests)
                  .add(item);
              break;
            case RequestType.homeService:
              (isActive ? homeServiceActiveRequests : homeServiceHistoryRequests)
                  .add(item);
              break;
          }
        }
        emit(const RequestListState.fetchRequestListSuccess());
      },
      failure: (error, msg) {
        emit(RequestListState.error(
            message: BottomSheetMessageModel(
                message: msg ?? 'خطای غیر منتظره', title: '')));
      },
      connectionError: () => emit(const RequestListState.connectionError()),
    );
  }
}
