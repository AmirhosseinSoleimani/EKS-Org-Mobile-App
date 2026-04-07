import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/bottom_navigation_bar/presentation/pages/bottom_nav_page.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/presentation/dashboard_page.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/indicator_report_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/services_page.dart';
import 'startup_guard.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
RouteObserver<ModalRoute<void>>();

class Routes {

  static final parentNavigatorKey = GlobalKey<NavigatorState>();

  static final dashboardNavigatorKey = GlobalKey<NavigatorState>();
  static final indicatorNavigatorKey = GlobalKey<NavigatorState>();
  static final servicesNavigatorKey = GlobalKey<NavigatorState>();

  static final rootScaffoldKey = GlobalKey<ScaffoldState>();

  static Future<GoRouter> routes({String? initialLocation}) async {

    final startupGuard = getIt<StartupGuard>();

    return GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: LoginPage.path,
      refreshListenable: startupGuard,
      observers: [
        routeObserver
      ],

      routes: [
        GoRoute(
          path: LoginPage.path,
          name: LoginPage.name,
          pageBuilder: (context, state) =>
              getPage(
                child: const LoginPage(),
                state: state,
              ),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return BottomNavPage(
              navigationShell: navigationShell,
            );
          },

          branches: [
            /// DASHBOARD
            StatefulShellBranch(
              navigatorKey: dashboardNavigatorKey,
              routes: [
                GoRoute(
                  path: DashboardPage.path,
                  name: DashboardPage.name,
                  pageBuilder: (context, state) =>
                      getPage(
                        child: const DashboardPage(),
                        state: state,
                      ),
                ),
              ],
            ),
            /// SERVICES
            StatefulShellBranch(
              navigatorKey: servicesNavigatorKey,
              routes: [
                GoRoute(
                  path: ServicesPage.path,
                  name: ServicesPage.name,
                  pageBuilder: (context, state) =>
                      getPage(
                        child: const ServicesPage(),
                        state: state,
                      ),
                ),
              ],
            ),
            /// INDICATOR REPORT
            StatefulShellBranch(
              navigatorKey: indicatorNavigatorKey,
              routes: [
                GoRoute(
                  path: IndicatorReportPage.path,
                  name: IndicatorReportPage.name,
                  pageBuilder: (context, state) =>
                      getPage(
                        child: const IndicatorReportPage(),
                        state: state,
                      ),
                ),
              ],
            ),
          ],
        )

      ],
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}
