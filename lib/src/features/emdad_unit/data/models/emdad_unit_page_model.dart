import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_page_entity.dart';

class EmdadUnitPageModel extends EmdadUnitPageEntity {
  const EmdadUnitPageModel({
    required super.records,
    required super.count,
  });

  factory EmdadUnitPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final records = data is Map<String, dynamic> ? data['records'] : null;
    final count = data is Map<String, dynamic> ? data['count'] : null;

    return EmdadUnitPageModel(
      count: count is int ? count : 0,
      records: records is List
          ? records
          .map((item) => EmdadUnitModel.fromJson(
        Map<String, dynamic>.from(item as Map),
      ))
          .toList()
          : const [],
    );
  }
}
