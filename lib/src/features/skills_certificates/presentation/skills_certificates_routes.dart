import 'package:eks_sana_plus_org/src/features/skills_certificates/presentation/skills_certificates_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SkillsCertificatesRoutes {
  static List<RouteBase> routes(Page Function({
    required Widget child,
    required GoRouterState state,
  }) getPage) {
    return [
      GoRoute(
        path: SkillsCertificatesPage.path,
        name: SkillsCertificatesPage.name,
        pageBuilder: (context, state) => getPage(
          child: const SkillsCertificatesPage(),
          state: state,
        ),
      ),
    ];
  }
}
