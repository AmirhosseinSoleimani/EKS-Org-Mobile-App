import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_filter_param_entity.dart';

class RequestFilterParamModel extends RequestFilterParamEntity {
  const RequestFilterParamModel({
    super.serviceRequestId,
    super.callMobileNumber,
    super.chassisNumber,
    super.rescuerName,
    super.cityName,
    super.provinceName,
    super.requestStatus,
    super.timePeriod,
    super.page = 1,
    super.pageSize = 50,
  });

  Map<String, dynamic> toAidServiceJson() {
    final filters = <Map<String, dynamic>>[];

    final trackCode = int.tryParse(_normalized(serviceRequestId));
    if (trackCode != null && trackCode > 0) {
      filters.add(_filter('trackCode', 'eq', trackCode));
    }

    _addTextFilter(filters, 'callMobileNumber', callMobileNumber);
    _addTextFilter(filters, 'chassisNumber', chassisNumber);
    _addTextFilter(filters, 'cityName', cityName);
    _addTextFilter(filters, 'provinceName', provinceName);

    filters.add(
      _filter(
        'requestStatus',
        'eq',
        requestStatus == 0 ? -100 : requestStatus,
      ),
    );

    _addTextFilter(filters, 'emdadgarTitle', rescuerName);

    return _queryInfo(filters);
  }

  Map<String, dynamic> toHomeServiceJson() {
    final filters = <Map<String, dynamic>>[];

    if (requestStatus != -1) {
      filters.add(_filter('requestStatus', 'eq', requestStatus));
    }

    final trackCode = int.tryParse(_normalized(serviceRequestId));
    if (trackCode != null) {
      filters.add(_filter('trackCode', 'eq', trackCode));
    }

    final mobile = int.tryParse(_normalized(callMobileNumber));
    if (mobile != null) {
      filters.add(_filter('customerMobileNumber', 'eq', mobile));
    }

    _addTextFilter(filters, 'chassisNumber', chassisNumber);
    _addTextFilter(filters, 'emdadgarTitle', rescuerName);
    _addTextFilter(filters, 'provinceName', provinceName);
    _addTextFilter(filters, 'cityName', cityName);

    filters.add(
      _filter(
        'selectedFilter',
        'contains',
        timePeriod?.value ?? TimePeriod.all.value,
      ),
    );

    return _queryInfo(filters);
  }

  Map<String, dynamic> _queryInfo(List<Map<String, dynamic>> filters) {
    return {
      'Filter': {
        'Logic': 'and',
        'Filters': filters,
      },
      'Sort': <Map<String, dynamic>>[],
      'Skip': (page - 1) * pageSize,
      'PageSize': pageSize,
    };
  }

  Map<String, dynamic> _filter(
    String field,
    String operator,
    Object value,
  ) {
    return {
      'Field': field,
      'Operator': operator,
      'Value': value,
    };
  }

  void _addTextFilter(
    List<Map<String, dynamic>> filters,
    String field,
    String? rawValue,
  ) {
    final value = _normalized(rawValue);
    if (value.isEmpty) return;

    filters.add(_filter(field, 'contains', value));
  }

  String _normalized(String? value) => value?.trim() ?? '';
}
