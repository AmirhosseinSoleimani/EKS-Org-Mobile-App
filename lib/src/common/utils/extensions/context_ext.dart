import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning }

extension ContextExtension on BuildContext {
  void showSnackBar(String message,
      {SnackBarType type = SnackBarType.success, TextStyle? textStyle}) {
    MaterialColor snackBarBackgroundColor;
    switch (type) {
      case SnackBarType.success:
        snackBarBackgroundColor = Colors.green;
        break;
      case SnackBarType.error:
        snackBarBackgroundColor = Colors.red;
        break;
      case SnackBarType.warning:
        snackBarBackgroundColor = Colors.yellow;
    }

    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message, style: textStyle),
      backgroundColor: snackBarBackgroundColor,
    ));
  }

  double screenWidth() {
    return MediaQuery.of(this).size.width;
  }
}
