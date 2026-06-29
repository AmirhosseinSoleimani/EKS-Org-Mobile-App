import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_subordinated_users_param_entity.dart';

class GetSubordinatedUsersParamModel
    extends GetSubordinatedUsersParamEntity {
  const GetSubordinatedUsersParamModel({
    super.loadUsers,
    super.sameAndOneUpperLevelsCartableMessageId,
    super.includeCartableStats,
    super.includeUserAvailablilityStatus,
    super.includeWorkTimespanStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'loadUsers': loadUsers,
      'sameAndOneUpperLevelsCartableMessageId':
      sameAndOneUpperLevelsCartableMessageId,
      'includeCartableStats': includeCartableStats,
      'includeUserAvailablilityStatus': includeUserAvailablilityStatus,
      'includeWorkTimespanStatus': includeWorkTimespanStatus,
    };
  }
}