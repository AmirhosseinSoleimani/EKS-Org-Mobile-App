import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/plan_info_create_page.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/plan_info_history_page.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/plan_info_location_page.dart';
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
      GoRoute(
        path: PlanInfoCreatePage.path,
        name: PlanInfoCreatePage.name,
        pageBuilder: (context, state) {
          final args = state.extra;

          return getPage(
            child: args is PlanInfoCreateArgs
                ? PlanInfoCreatePage(
                    mode: args.mode,
                    initialPlan: args.plan,
                  )
                : const PlanInfoCreatePage(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: PlanInfoLocationPage.path,
        name: PlanInfoLocationPage.name,
        pageBuilder: (context, state) {
          final item = state.extra;
          return getPage(
            child: PlanInfoLocationPage(
              item: item is PlanInfoEntity ? item : const PlanInfoEntity(),
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        path: PlanInfoHistoryPage.path,
        name: PlanInfoHistoryPage.name,
        pageBuilder: (context, state) {
          final item = state.extra;
          return getPage(
            child: PlanInfoHistoryPage(
              item: item is PlanInfoEntity ? item : const PlanInfoEntity(),
            ),
            state: state,
          );
        },
      ),
    ];
  }
}
