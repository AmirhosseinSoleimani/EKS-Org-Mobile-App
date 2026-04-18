import 'dart:async';

typedef VoidFn = void Function();
class Throttler {
  Throttler({
    required this.duration,
    this.leading = true,
    this.trailing = true,
  });
  final Duration duration;
  final bool leading;
  final bool trailing;
  bool _cooldown = false;
  VoidFn? _pending;
  Timer? _timer;

  void run(VoidFn action) {
    if (!_cooldown && leading) {
      action();
      _startCooldown();
      return;
    }
    if (trailing) {
      _pending = action;
      if (!_cooldown) _startCooldown();
    }
  }
  void _startCooldown() {
    _cooldown = true;
    _timer?.cancel();
    _timer = Timer(duration, () {
      _cooldown = false;
      final pending = _pending;
      _pending = null;
      if (pending != null && trailing) {
        run(pending);
      }
    });
  }
  void dispose() => _timer?.cancel();
}

class Debouncer {
  Debouncer(this._duration);
  final Duration _duration;
  Timer? _timer;
  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(_duration, action);
  }
  void dispose() => _timer?.cancel();
}