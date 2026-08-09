import 'package:eks_sana_plus_org/src/app/cubit/app_cubit/app_cubit.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/agency_info_routes.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/login_page.dart';
import 'package:eks_sana_plus_org/src/features/bottom_navigation_bar/presentation/pages/bottom_nav_page.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/cartable_page.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/presentation/dashboard_page.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/deployment_location_routes.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/emdad_unit_routes.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/general_content_routes.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/grade_pattern_routes.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/emdad_vehicle_page.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/evaluation_invoice_page/evaluation_invoice_page.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_first_step/home_service_evaluation_first_step.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/imei_routes.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/indicator_report_page.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/invoice_management_routes.dart';
import 'package:eks_sana_plus_org/src/features/leave/presentation/leave_routes.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/navgan_routes.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/plan_info_location_page.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/plan_info_routes.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/rescuer_list_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/assign_and_cancel_emdadgar_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cancel_request_page/cancel_request_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cartable_cycle_page/cartable_cycle_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/change_home_service_request_address_page/change_home_service_request_address_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/change_home_service_request_time_page/change_home_service_request_time_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/chassis_request_history_page/chassis_request_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/complete_urgent_request_page/complete_urgent_request_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/control_info_page/control_info_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/emdadgar_invoice_page/emdadgar_invoice_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/evaluation_aid_service_request_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_history/evaluation_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/followup_register_page/follow_up_register_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/home_service_request_list_page/home_service_request_list_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/non_cooperation_page/non_cooperation_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/online_map_page/online_map_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/pre_invoice_page/service_invoice_request_context_loader.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/relief_request_list_page/relief_request_list_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_status_history_page/request_status_history_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/services_page/services_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/update_request_page/update_request_page.dart';
import 'package:eks_sana_plus_org/src/features/shift/presentation/shift_routes.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/skills_certificates_routes.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/special_plan_routes.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/vehicle_info_routes.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/vehicle_model_routes.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/enums/invoice_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/pages/invoice_page.dart';
import 'package:eks_sana_plus_org/src/routes/current_session_sync_navigator_observer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'startup_guard.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
RouteObserver<ModalRoute<void>>();

class Routes {

  static final parentNavigatorKey = GlobalKey<NavigatorState>();

  static final dashboardNavigatorKey = GlobalKey<NavigatorState>();
  static final cartableNavigatorKey = GlobalKey<NavigatorState>();
  static final servicesNavigatorKey = GlobalKey<NavigatorState>();
  static final representationNavigatorKey = GlobalKey<NavigatorState>();
  static final indicatorNavigatorKey = GlobalKey<NavigatorState>();

  static final rootScaffoldKey = GlobalKey<ScaffoldState>();

  static Future<GoRouter> routes({String? initialLocation}) async {

    final startupGuard = getIt<StartupGuard>();
    final appCubit = getIt<AppCubit>();
    return GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: LoginPage.path,
      refreshListenable: startupGuard,
      observers: [
        routeObserver,
        CurrentSessionSyncNavigatorObserver(
          onRouteChanged: () {
            return appCubit.ensureCurrentSessionSynced(
              silent: true,
            );
          },
        ),
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
        GoRoute(
          path: ControlInfoPage.path,
          name: ControlInfoPage.name,
          pageBuilder: (context, state) => getPage(
            child: const ControlInfoPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: InvoicePage.path,
          name: InvoicePage.name,
          pageBuilder: (context, state) => getPage(
            child: InvoicePage(
              requestContextLoader: createServiceInvoiceRequestContextLoader(),
              invoiceType: state.extra! as InvoiceType,
            ),
            state: state,
          ),
        ),
        GoRoute(
          path: OnlineMapPage.path,
          name: OnlineMapPage.name,
          pageBuilder: (context, state) => getPage(
            child: const OnlineMapPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: EmdadgarInvoicePage.path,
          name: EmdadgarInvoicePage.name,
          pageBuilder: (context, state) => getPage(
            child: const EmdadgarInvoicePage(),
            state: state,
          ),
        ),
        GoRoute(
          path: UpdateRequestPage.path,
          name: UpdateRequestPage.name,
          pageBuilder: (context, state) => getPage(
            child: const UpdateRequestPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: CancelRequestPage.path,
          name: CancelRequestPage.name,
          pageBuilder: (context, state) => getPage(
            child: const CancelRequestPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: CompleteUrgentRequestPage.path,
          name: CompleteUrgentRequestPage.name,
          pageBuilder: (context, state) => getPage(
            child: const CompleteUrgentRequestPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: FollowUpRegisterPage.path,
          name: FollowUpRegisterPage.name,
          pageBuilder: (context, state) => getPage(
            child: const FollowUpRegisterPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: ChangeHomeServiceRequestTimePage.path,
          name: ChangeHomeServiceRequestTimePage.name,
          pageBuilder: (context, state) => getPage(
            child: const ChangeHomeServiceRequestTimePage(),
            state: state,
          ),
        ),
        GoRoute(
          path: ChangeHomeServiceRequestAddressPage.path,
          name: ChangeHomeServiceRequestAddressPage.name,
          pageBuilder: (context, state) => getPage(
            child: const ChangeHomeServiceRequestAddressPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AssignAndCancelEmdadgarPage.path,
          name: AssignAndCancelEmdadgarPage.name,
          pageBuilder: (context, state) =>
              getPage(
                child: const AssignAndCancelEmdadgarPage(),
                state: state,
              ),
        ),
        GoRoute(
          path: EvaluationAidServiceRequestPage.path,
          name: EvaluationAidServiceRequestPage.name,
          pageBuilder: (context, state) =>
              getPage(
                child: const EvaluationAidServiceRequestPage(),
                state: state,
              ),
        ),
        GoRoute(
          path: HomeServiceEvaluationFirstStep.path,
          name: HomeServiceEvaluationFirstStep.name,
          pageBuilder: (context, state) =>
              getPage(
                child: const HomeServiceEvaluationFirstStep(),
                state: state,
              ),
        ),
        GoRoute(
          path: EvaluationInvoicePage.path,
          name: EvaluationInvoicePage.name,
          pageBuilder: (context, state) {
            final String id = (state.extra as int? ?? 0).toString();
            return getPage(
              child: EvaluationInvoicePage(emdadgarEvaluationId: id),
              state: state,
            );
          },

        ),
        GoRoute(
          path: EmdadVehiclePage.path,
          name: EmdadVehiclePage.name,
          pageBuilder: (context, state) {
            return getPage(
              child: EmdadVehiclePage(),
              state: state,
            );
          },
        ),
        GoRoute(
          path: CartablePage.path,
          name: CartablePage.name,
          pageBuilder: (context, state) {
            return getPage(
              child: CartablePage(),
              state: state,
            );
          },
        ),

        GoRoute(
          path: RescuerListPage.path,
          name: RescuerListPage.name,
          pageBuilder: (context, state) {
            return getPage(
              child: RescuerListPage(),
              state: state,
            );
          },
        ),


        ...EmdadUnitRoutes.routes(getPage),
        ...LeaveRoutes.routes(getPage),
        ...PlanInfoRoutes.routes(getPage),
        ...GradePatternRoutes.routes(getPage),
        ...AgencyInfoRoutes.routes(getPage),
        ...VehicleInfoRoutes.routes(getPage),
        ...SkillsCertificatesRoutes.routes(getPage),
        ...ShiftRoutes.routes(getPage),
        ...ImeiRoutes.routes(getPage),
        ...NavganRoutes.routes(getPage),
        ...VehicleModelRoutes.routes(getPage),
        ...DeploymentLocationRoutes.routes(getPage),
        ...GeneralContentRoutes.routes(getPage),
        ...SpecialPlanRoutes.routes(getPage),
        ...InvoiceManagementRoutes.routes(getPage),
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
