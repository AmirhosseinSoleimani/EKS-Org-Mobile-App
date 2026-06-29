import 'package:eks_sana_plus_org/src/features/cartable/data/models/params/get_subordinated_users_param_model.dart';

class GetSubordinatedUsersParamEntity {
  final bool loadUsers;
  final int? sameAndOneUpperLevelsCartableMessageId;
  final bool includeCartableStats;
  final bool includeUserAvailablilityStatus;
  final bool includeWorkTimespanStatus;

  const GetSubordinatedUsersParamEntity({
    this.loadUsers = true,
    this.sameAndOneUpperLevelsCartableMessageId,
    this.includeCartableStats = true,
    this.includeUserAvailablilityStatus = true,
    this.includeWorkTimespanStatus = true,
  });

  GetSubordinatedUsersParamModel toModel() {
    return GetSubordinatedUsersParamModel(
      loadUsers: loadUsers,
      sameAndOneUpperLevelsCartableMessageId:
      sameAndOneUpperLevelsCartableMessageId,
      includeCartableStats: includeCartableStats,
      includeUserAvailablilityStatus: includeUserAvailablilityStatus,
      includeWorkTimespanStatus: includeWorkTimespanStatus,
    );
  }

  GetSubordinatedUsersParamEntity copyWith({
    bool? loadUsers,
    int? sameAndOneUpperLevelsCartableMessageId,
    bool? includeCartableStats,
    bool? includeUserAvailablilityStatus,
    bool? includeWorkTimespanStatus,
  }) {
    return GetSubordinatedUsersParamEntity(
      loadUsers: loadUsers ?? this.loadUsers,
      sameAndOneUpperLevelsCartableMessageId:
      sameAndOneUpperLevelsCartableMessageId ??
          this.sameAndOneUpperLevelsCartableMessageId,
      includeCartableStats: includeCartableStats ?? this.includeCartableStats,
      includeUserAvailablilityStatus: includeUserAvailablilityStatus ??
          this.includeUserAvailablilityStatus,
      includeWorkTimespanStatus:
      includeWorkTimespanStatus ?? this.includeWorkTimespanStatus,
    );
  }
}