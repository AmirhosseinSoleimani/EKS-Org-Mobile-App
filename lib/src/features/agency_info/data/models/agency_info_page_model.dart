import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_page_entity.dart';

class AgencyInfoPageModel extends AgencyInfoPageEntity {
  const AgencyInfoPageModel({
    required super.records,
    required super.count,
  });

  factory AgencyInfoPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json['Data'];
    final records = data is Map<String, dynamic> ? data['records'] ?? data['Records'] : null;
    final count = data is Map<String, dynamic> ? data['count'] ?? data['Count'] : null;

    return AgencyInfoPageModel(
      count: count is int ? count : 0,
      records: records is List
          ? records
              .map((item) => AgencyInfoModel.fromJson(Map<String, dynamic>.from(item as Map)))
              .toList()
          : const [],
    );
  }
}
