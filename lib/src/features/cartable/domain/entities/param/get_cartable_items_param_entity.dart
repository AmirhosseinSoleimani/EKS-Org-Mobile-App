import 'package:eks_sana_plus_org/src/features/cartable/data/models/params/get_cartable_items_param_model.dart';

class GetCartableItemParamEntity {
  final String userGuid;
  final bool includeSnoozedMessages;
  final int pageSize;

  const GetCartableItemParamEntity({
    required this.userGuid,
    required this.includeSnoozedMessages,
    required this.pageSize,
  });

  GetCartableItemParamModel toModel() {
    return GetCartableItemParamModel(
      userGuid: userGuid,
      includeSnoozedMessages: includeSnoozedMessages,
      pageSize: pageSize,
    );
  }

  GetCartableItemParamEntity copyWith({
    String? userGuid,
    bool? includeSnoozedMessages,
    int? pageSize,
  }) {
    return GetCartableItemParamEntity(
      userGuid: userGuid ?? this.userGuid,
      includeSnoozedMessages:
          includeSnoozedMessages ?? this.includeSnoozedMessages,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
