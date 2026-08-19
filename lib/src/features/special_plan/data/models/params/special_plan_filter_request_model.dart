import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';

class SpecialPlanFilterRequestModel {
  const SpecialPlanFilterRequestModel({required this.param});

  factory SpecialPlanFilterRequestModel.fromParam(
    SpecialPlanFilterParamEntity param,
  ) => SpecialPlanFilterRequestModel(param: param);

  final SpecialPlanFilterParamEntity param;

  Map<String, dynamic> toJson() {
    final filters = <Map<String, dynamic>>[];
    _add(filters, 'title', 'contains', param.title);
    _add(filters, 'productId', 'eq', param.productId);
    _add(filters, 'hasHighPriority', 'eq', param.hasHighPriority);
    _add(
      filters,
      'startDate',
      'eq',
      JalaliDateHelper.formatServerDateOnly(param.startDate),
    );
    _add(
      filters,
      'endDate',
      'eq',
      JalaliDateHelper.formatServerDateOnly(param.endDate),
    );
    _add(filters, 'orderNo', 'eq', param.orderNo);
    _add(filters, 'provinceTitle', 'contains', param.provinceTitle);
    _add(filters, 'cityTitle', 'contains', param.cityTitle);
    _add(filters, 'isActive', 'eq', param.isActive);
    _add(filters, 'onlySaipaCars', 'eq', param.onlySaipaCars);

    return {
      'Sort': <dynamic>[],
      'Filter': {
        'Logic': 'and',
        'Filters': filters,
      },
      'Skip': param.skip,
      'PageSize': param.pageSize,
    };
  }

  void _add(
    List<Map<String, dynamic>> filters,
    String field,
    String operator,
    Object? value,
  ) {
    if (value == null) return;
    if (value is String && value.trim().isEmpty) return;
    filters.add({
      'Field': field,
      'Operator': operator,
      'Value': value,
    });
  }
}
