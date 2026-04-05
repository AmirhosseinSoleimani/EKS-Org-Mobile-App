import 'package:flutter/foundation.dart';

class StartupGuard extends ChangeNotifier {
  bool hasStartupCompleted = false;

  void markCompleted() {
    hasStartupCompleted = true;
    notifyListeners();
  }

  void reset() {
    hasStartupCompleted = false;
    notifyListeners();
  }
}