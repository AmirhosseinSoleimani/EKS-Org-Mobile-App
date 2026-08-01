class GeneralContentSubmitController {
  Future<void> Function()? _submitCallback;

  Future<void> submit() async {
    await _submitCallback?.call();
  }

  void attach(Future<void> Function() callback) {
    _submitCallback = callback;
  }

  void detach(Future<void> Function() callback) {
    if (_submitCallback == callback) {
      _submitCallback = null;
    }
  }
}
