import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/pages/vehicle_info_form_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/pages/vehicle_info_history_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/pages/vehicle_info_list_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/pages/vehicle_info_services_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/pages/vehicle_info_tools_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef VehicleInfoPageBuilder = Page<dynamic> Function({
  required Widget child,
  required GoRouterState state,
});

class VehicleInfoRoutes {
  const VehicleInfoRoutes._();

  static List<RouteBase> routes(VehicleInfoPageBuilder getPage) {
    return [
      GoRoute(
        path: VehicleInfoListPage.path,
        name: VehicleInfoListPage.name,
        pageBuilder: (context, state) => getPage(
          child: const VehicleInfoListPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: VehicleInfoFormPage.path,
        name: VehicleInfoFormPage.name,
        pageBuilder: (context, state) => getPage(
          child: VehicleInfoFormPage(id: state.extra as int?),
          state: state,
        ),
      ),
      GoRoute(
        path: VehicleInfoToolsPage.path,
        name: VehicleInfoToolsPage.name,
        pageBuilder: (context, state) {
          final item = state.extra as VehicleInfoEntity;
          return getPage(child: VehicleInfoToolsPage(item: item), state: state);
        },
      ),
      GoRoute(
        path: VehicleInfoServicesPage.path,
        name: VehicleInfoServicesPage.name,
        pageBuilder: (context, state) {
          final item = state.extra as VehicleInfoEntity;
          return getPage(child: VehicleInfoServicesPage(item: item), state: state);
        },
      ),
      GoRoute(
        path: VehicleInfoHistoryPage.path,
        name: VehicleInfoHistoryPage.name,
        pageBuilder: (context, state) {
          final item = state.extra as VehicleInfoEntity;
          return getPage(child: VehicleInfoHistoryPage(item: item), state: state);
        },
      ),
    ];
  }
}
