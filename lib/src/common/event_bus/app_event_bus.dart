import 'dart:async';

enum AppEvent { tokenExpired, noInternet }

class AppEventBus {
  static final _controller = StreamController<AppEvent>.broadcast();

  static Stream<AppEvent> get stream => _controller.stream;

  static void emit(AppEvent event) {
    _controller.add(event);
  }
}
