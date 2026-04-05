import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = AppInitial;
  const factory AppState.unauthenticated([int? nonce]) = AppUnauthenticated;
  const factory AppState.deepLinkReceived({required String refId}) = AppDeepLinkReceived;
}