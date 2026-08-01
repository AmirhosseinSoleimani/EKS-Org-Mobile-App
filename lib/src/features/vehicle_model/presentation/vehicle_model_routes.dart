import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/pages/vehicle_model_form_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/pages/vehicle_model_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/pages/vehicle_model_services_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VehicleModelRoutes {
  const VehicleModelRoutes._();

  static List<RouteBase> routes(
    Page Function({
      required Widget child,
      required GoRouterState state,
    }) getPage,
  ) {
    return [
      GoRoute(
        path: VehicleModelPage.path,
        name: VehicleModelPage.name,
        pageBuilder: (context, state) => getPage(
          child: const VehicleModelPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: VehicleModelFormPage.path,
        name: VehicleModelFormPage.name,
        pageBuilder: (context, state) {
          final args = state.extra;
          return getPage(
            child: args is VehicleModelFormPageArgs
                ? VehicleModelFormPage(item: args.item)
                : const VehicleModelFormPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: VehicleModelServicesPage.path,
        name: VehicleModelServicesPage.name,
        pageBuilder: (context, state) {
          final item = state.extra;
          return getPage(
            child: item is VehicleModelEntity
                ? VehicleModelServicesPage(item: item)
                : const VehicleModelPage(),
            state: state,
          );
        },
      ),
    ];
  }
}
