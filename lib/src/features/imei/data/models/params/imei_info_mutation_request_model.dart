class ImeiInfoMutationRequestModel {
  const ImeiInfoMutationRequestModel({
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

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'simNumber': simNumber,
      'deviceId': id == null ? deviceId.toString() : deviceId,
      'imei': imei,
      'avlSerial': avlSerial,
      'isActive': isActive,
    };
  }
}
