import 'package:eks_sana_plus_org/src/features/services/data/models/params/minimal_customer_info_param_model.dart';

class MinimalCustomerInfoParamEntity {
  final String nationalNo;

  const MinimalCustomerInfoParamEntity({required this.nationalNo});

  MinimalCustomerInfoParamEntity copyWith({String? nationalNo}) {
    return MinimalCustomerInfoParamEntity(
      nationalNo: nationalNo ?? this.nationalNo,
    );
  }

  MinimalCustomerInfoParamModel toModel() {
    return MinimalCustomerInfoParamModel(nationalNo: nationalNo);
  }
}
