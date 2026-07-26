import 'package:eks_sana_plus_org/src/features/navgan/presentation/pages/navgan_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavganRoutes {
  const NavganRoutes._();

  static List<RouteBase> routes(
    Page Function({
      required Widget child,
      required GoRouterState state,
    }) getPage,
  ) {
    return [
      GoRoute(
        path: NavganPage.path,
        name: NavganPage.name,
        pageBuilder: (context, state) => getPage(
          child: const NavganPage(),
          state: state,
        ),
      ),
    ];
  }
}
