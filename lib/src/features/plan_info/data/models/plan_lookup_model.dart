import '../../domain/entities/plan_lookup_entity.dart';

class PlanLookupModel extends PlanLookupEntity {
  const PlanLookupModel({
    super.id,
    super.value,
    super.title,
    super.name,
    super.latitude,
    super.longitude,
    super.address,
  });

  factory PlanLookupModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PlanLookupModel();

    return PlanLookupModel(
      id: _asInt(json['id']),
      value: _asInt(json['value']),
      title: _asString(json['title']),
      name: _asString(json['name']),
      latitude: _asDouble(json['latitude']),
      longitude: _asDouble(json['longitude']),
      address: _asString(json['address']),
    );
  }
}

class PlanLookupListModel {
  final List<PlanLookupModel> records;
  final int count;

  const PlanLookupListModel({
    required this.records,
    required this.count,
  });

  factory PlanLookupListModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const PlanLookupListModel(records: [], count: 0);
    }

    final rawData = json['data'] ?? json['Data'];
    final mappedData = rawData is Map<String, dynamic> ? rawData : json;
    final rawRecords = mappedData['records'] ??
        mappedData['Records'] ??
        mappedData['items'] ??
        mappedData['Items'] ??
        (rawData is List ? rawData : null);
    return PlanLookupListModel(
      records: rawRecords is List
          ? rawRecords
              .whereType<Map>()
              .map((item) => PlanLookupModel.fromJson(
                    Map<String, dynamic>.from(item),
                  ))
              .toList()
          : const [],
      count: _asInt(
            mappedData['count'] ??
                mappedData['Count'] ??
                mappedData['totalCount'] ??
                mappedData['TotalCount'],
          ) ??
          (rawRecords is List ? rawRecords.length : 0),
    );
  }
}

int? _asInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

double? _asDouble(Object? value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

String? _asString(Object? value) {
  if (value == null) return null;
  return value.toString();
}
