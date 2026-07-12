import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_form_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_image_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_list_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_location_page.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/pages/emdad_unit_persons_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef EmdadUnitPageBuilder = Page Function({
  required Widget child,
  required GoRouterState state,
});

class EmdadUnitRoutes {
  const EmdadUnitRoutes._();

  static List<RouteBase> routes(EmdadUnitPageBuilder getPage) {
    return [
      GoRoute(
        path: EmdadUnitListPage.path,
        name: EmdadUnitListPage.name,
        pageBuilder: (context, state) => getPage(
          child: const EmdadUnitListPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: EmdadUnitFormPage.path,
        name: EmdadUnitFormPage.name,
        pageBuilder: (context, state) => getPage(
          child: const EmdadUnitFormPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: EmdadUnitImagePage.path,
        name: EmdadUnitImagePage.name,
        pageBuilder: (context, state) {
          final item = state.extra as EmdadUnitEntity;
          return getPage(
            child: EmdadUnitImagePage(item: item),
            state: state,
          );
        },
      ),
      GoRoute(
        path: EmdadUnitPersonsPage.path,
        name: EmdadUnitPersonsPage.name,
        pageBuilder: (context, state) {
          final item = state.extra as EmdadUnitEntity;
          return getPage(
            child: EmdadUnitPersonsPage(item: item),
            state: state,
          );
        },
      ),
      GoRoute(
        path: EmdadUnitLocationPage.path,
        name: EmdadUnitLocationPage.name,
        pageBuilder: (context, state) {
          final item = state.extra as EmdadUnitEntity;
          return getPage(
            child: EmdadUnitLocationPage(item: item),
            state: state,
          );
        },
      ),
    ];
  }
}
