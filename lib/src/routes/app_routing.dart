import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/login_page.dart';
import 'package:eks_sana_plus_org/src/features/bottom_navigation_bar/presentation/pages/bottom_nav_page.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/presentation/dashboard_page.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/indicator_report_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cartable_cycle_page/cartable_cycle_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/chassis_request_history_page/chassis_request_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_history/evaluation_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/home_service_request_list_page/home_service_request_list_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/non_cooperation_page/non_cooperation_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/relief_request_list_page/relief_request_list_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/request_status_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/services_page/services_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                      getPage(child: const ServicesPage(), state: state),
                  routes: [
                    GoRoute(
                      path: ReliefRequestListPage.path,
                      name: ReliefRequestListPage.name,
                      pageBuilder: (context, state) => getPage(
                        child: const ReliefRequestListPage(),
                        state: state,
                      ),
                    ),
                    GoRoute(
                      path: HomeServiceRequestListPage.path,
                      name: HomeServiceRequestListPage.name,
                      pageBuilder: (context, state) => getPage(
                        child: const HomeServiceRequestListPage(),
                        state: state,
                      ),
                    ),
                  ],
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
        ),
        GoRoute(
          path: RequestDetailPage.path,
          name: RequestDetailPage.name,
          pageBuilder: (context, state) {
            final int? id = state.extra as int?;
            return getPage(
              child: RequestDetailPage(id: id),
              state: state,
            );
          },
        ),
        GoRoute(
          path: NonCooperationPage.path,
          name: NonCooperationPage.name,
          pageBuilder: (context, state) => getPage(
            child: const NonCooperationPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: CartableCyclePage.path,
          name: CartableCyclePage.name,
          pageBuilder: (context, state) => getPage(
            child: const CartableCyclePage(),
            state: state,
          ),
        ),
        GoRoute(
          path: EvaluationHistoryPage.path,
          name: EvaluationHistoryPage.name,
          pageBuilder: (context, state) => getPage(
            child: const EvaluationHistoryPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: RequestStatusHistoryPage.path,
          name: RequestStatusHistoryPage.name,
          pageBuilder: (context, state) => getPage(
            child: const RequestStatusHistoryPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: ChassisRequestHistoryPage.path,
          name: ChassisRequestHistoryPage.name,
          pageBuilder: (context, state) => getPage(
            child: const ChassisRequestHistoryPage(),
            state: state,
          ),
        ),
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
