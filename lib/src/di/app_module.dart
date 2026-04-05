import 'package:eks_sana_plus_org/src/routes/startup_guard.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @lazySingleton
  StartupGuard get startupGuard => StartupGuard();
}