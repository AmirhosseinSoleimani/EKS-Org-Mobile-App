import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/service_assign_response_entity.dart';

class ServiceAssignResponseModel extends ServiceAssignResponseEntity {
  ServiceAssignResponseModel({super.extraData});

  factory ServiceAssignResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceAssignResponseModel(
      extraData: json["extraData"] != null
          ? ServiceAssignExtraDataModel.fromJson(json["extraData"])
          : null,
    );
  }
}
class ServiceAssignExtraDataModel extends ServiceAssignExtraDataEntity {
  ServiceAssignExtraDataModel({super.cartableReceiverFullname});

  factory ServiceAssignExtraDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceAssignExtraDataModel(
      cartableReceiverFullname: json["cartableReceiverFullname"],
    );
  }
}
