import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_mutation_request_model.dart';

class ImeiInfoMutationParamEntity {
  const ImeiInfoMutationParamEntity({
    this.id,
    required this.simNumber,
    required this.deviceId,
    required this.imei,
    required this.avlSerial,
    required this.isActive,
  });

  final int? id;
  final String simNumber;
  final int deviceId;
  final String imei;
  final String avlSerial;
  final bool isActive;

  ImeiInfoMutationRequestModel toModel() {
    return ImeiInfoMutationRequestModel(
      id: id,
      simNumber: simNumber,
      deviceId: deviceId,
      imei: imei,
      avlSerial: avlSerial,
      isActive: isActive,
    );
  }
}
