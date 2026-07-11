import 'dart:async';

import 'package:flutter/widgets.dart';

class CurrentSessionSyncNavigatorObserver extends NavigatorObserver {
  final Future<void> Function() onRouteChanged;

  CurrentSessionSyncNavigatorObserver({
    required this.onRouteChanged,
  });

  void _sync() {
    unawaited(onRouteChanged());
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _sync();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _sync();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _sync();
  }
}