import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/pages/grade_pattern_form_page.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/pages/grade_pattern_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef GradePatternPageBuilder = Page Function({
  required Widget child,
  required GoRouterState state,
});

class GradePatternRoutes {
  const GradePatternRoutes._();

  static List<RouteBase> routes(GradePatternPageBuilder getPage) {
    return [
      GoRoute(
        path: GradePatternListPage.path,
        name: GradePatternListPage.name,
        pageBuilder: (context, state) => getPage(
          child: const GradePatternListPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: GradePatternFormPage.path,
        name: GradePatternFormPage.name,
        pageBuilder: (context, state) {
          final id = state.extra as int?;
          return getPage(
            child: GradePatternFormPage(id: id),
            state: state,
          );
        },
      ),
    ];
  }
}
