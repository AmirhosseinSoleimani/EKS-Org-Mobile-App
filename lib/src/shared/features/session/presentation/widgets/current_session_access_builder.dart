import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/policies/current_session_access_policy.dart';
import 'package:flutter/material.dart';

class CurrentSessionAccessBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, CurrentSessionAccessPolicy access)
  builder;

  final Widget Function(BuildContext context)? emptyBuilder;

  const CurrentSessionAccessBuilder({
    super.key,
    required this.builder,
    this.emptyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final currentSessionManager = getIt<CurrentSessionManager>();

    return StreamBuilder(
      stream: currentSessionManager.currentSessionStream,
      initialData: currentSessionManager.currentSession,
      builder: (context, snapshot) {
        final currentSession = snapshot.data;

        if (currentSession == null) {
          return emptyBuilder?.call(context) ?? const SizedBox.shrink();
        }

        return builder(context, CurrentSessionAccessPolicy(currentSession));
      },
    );
  }
}
