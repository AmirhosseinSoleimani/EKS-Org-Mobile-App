import 'package:eks_sana_plus_org/src/features/imei/presentation/pages/imei_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImeiRoutes {
  const ImeiRoutes._();
  static List<RouteBase> routes(Page Function({
  required Widget child,
  required GoRouterState state,
  }) getPage) {
    return [
      GoRoute(
        path: ImeiPage.path,
        name: ImeiPage.name,
        pageBuilder: (context, state) => getPage(
          child: const ImeiPage(),
          state: state,
        ),
      ),
    ];
  }
}
