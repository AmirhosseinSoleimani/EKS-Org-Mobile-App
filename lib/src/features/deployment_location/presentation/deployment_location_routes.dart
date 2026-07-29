import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/pages/deployment_location_form_page.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/pages/deployment_location_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeploymentLocationRoutes {
  const DeploymentLocationRoutes._();

  static List<RouteBase> routes(
    Page Function({
      required Widget child,
      required GoRouterState state,
    }) getPage,
  ) {
    return [
      GoRoute(
        path: DeploymentLocationPage.path,
        name: DeploymentLocationPage.name,
        pageBuilder: (context, state) => getPage(
          child: const DeploymentLocationPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: DeploymentLocationFormPage.path,
        name: DeploymentLocationFormPage.name,
        pageBuilder: (context, state) {
          final args = state.extra;
          return getPage(
            child: args is DeploymentLocationFormPageArgs
                ? DeploymentLocationFormPage(locationId: args.id)
                : const DeploymentLocationFormPage(),
            state: state,
          );
        },
      ),
    ];
  }
}
