import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_cartable_items_param_entity.dart';

class GetCartableItemParamModel
    extends GetCartableItemParamEntity {
  const GetCartableItemParamModel({
    required super.userGuid,
    required super.includeSnoozedMessages,
    required super.pageSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserGuid': userGuid,
      'IncludeSnoozedMessages':
      null,
      'Filter': {
        'Logic': 'and',
        'Filters': <dynamic>[],
      },
      'Sort': <dynamic>[],
      'Skip': 0,
      'PageSize': pageSize,
    };
  }
}