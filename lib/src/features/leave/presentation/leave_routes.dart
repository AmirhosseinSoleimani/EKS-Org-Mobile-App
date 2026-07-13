import 'package:eks_sana_plus_org/src/features/leave/presentation/pages/leave_details_page.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/pages/leave_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class LeaveRoutes {
  const LeaveRoutes._();

  static List<RouteBase> routes(Page<dynamic> Function({
    required Widget child,
    required GoRouterState state,
  }) getPage) {
    return [
      GoRoute(
        path: LeavePage.path,
        name: LeavePage.name,
        pageBuilder: (context, state) => getPage(
          child: const LeavePage(),
          state: state,
        ),
      ),
      GoRoute(
        path: LeaveDetailsPage.path,
        name: LeaveDetailsPage.name,
        pageBuilder: (context, state) {
          final id = state.extra as int? ?? 0;
          return getPage(
            child: LeaveDetailsPage(id: id),
            state: state,
          );
        },
      ),
    ];
  }
}

