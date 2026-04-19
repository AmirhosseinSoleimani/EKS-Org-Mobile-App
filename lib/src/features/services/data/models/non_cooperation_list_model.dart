import 'package:eks_sana_plus_org/src/features/services/data/models/non_cooperation_item_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_list_entity.dart';

class NonCooperationListModel extends NonCooperationListEntity {
  NonCooperationListModel({
    super.records = const <NonCooperationItemEntity>[],
    super.count,
  });

  factory NonCooperationListModel.fromJson(Map<String, dynamic> json) {
    return NonCooperationListModel(
      records: (json['records'] as List)
          .map((e) => NonCooperationItemModel.fromJson(e))
          .toList(),
      count: json['count'],
    );
  }
}
