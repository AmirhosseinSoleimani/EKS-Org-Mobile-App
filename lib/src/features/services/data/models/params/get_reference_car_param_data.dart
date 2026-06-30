import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_reference_car_param_entity.dart';

class GetReferenceCarParamModel extends GetReferenceCarParamEntity {
  const GetReferenceCarParamModel({super.chassisNo});

  factory GetReferenceCarParamModel.fromJson(Map<String, dynamic> json) {
    return GetReferenceCarParamModel(chassisNo: json['chassisNo']);
  }

  Map<String, dynamic> toJson() {
    return {"chassisNo": chassisNo};
  }
}
