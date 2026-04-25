import 'package:freezed_annotation/freezed_annotation.dart';
part 'bottom_navigation_bar_state.freezed.dart';

@freezed
class BottomNavigationBarState with _$BottomNavigationBarState {
  const factory BottomNavigationBarState.currentIndex(int currentIndex, {@Default(0) int activeCount,}) = _CurrentIndexState;

  @override
  // TODO: implement activeCount
  int get activeCount => throw UnimplementedError();

  @override
  // TODO: implement currentIndex
  int get currentIndex => throw UnimplementedError();
}