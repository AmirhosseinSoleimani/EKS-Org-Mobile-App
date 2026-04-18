
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.idle() = _Idle;
  const factory MapState.error({required BottomSheetMessageModel messageModel}) = _Error;
  const factory MapState.permissionSuccess() = _PermissionSuccess;
  const factory MapState.permissionError({required BottomSheetMessageModel messageModel}) = _PermissionError;
  const factory MapState.connectionError() = ConnectionErrorState;
  const factory MapState.locationToAddressLoading() = MapLocationToAddressLoadingState;
  const factory MapState.locationToAddressSuccess() = MapLocationToAddressSuccessState;
  const factory MapState.searchLoading() = MapSearchLoadingState;
  const factory MapState.searchSuccess() = MapSearchSuccessState;
  const factory MapState.searchError({required BottomSheetMessageModel bottomSheetMessageModel}) = MapSearchErrorState;
}

sealed class MapSideEffect {
  const MapSideEffect();
}
class ShowInfo extends MapSideEffect { final String message; const ShowInfo(this.message); }
class ShowError extends MapSideEffect { final String message; const ShowError(this.message); }
class AskEnableService extends MapSideEffect { const AskEnableService(); }
class AskOpenSettings extends MapSideEffect { const AskOpenSettings(); }
class NavigateToAddressInfo extends MapSideEffect { const NavigateToAddressInfo(); }
