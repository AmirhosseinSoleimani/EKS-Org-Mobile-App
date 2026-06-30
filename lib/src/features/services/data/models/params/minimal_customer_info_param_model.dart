import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/minimal_customer_info_param_entity.dart';

class MinimalCustomerInfoParamModel
    extends MinimalCustomerInfoParamEntity {
  const MinimalCustomerInfoParamModel({required super.nationalNo});

  Map<String, dynamic> toJson() {
    return {"nationalNo": nationalNo};
  }
}
