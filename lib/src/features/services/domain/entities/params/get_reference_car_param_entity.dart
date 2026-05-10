import 'package:eks_sana_plus_org/src/features/services/data/models/params/get_reference_car_param_data.dart';

class GetReferenceCarParamEntity {
  final String? chassisNo;

  const GetReferenceCarParamEntity({this.chassisNo});

  GetReferenceCarParamEntity copyWith({String? chassisNo}) {
    return GetReferenceCarParamEntity(chassisNo: chassisNo ?? this.chassisNo);
  }

  GetReferenceCarParamModel toModel() {
    return GetReferenceCarParamModel(chassisNo: chassisNo);
  }
}
