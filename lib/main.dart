import 'dart:async';
import 'dart:io';

import 'package:eks_sana_plus_org/src/app/my_app.dart';
import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/di/app_environment.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/routes/app_routing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      AppConstants.isIOS = defaultTargetPlatform == TargetPlatform.iOS;

      if (!kIsWeb) {
        HttpOverrides.global = MyHttpOverrides();
      }

      configureDependencies(
        environmentFilter: buildEnvironmentFilter(),
      );

      final router = await Routes.routes();

      runApp(
        MyApp(
          routerConfig: router,
        ),
      );
    },
    (error, stack) {
      debugPrint(error.toString());
    },
  );
}

EnvironmentFilter buildEnvironmentFilter() {
  final environments = <String>{};

  if (kIsWeb) {
    environments.add(AppEnvironment.web);
  } else {
    environments.add(AppEnvironment.mobile);
  }

  activeEnvironments
    ..clear()
    ..addAll(environments);

  final stringSet = environments.map((env) => env).toSet();
  return NoEnvOrContainsAny(stringSet);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
