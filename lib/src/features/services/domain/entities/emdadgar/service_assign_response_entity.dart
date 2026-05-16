import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/service_assign_response_model.dart';

class ServiceAssignResponseEntity {
  ServiceAssignExtraDataEntity? extraData;

  ServiceAssignResponseEntity({this.extraData});

  ServiceAssignResponseEntity copyWith({
    ServiceAssignExtraDataEntity? extraData,
  }) {
    return ServiceAssignResponseEntity(
      extraData: extraData ?? this.extraData,
    );
  }

  ServiceAssignResponseModel toModel() {
    return ServiceAssignResponseModel(
      extraData: extraData,
    );
  }
}


class ServiceAssignExtraDataEntity {
  String? cartableReceiverFullname;

  ServiceAssignExtraDataEntity({this.cartableReceiverFullname});

  ServiceAssignExtraDataEntity copyWith({
    String? cartableReceiverFullname,
  }) {
    return ServiceAssignExtraDataEntity(
      cartableReceiverFullname:
      cartableReceiverFullname ?? this.cartableReceiverFullname,
    );
  }

  ServiceAssignExtraDataModel toModel() {
    return ServiceAssignExtraDataModel(
      cartableReceiverFullname: cartableReceiverFullname,
    );
  }
}

