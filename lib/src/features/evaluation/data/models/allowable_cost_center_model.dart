import '../../domain/entities/allowable_cost_center_entity.dart';

class AllowableCostCenterModel extends AllowableCostCenterEntity {
  const AllowableCostCenterModel({
    super.id,
    super.code,
    super.name,
    super.selected,
    super.nahveMohasebeType,
  });

  factory AllowableCostCenterModel.fromJson(Map<String, dynamic> json) {
    return AllowableCostCenterModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      selected: json['selected'],
      nahveMohasebeType: json['nahveMohasebeType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'selected': selected,
      'nahveMohasebeType': nahveMohasebeType,
    };
  }
}