import 'package:eks_sana_plus_org/src/features/services/data/models/non_cooperation_item_model.dart';

import 'non_cooperation_item_entity.dart';

class NonCooperationListEntity {
  final List<NonCooperationItemEntity> records;
  final int count;

  NonCooperationListEntity({
    this.records = const <NonCooperationItemEntity>[],
    this.count = 0,
  });

  factory NonCooperationListEntity.fromJson(Map<String, dynamic> json) {
    return NonCooperationListEntity(
      records: (json['records'] as List)
          .map((e) => NonCooperationItemModel.fromJson(e))
          .toList(),
      count: json['count'],
    );
  }
}
