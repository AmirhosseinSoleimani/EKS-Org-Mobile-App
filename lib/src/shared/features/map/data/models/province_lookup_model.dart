import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_lookup_entity.dart';

class ProvinceLookupModel extends ProvinceLookupEntity {
  const ProvinceLookupModel({
    required super.id,
    required super.name,
    super.parentId,
    super.code,
    super.type,
    super.isActive,
  });

  factory ProvinceLookupModel.fromJson(Map<String, dynamic> json) {
    return ProvinceLookupModel(
      id: _integer(json['id']) ?? 0,
      parentId: _integer(json['parentId']),
      name: json['name']?.toString().trim() ?? '',
      code: _integer(json['code']),
      type: _integer(json['type']),
      isActive: _boolean(json['isActive']) ?? true,
    );
  }

  static int? _integer(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  static bool? _boolean(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    final normalized = value?.toString().toLowerCase();
    if (normalized == 'true' || normalized == '1') return true;
    if (normalized == 'false' || normalized == '0') return false;
    return null;
  }
}
