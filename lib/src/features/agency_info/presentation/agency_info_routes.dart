import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/add_agency_contract_page.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/add_agency_info_page.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/agency_action_pages.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/pages/agency_contracts_page.dart';
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
      GoRoute(
        path: AgencyContractsPage.path,
        name: AgencyContractsPage.name,
        pageBuilder: (context, state) {
          final agency = state.extra;
          return getPage(
            child: AgencyContractsPage(
              agency: agency is AgencyInfoEntity
                  ? agency
                  : const AgencyInfoEntity(),
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        path: AddAgencyContractPage.path,
        name: AddAgencyContractPage.name,
        pageBuilder: (context, state) {
          final agency = state.extra;
          return getPage(
            child: AddAgencyContractPage(
              agency: agency is AgencyInfoEntity
                  ? agency
                  : const AgencyInfoEntity(),
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        path: AgencyActiveReliefWorkersPage.path,
        name: AgencyActiveReliefWorkersPage.name,
        pageBuilder: (context, state) => getPage(
          child: AgencyActiveReliefWorkersPage(
            agency: _agencyFromExtra(state.extra),
          ),
          state: state,
        ),
      ),
      GoRoute(
        path: AgencyActiveVehiclesPage.path,
        name: AgencyActiveVehiclesPage.name,
        pageBuilder: (context, state) => getPage(
          child: AgencyActiveVehiclesPage(
            agency: _agencyFromExtra(state.extra),
          ),
          state: state,
        ),
      ),
      GoRoute(
        path: AgencyServiceTypesPage.path,
        name: AgencyServiceTypesPage.name,
        pageBuilder: (context, state) => getPage(
          child: AgencyServiceTypesPage(
            agency: _agencyFromExtra(state.extra),
          ),
          state: state,
        ),
      ),
      GoRoute(
        path: AgencyHistoryPage.path,
        name: AgencyHistoryPage.name,
        pageBuilder: (context, state) => getPage(
          child: AgencyHistoryPage(
            agency: _agencyFromExtra(state.extra),
          ),
          state: state,
        ),
      ),

      GoRoute(
        path: AgencyComplementaryInfoPage.path,
        name: AgencyComplementaryInfoPage.name,
        pageBuilder: (context, state) => getPage(
          child: AgencyComplementaryInfoPage(
            agency: _agencyFromExtra(state.extra),
          ),
          state: state,
        ),
      ),
    ];
  }

  static AgencyInfoEntity _agencyFromExtra(Object? extra) {
    return extra is AgencyInfoEntity ? extra : const AgencyInfoEntity();
  }
}
