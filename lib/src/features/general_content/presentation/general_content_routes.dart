import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/pages/general_content_page.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/pages/general_content_targets_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GeneralContentRoutes {
  const GeneralContentRoutes._();

  static List<RouteBase> routes(
    Page Function({
      required Widget child,
      required GoRouterState state,
    }) getPage,
  ) {
    return [
      GoRoute(
        path: GeneralContentPage.path,
        name: GeneralContentPage.name,
        pageBuilder: (context, state) => getPage(
          child: const GeneralContentPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: GeneralContentTargetsPage.path,
        name: GeneralContentTargetsPage.name,
        pageBuilder: (context, state) {
          final content = state.extra;
          return getPage(
            child: content is GeneralContentEntity
                ? GeneralContentTargetsPage(content: content)
                : const GeneralContentPage(),
            state: state,
          );
        },
      ),
    ];
  }
}
