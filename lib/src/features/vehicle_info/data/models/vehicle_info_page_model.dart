import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_page_entity.dart';

class VehicleInfoPageModel extends VehicleInfoPageEntity {
  const VehicleInfoPageModel({
    required super.records,
    required super.count,
  });

  factory VehicleInfoPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json['Data'];
    final records = data is Map<String, dynamic> ? data['records'] ?? data['Records'] : null;
    final count = data is Map<String, dynamic> ? data['count'] ?? data['Count'] : null;

    return VehicleInfoPageModel(
      count: count is int ? count : 0,
      records: records is List
          ? records.map((item) => VehicleInfoModel.fromJson(Map<String, dynamic>.from(item as Map))).toList()
          : const [],
    );
  }
}
