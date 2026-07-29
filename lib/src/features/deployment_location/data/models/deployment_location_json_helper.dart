class DeploymentLocationJsonHelper {
  const DeploymentLocationJsonHelper._();

  static String? string(dynamic value) {
    final result = value?.toString().trim();
    return result == null || result.isEmpty ? null : result;
  }

  static int? integer(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  static double? decimal(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '');
  }

  static bool? boolean(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    final normalized = value?.toString().trim().toLowerCase();
    if (normalized == 'true' || normalized == '1') return true;
    if (normalized == 'false' || normalized == '0') return false;
    return null;
  }

  static List<Map<String, dynamic>> mapList(dynamic value) {
    if (value is! List) return const [];
    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList(growable: false);
  }

  static dynamic responseData(Map<String, dynamic> json) {
    return json['data'] ?? json['Data'];
  }

  static Map<String, dynamic> objectData(Map<String, dynamic> json) {
    final data = responseData(json);
    if (data is Map) return Map<String, dynamic>.from(data);
    return json;
  }

  static List<Map<String, dynamic>> pageRecords(Map<String, dynamic> json) {
    final data = responseData(json);
    final source = data ?? json;
    if (source is List) return mapList(source);
    if (source is Map) {
      final mappedData = Map<String, dynamic>.from(source);
      return mapList(
        mappedData['records'] ??
            mappedData['Records'] ??
            mappedData['items'] ??
            mappedData['Items'] ??
            mappedData['data'] ??
            mappedData['Data'],
      );
    }
    return const [];
  }

  static int pageCount(Map<String, dynamic> json) {
    final data = responseData(json);
    final source = data ?? json;
    if (source is List) return source.length;
    if (source is Map) {
      final mappedData = Map<String, dynamic>.from(source);
      return integer(
            mappedData['count'] ??
                mappedData['Count'] ??
                mappedData['totalCount'] ??
                mappedData['TotalCount'],
          ) ??
          pageRecords(json).length;
    }
    return 0;
  }
}
