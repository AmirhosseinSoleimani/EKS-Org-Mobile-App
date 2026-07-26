import 'package:eks_sana_plus_org/src/features/shift/presentation/pages/shift_form_page.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/pages/shift_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef ShiftPageBuilder = Page Function({
  required Widget child,
  required GoRouterState state,
});

class ShiftRoutes {
  const ShiftRoutes._();

  static List<RouteBase> routes(ShiftPageBuilder getPage) {
    return [
      GoRoute(
        path: ShiftListPage.path,
        name: ShiftListPage.name,
        pageBuilder: (context, state) => getPage(
          child: const ShiftListPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: ShiftFormPage.path,
        name: ShiftFormPage.name,
        pageBuilder: (context, state) {
          final extra = state.extra;
          final id = extra is int ? extra : null;
          return getPage(
            child: ShiftFormPage(id: id),
            state: state,
          );
        },
      ),
    ];
  }
}
