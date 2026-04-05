import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_request_state.freezed.dart';

@freezed
abstract class ActiveRequestState with _$ActiveRequestState {

  const factory ActiveRequestState.idle() = _Idle;
  const factory ActiveRequestState.error({required BottomSheetMessageModel message}) = _Error;

  const factory ActiveRequestState.success() = _Success;

  const factory ActiveRequestState.loading() = _Loading;

  const factory ActiveRequestState.connectionError() = _ConnectionError;
}
