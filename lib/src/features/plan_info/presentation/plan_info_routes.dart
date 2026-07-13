import 'package:eks_sana_plus_org/src/features/plan_info/presentation/plan_info_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlanInfoRoutes {
  static List<RouteBase> routes(Page Function({
    required Widget child,
    required GoRouterState state,
  }) getPage) {
    return [
      GoRoute(
        path: PlanInfoPage.path,
        name: PlanInfoPage.name,
        pageBuilder: (context, state) => getPage(
          child: const PlanInfoPage(),
          state: state,
        ),
      ),
    ];
  }
}
