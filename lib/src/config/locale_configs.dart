
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class LocaleConfigs {
  static Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates {
    return [
      PersianMaterialLocalizations.delegate,
      PersianCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }
}
