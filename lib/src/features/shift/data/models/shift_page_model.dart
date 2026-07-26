import 'package:eks_sana_plus_org/src/features/shift/data/models/shift_model.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_page_entity.dart';

class ShiftPageModel extends ShiftPageEntity {
  const ShiftPageModel({
    required super.records,
    required super.count,
  });

  factory ShiftPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json['Data'] is Map<String, dynamic>
            ? json['Data'] as Map<String, dynamic>
            : json;
    final records = data['records'] ?? data['Records'];
    final count = data['count'] ?? data['Count'];

    return ShiftPageModel(
      count: count is int ? count : int.tryParse(count?.toString() ?? '') ?? 0,
      records: records is List
          ? records
              .whereType<Map>()
              .map((item) => ShiftModel.fromJson(
                    Map<String, dynamic>.from(item),
                  ))
              .toList()
          : const [],
    );
  }
}
