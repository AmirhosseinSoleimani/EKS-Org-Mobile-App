import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';

class InternetSettingsLauncher {
  InternetSettingsLauncher._();

  static Future<void> open() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        await AppSettings.openAppSettings(type: AppSettingsType.wifi);
        return;
      }

      await AppSettings.openAppSettings();
    } catch (_) {
      try {
        await AppSettings.openAppSettings();
      } catch (_) {
        // There is no further platform-level fallback available here.
      }
    }
  }
}
