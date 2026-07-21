import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_model_entity.dart';

class VehicleModelModel extends VehicleModelEntity {
  const VehicleModelModel({
    required super.id,
    super.name,
    super.code,
    super.navganTypeId,
    super.navganTypeTitle,
    super.navganTypeCode,
    super.isActive,
    super.hasDepot,
    super.type,
  });

  factory VehicleModelModel.fromJson(Map<String, dynamic> json) {
    return VehicleModelModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? json['title'] as String?,
      code: json['code']?.toString(),
      navganTypeId: json['navganTypeId'] as int?,
      navganTypeTitle: json['navganTypeTitle'] as String?,
      navganTypeCode: json['navganTypeCode']?.toString(),
      isActive: json['isActive'] as bool?,
      hasDepot: json['hasDepot'] as bool?,
      type: json['type']?.toString(),
    );
  }
}

class VehicleModelPageModel {
  const VehicleModelPageModel({
    required this.records,
    required this.count,
  });

  final List<VehicleModelModel> records;
  final int count;

  factory VehicleModelPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json['Data'];
    final records = data is Map<String, dynamic> ? data['records'] ?? data['Records'] : null;
    final count = data is Map<String, dynamic> ? data['count'] ?? data['Count'] : null;

    return VehicleModelPageModel(
      count: count is int ? count : 0,
      records: records is List
          ? records.map((item) => VehicleModelModel.fromJson(Map<String, dynamic>.from(item as Map))).toList()
          : const [],
    );
  }
}
