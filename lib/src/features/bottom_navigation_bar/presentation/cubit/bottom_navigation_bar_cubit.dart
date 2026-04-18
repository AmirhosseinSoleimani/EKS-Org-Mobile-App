import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'bottom_navigation_bar_state.dart';

@injectable
class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {

  BottomNavigationBarCubit() : super(const BottomNavigationBarState.currentIndex(0));

  void init() {

  }

  void _safeEmit(BottomNavigationBarState newState) {
    if (!isClosed) emit(newState);
  }



  void changeTab(int index) {
    final active = state.maybeWhen(
      currentIndex: (_, activeCount) => activeCount,
      orElse: () => 0,
    );

    if (index != state.currentIndex) {
      _safeEmit(BottomNavigationBarState.currentIndex(index, activeCount: active));
    }
  }
}