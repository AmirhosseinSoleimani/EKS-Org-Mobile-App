class NavganJsonHelper {
  const NavganJsonHelper._();

  static String? string(dynamic value) {
    if (value == null) return null;
    final text = value.toString();
    return text.trim().isEmpty ? null : text;
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
    switch (value?.toString().toLowerCase()) {
      case 'true':
      case '1':
        return true;
      case 'false':
      case '0':
        return false;
      default:
        return null;
    }
  }

  static dynamic responseData(Map<String, dynamic> json) {
    return json['data'] ??
        json['Data'] ??
        json['result'] ??
        json['Result'] ??
        json;
  }

  static List<Map<String, dynamic>> mapList(dynamic value) {
    if (value is! List) return const [];

    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  static List<Map<String, dynamic>> pageRecords(Map<String, dynamic> json) {
    if (_isErrorEnvelope(json)) return const [];

    final data = responseData(json);
    if (data is List) return mapList(data);

    if (data is Map) {
      final mappedData = Map<String, dynamic>.from(data);
      if (_isErrorEnvelope(mappedData)) return const [];

      final records = mappedData['records'] ??
          mappedData['Records'] ??
          mappedData['items'] ??
          mappedData['Items'] ??
          mappedData['data'] ??
          mappedData['Data'];
      return mapList(records);
    }

    return const [];
  }

  static int pageCount(Map<String, dynamic> json) {
    if (_isErrorEnvelope(json)) return 0;

    final data = responseData(json);
    if (data is List) return data.length;

    if (data is Map) {
      final mappedData = Map<String, dynamic>.from(data);
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

  static bool isErrorEnvelope(Map<String, dynamic> json) {
    return _isErrorEnvelope(json);
  }

  static bool _isErrorEnvelope(Map<String, dynamic> json) {
    final resultCode = integer(json['resultCode'] ?? json['ResultCode']);
    if (resultCode != null && resultCode != 0) return true;

    final hasMessage = json.containsKey('message') || json.containsKey('Message');
    final hasFailures =
        json.containsKey('failures') || json.containsKey('Failures');
    final hasPageData = json.containsKey('data') ||
        json.containsKey('Data') ||
        json.containsKey('records') ||
        json.containsKey('Records') ||
        json.containsKey('items') ||
        json.containsKey('Items');

    return (hasMessage || hasFailures) && !hasPageData;
  }
}
