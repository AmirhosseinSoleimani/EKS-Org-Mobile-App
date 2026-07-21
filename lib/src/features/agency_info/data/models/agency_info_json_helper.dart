class AgencyInfoJsonHelper {
  const AgencyInfoJsonHelper._();

  static String? string(dynamic value) {
    if (value == null) {
      return null;
    }
    return value.toString();
  }

  static int? integer(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '');
  }

  static double? decimal(dynamic value) {
    if (value is double) {
      return value;
    }
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value?.toString() ?? '');
  }

  static bool? boolean(dynamic value) {
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
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

  static List<Map<String, dynamic>> mapList(dynamic value) {
    if (value is! List) {
      return const [];
    }

    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  static dynamic responseData(Map<String, dynamic> json) {
    return json['data'] ??
        json['Data'] ??
        json['result'] ??
        json['Result'] ??
        json;
  }

  static List<Map<String, dynamic>> pageRecords(Map<String, dynamic> json) {
    final data = responseData(json);

    if (data is List) {
      return mapList(data);
    }

    if (data is Map) {
      final mappedData = Map<String, dynamic>.from(data);
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

  static int? pageCount(Map<String, dynamic> json) {
    final data = responseData(json);

    if (data is List) {
      return data.length;
    }

    if (data is Map) {
      final mappedData = Map<String, dynamic>.from(data);
      return integer(
        mappedData['count'] ??
            mappedData['Count'] ??
            mappedData['totalCount'] ??
            mappedData['TotalCount'],
      );
    }

    return null;
  }
}
