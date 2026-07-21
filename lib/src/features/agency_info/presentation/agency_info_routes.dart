import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/add_agency_info_page.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/agency_info_details_page.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/agency_info_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef AgencyInfoPageBuilder = Page<dynamic> Function({
  required Widget child,
  required GoRouterState state,
});

class AgencyInfoRoutes {
  const AgencyInfoRoutes._();

  static List<RouteBase> routes(AgencyInfoPageBuilder getPage) {
    return [
      GoRoute(
        path: AgencyInfoListPage.path,
        name: AgencyInfoListPage.name,
        pageBuilder: (context, state) => getPage(
          child: const AgencyInfoListPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: AddAgencyInfoPage.path,
        name: AddAgencyInfoPage.name,
        pageBuilder: (context, state) => getPage(
          child: const AddAgencyInfoPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: AgencyInfoDetailsPage.path,
        name: AgencyInfoDetailsPage.name,
        pageBuilder: (context, state) {
          final extra = state.extra;
          return getPage(
            child: AgencyInfoDetailsPage(
              id: extra is int ? extra : null,
              item: extra is AgencyInfoEntity ? extra : null,
            ),
            state: state,
          );
        },
      ),
    ];
  }
}
