import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:eks_sana_plus_org/src/app/cubit/app_cubit/app_state.dart';
import 'package:eks_sana_plus_org/src/common/event_bus/app_event_bus.dart';
import 'package:eks_sana_plus_org/src/common/global_variables/globals.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_sync_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/use_cases/sync_current_session_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  final SyncCurrentSessionUseCase _syncCurrentSessionUseCase;
  final CurrentSessionManager _currentSessionManager;
  static const Duration _currentSessionMaxAge = Duration(minutes: 5);
  bool _isCurrentSessionSyncing = false;

  final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();


  StreamSubscription? _deepLinkSubscription;
  StreamSubscription? _appEventSub;

  AppCubit(
      this._syncCurrentSessionUseCase,
      this._currentSessionManager,
      ) :super(const AppState.initial()) {
    if (!kIsWeb) {
      initDeepLinkListener();
    }
    appEventBusListener();
  }

  void initDeepLinkListener() {
    final appLinks = AppLinks();
    _deepLinkSubscription = appLinks.uriLinkStream.listen((uri) {
      String? refId = uri.queryParameters['refId'];
      if (refId != null) {
        globalRefId = refId;
        emit(AppState.deepLinkReceived(refId: refId));
      }
    });
  }

  void appEventBusListener() {
    _appEventSub = AppEventBus.stream.listen((event) {
      switch(event){
        case AppEvent.tokenExpired:
          _safeEmit(AppState.unauthenticated(
            DateTime.now().millisecondsSinceEpoch,
          ));
          break;
        case AppEvent.noInternet:
          debugPrint("noInternet connection!");
          break;
      }
    });
  }


  Future<void> ensureCurrentSessionSynced({
    bool force = false,
    bool silent = true,
  }) async {
    if (_isCurrentSessionSyncing) return;

    final shouldSync =
        force ||
            !_currentSessionManager.hasSession ||
            _currentSessionManager.isStale(_currentSessionMaxAge);

    if (!shouldSync) return;

    _isCurrentSessionSyncing = true;

    try {
      final result = await _syncCurrentSessionUseCase.call(
        clearOnFailure: !silent,
      );

      switch (result.status) {
        case CurrentSessionSyncStatus.success:
          break;

        case CurrentSessionSyncStatus.empty:
        case CurrentSessionSyncStatus.failure:
          if (!silent) {
            emit(const AppState.unauthenticated());
          }
          break;

        case CurrentSessionSyncStatus.connectionError:
          if (!silent) {
           // emit(const AppState.connectionError());
          }
          break;
      }
    } finally {
      _isCurrentSessionSyncing = false;
    }
  }




  void _safeEmit(AppState state) {
    if (!isClosed) emit(state);
  }

  void dispose() {
    _deepLinkSubscription?.cancel();
    _appEventSub?.cancel();
    super.close();
  }
}
