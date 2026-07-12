import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/lookup_entity.dart';

class LookupModel extends LookupEntity {
  const LookupModel({
    required super.id,
    required super.title,
    super.latitude,
    super.longitude,
    super.address,
    super.extra,
  });

  factory LookupModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int? ?? 0;
    final title = json['title'] ??
        json['name'] ??
        json['fullName'] ??
        json['agencyInfoTitle'] ??
        '';

    return LookupModel(
      id: id,
      title: title.toString(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
      extra: json,
    );
  }
}
