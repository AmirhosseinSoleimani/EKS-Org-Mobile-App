import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:eks_sana_plus_org/src/app/cubit/app_cubit/app_state.dart';
import 'package:eks_sana_plus_org/src/common/event_bus/app_event_bus.dart';
import 'package:eks_sana_plus_org/src/common/global_variables/globals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppCubit extends Cubit<AppState> {

  final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();


  StreamSubscription? _deepLinkSubscription;
  StreamSubscription? _appEventSub;
  AppCubit():super(const AppState.initial()) {
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

  void _safeEmit(AppState state) {
    if (!isClosed) emit(state);
  }

  void dispose() {
    _deepLinkSubscription?.cancel();
    _appEventSub?.cancel();
    super.close();
  }
}
