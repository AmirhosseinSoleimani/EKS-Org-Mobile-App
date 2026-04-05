import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/use_case/fetch_active_service_request_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'bottom_navigation_bar_state.dart';

@injectable
class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {

  final FetchActiveServiceRequestUseCase _fetchActiveServiceRequestUseCase;

  BottomNavigationBarCubit(this._fetchActiveServiceRequestUseCase) : super(const BottomNavigationBarState.currentIndex(0));


  final List<RequestEntity?> activeRequestList = [];

  void init() {
    _fetchActiveCount();
  }

  void _safeEmit(BottomNavigationBarState newState) {
    if (!isClosed) emit(newState);
  }

  Future<void> fetchActiveRequests() => _fetchActiveCount();

  Future<void> _fetchActiveCount() async {
    final result = await _fetchActiveServiceRequestUseCase.call();
    result.whenOrNull(
      success: (data, _, __) {
        activeRequestList..clear()..addAll(data);
        final count = (data.length);
        final currentIndex = state.maybeWhen(
          currentIndex: (i, _) => i,
          orElse: () => 0,
        );
        _safeEmit(BottomNavigationBarState.currentIndex(
          currentIndex,
          activeCount: count,
        ));
      },
      failure: (_, msg) {
        final currentIndex = state.maybeWhen(
          currentIndex: (i, _) => i,
          orElse: () => 0,
        );
        _safeEmit(BottomNavigationBarState.currentIndex(
          currentIndex,
          activeCount: 0,
        ));
      },
    );
  }

  void changeTab(int index) {
    final active = state.maybeWhen(
      currentIndex: (_, activeCount) => activeCount,
      orElse: () => 0,
    );

    if (index != state.currentIndex) {
      _safeEmit(BottomNavigationBarState.currentIndex(index, activeCount: active));
    }
    _fetchActiveCount();
  }
}