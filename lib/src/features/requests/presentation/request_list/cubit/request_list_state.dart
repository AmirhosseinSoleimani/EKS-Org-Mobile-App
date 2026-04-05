import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_type.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_list_state.freezed.dart';

@freezed
abstract class RequestListState with _$RequestListState {
  const factory RequestListState.idle() = RequestListIdleState;

  const factory RequestListState.tabSelected(RequestType tab) =
      RequestListTabSelectedState;

  const factory RequestListState.error(
      {required BottomSheetMessageModel message}) = RequestListErrorState;

  const factory RequestListState.notice({required String message}) =
      RequestListNoticeState;

  const factory RequestListState.fetchRequestListSuccess() =
      RequestListFetchRequestListSuccessState;

  const factory RequestListState.fetchRequestListLoading() =
      RequestListFetchRequestListLoadingState;

  const factory RequestListState.connectionError() = _ConnectionError;
}
