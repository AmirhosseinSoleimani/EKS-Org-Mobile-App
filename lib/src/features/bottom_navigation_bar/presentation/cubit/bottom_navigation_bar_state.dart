import 'package:freezed_annotation/freezed_annotation.dart';
part 'bottom_navigation_bar_state.freezed.dart';

@freezed
abstract  class BottomNavigationBarState with _$BottomNavigationBarState {
  const factory BottomNavigationBarState.currentIndex(int currentIndex, {@Default(0) int activeCount,}) = _CurrentIndexState;
}