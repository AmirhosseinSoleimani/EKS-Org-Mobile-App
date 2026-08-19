import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';

class SpecialPlanFormRequestModel {
  const SpecialPlanFormRequestModel({required this.param});

  factory SpecialPlanFormRequestModel.fromParam(
    SpecialPlanFormParamEntity param,
  ) => SpecialPlanFormRequestModel(param: param);

  final SpecialPlanFormParamEntity param;

  Map<String, dynamic> toCreateJson() => {
        'title': param.title,
        'productId': param.productId,
        'startDate': JalaliDateHelper.formatServerUtcIsoDateTime(param.startDate),
        'endDate': JalaliDateHelper.formatServerUtcIsoDateTime(param.endDate),
        'areaBaseInfoId': param.areaBaseInfoId,
        'hasHighPriority': param.hasHighPriority,
        'message': '',
        'orderNo': param.orderNo,
        'isActive': param.isActive,
        'provinceId': '',
        'cityId': '',
        'onlySaipaCars': param.onlySaipaCars,
      };

  Map<String, dynamic> toUpdateJson() {
    final json = toCreateJson()
      ..remove('message')
      ..remove('provinceId')
      ..remove('cityId');
    return {
      ...json,
      'id': param.id,
    };
  }
}
