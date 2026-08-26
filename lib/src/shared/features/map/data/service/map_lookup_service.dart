import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/discountable_area_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/province_lookup_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MapLookupService {
  MapLookupService(this._dio);

  final Dio _dio;

  Future<BaseSingleResponse<List<ProvinceLookupModel>>>
      getProvinceLookupList() async {
    final response = await _dio.get<dynamic>('/api/City/GetListProvince');
    return _listResponse(
      response.data,
      ProvinceLookupModel.fromJson,
    );
  }

  Future<BaseSingleResponse<List<DiscountableAreaModel>>>
      getDiscountableAreas({int areaBusinessUsageType = 4}) async {
    final response = await _dio.get<dynamic>(
      '/api/AreaBaseInfo/GetDiscountableAreas',
      queryParameters: {
        'areaBusinessUsageType': areaBusinessUsageType,
      },
    );
    return _listResponse(
      response.data,
      DiscountableAreaModel.fromJson,
    );
  }

  BaseSingleResponse<List<T>> _listResponse<T>(
    dynamic rawResponse,
    T Function(Map<String, dynamic>) mapper,
  ) {
    final root = rawResponse is Map
        ? Map<String, dynamic>.from(rawResponse)
        : <String, dynamic>{};
    final resultCode =
        _integer(root['resultCode'] ?? root['ResultCode']) ?? 0;
    final models = resultCode == 0
        ? _readRecords(rawResponse)
            .whereType<Map>()
            .map((item) => mapper(Map<String, dynamic>.from(item)))
            .toList(growable: false)
        : null;

    return BaseSingleResponse<List<T>>(
      resultCode: resultCode,
      data: models,
      failures: _failures(root),
    );
  }

  List<dynamic> _readRecords(dynamic response) {
    if (response is List) return response;
    if (response is! Map) return const [];

    final root = Map<String, dynamic>.from(response);
    final data = root['data'] ?? root['Data'];
    if (data is List) return data;
    if (data is Map) {
      final nested = data['records'] ??
          data['Records'] ??
          data['items'] ??
          data['Items'];
      return nested is List ? nested : const [];
    }

    final rootRecords = root['records'] ?? root['Records'];
    return rootRecords is List ? rootRecords : const [];
  }

  List<String> _failures(Map<String, dynamic> json) {
    final raw = json['failures'] ?? json['Failures'];
    final message = json['message'] ?? json['Message'];
    if (raw is List) {
      return raw
          .map((item) => item.toString())
          .where((item) => item.trim().isNotEmpty)
          .toList(growable: false);
    }
    if (raw?.toString().trim().isNotEmpty == true) {
      return [raw.toString()];
    }
    if (message?.toString().trim().isNotEmpty == true) {
      return [message.toString()];
    }
    return const [];
  }

  int? _integer(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }
}
