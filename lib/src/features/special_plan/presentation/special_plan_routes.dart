import 'package:eks_sana_plus_org/src/features/special_plan/presentation/pages/special_plan_form_page.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/pages/special_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpecialPlanRoutes {
  const SpecialPlanRoutes._();

  static List<RouteBase> routes(
    Page Function({
      required Widget child,
      required GoRouterState state,
    }) getPage,
  ) {
    return [
      GoRoute(
        path: SpecialPlanPage.path,
        name: SpecialPlanPage.name,
        pageBuilder: (context, state) => getPage(
          child: const SpecialPlanPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: SpecialPlanFormPage.path,
        name: SpecialPlanFormPage.name,
        pageBuilder: (context, state) {
          final args = state.extra;
          return getPage(
            child: args is SpecialPlanFormPageArgs
                ? SpecialPlanFormPage(initialPlan: args.plan)
                : const SpecialPlanFormPage(),
            state: state,
          );
        },
      ),
    ];
  }
}
