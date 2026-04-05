import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_setup.config.dart';

final GetIt getIt = GetIt.instance;

final Set<String> activeEnvironments = {};

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)

void configureDependencies({EnvironmentFilter? environmentFilter}) {
  $initGetIt(
    getIt,
    environmentFilter: environmentFilter,
  );
}


