import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/pages/navgan_grade_pattern_form_page.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/pages/navgan_grade_pattern_page.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/pages/navgan_page.dart';
import 'package:eks_sana_plus_org/src/features/navgan/presentation/pages/navgan_services_page.dart';
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
      GoRoute(
        path: NavganGradePatternPage.path,
        name: NavganGradePatternPage.name,
        pageBuilder: (context, state) {
          final navgan = state.extra;
          return getPage(
            child: navgan is NavganEntity
                ? NavganGradePatternPage(navgan: navgan)
                : const NavganPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: NavganServicesPage.path,
        name: NavganServicesPage.name,
        pageBuilder: (context, state) {
          final navgan = state.extra;
          return getPage(
            child: navgan is NavganEntity
                ? NavganServicesPage(navgan: navgan)
                : const NavganPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: NavganGradePatternFormPage.path,
        name: NavganGradePatternFormPage.name,
        pageBuilder: (context, state) {
          final args = state.extra;
          return getPage(
            child: args is NavganGradePatternFormPageArgs
                ? NavganGradePatternFormPage(
                    navgan: args.navgan,
                  )
                : const NavganPage(),
            state: state,
          );
        },
      ),
    ];
  }
}
