import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_entity.dart';

enum CurrentSessionSyncStatus {
  success,
  empty,
  failure,
  connectionError,
}

class CurrentSessionSyncResult {
  final CurrentSessionSyncStatus status;
  final CurrentSessionEntity? session;
  final String? message;

  const CurrentSessionSyncResult._({
    required this.status,
    this.session,
    this.message,
  });

  const CurrentSessionSyncResult.success(CurrentSessionEntity session)
      : this._(
    status: CurrentSessionSyncStatus.success,
    session: session,
  );

  const CurrentSessionSyncResult.empty()
      : this._(
    status: CurrentSessionSyncStatus.empty,
    message: 'اطلاعات نشست کاربر دریافت نشد.',
  );

  const CurrentSessionSyncResult.failure([String? message])
      : this._(
    status: CurrentSessionSyncStatus.failure,
    message: message,
  );

  const CurrentSessionSyncResult.connectionError()
      : this._(
    status: CurrentSessionSyncStatus.connectionError,
  );

  bool get isSuccess => status == CurrentSessionSyncStatus.success;
}