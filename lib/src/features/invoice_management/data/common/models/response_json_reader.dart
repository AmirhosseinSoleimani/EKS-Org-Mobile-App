import 'json_value_reader.dart';

abstract final class ResponseJsonReader {
  static dynamic unwrapData(dynamic raw) {
    final map = JsonValueReader.mapValue(raw);
    if (map.isEmpty) return raw;
    if (map.containsKey('data')) return map['data'];
    if (map.containsKey('Data')) return map['Data'];
    return raw;
  }

  static Map<String, dynamic> object(dynamic raw) {
    return JsonValueReader.mapValue(unwrapData(raw));
  }

  static List<Map<String, dynamic>> records(dynamic raw) {
    final data = unwrapData(raw);
    if (data is List) {
      return data.map(JsonValueReader.mapValue).where((item) => item.isNotEmpty).toList();
    }

    final map = JsonValueReader.mapValue(data);
    final candidate = map['records'] ??
        map['Records'] ??
        map['items'] ??
        map['Items'] ??
        map['data'] ??
        map['Data'];

    if (candidate is List) {
      return candidate.map(JsonValueReader.mapValue).where((item) => item.isNotEmpty).toList();
    }

    return const <Map<String, dynamic>>[];
  }

  static int count(dynamic raw, int fallback) {
    final root = JsonValueReader.mapValue(raw);
    final data = JsonValueReader.mapValue(unwrapData(raw));
    return JsonValueReader.intValue(
          data['count'] ??
              data['Count'] ??
              data['totalCount'] ??
              data['TotalCount'] ??
              data['total'] ??
              data['Total'] ??
              root['count'] ??
              root['Count'] ??
              root['total'] ??
              root['Total'],
        ) ??
        fallback;
  }

  static List<String> failures(dynamic raw) {
    final map = JsonValueReader.mapValue(raw);
    final value = map['failures'] ?? map['Failures'];
    if (value is List) return value.map((item) => item.toString()).toList();
    final text = JsonValueReader.stringValue(value);
    return text == null ? const <String>[] : <String>[text];
  }

  static int resultCode(dynamic raw) {
    final map = JsonValueReader.mapValue(raw);
    return JsonValueReader.intValue(map['resultCode'] ?? map['ResultCode']) ?? 0;
  }
}
