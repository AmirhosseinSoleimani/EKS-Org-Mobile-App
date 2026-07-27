import 'package:eks_sana_plus_org/src/features/imei/presentation/pages/imei_page.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/pages/imei_form_page.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImeiRoutes {
  const ImeiRoutes._();
  static List<RouteBase> routes(Page Function({
  required Widget child,
  required GoRouterState state,
  }) getPage) {
    return [
      GoRoute(
        path: ImeiPage.path,
        name: ImeiPage.name,
        pageBuilder: (context, state) => getPage(
          child: const ImeiPage(),
          state: state,
        ),
      ),
      GoRoute(
        path: ImeiFormPage.addPath,
        name: ImeiFormPage.addName,
        pageBuilder: (context, state) => getPage(
          child: const ImeiFormPage(isEdit: false),
          state: state,
        ),
      ),
      GoRoute(
        path: ImeiFormPage.editPath,
        name: ImeiFormPage.editName,
        pageBuilder: (context, state) {
          final item = state.extra;
          return getPage(
            child: ImeiFormPage(
              isEdit: true,
              item: item is ImeiInfoEntity ? item : null,
            ),
            state: state,
          );
        },
      ),
    ];
  }
}
