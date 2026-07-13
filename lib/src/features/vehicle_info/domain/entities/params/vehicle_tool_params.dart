class GetVehicleToolsParamEntity {
  const GetVehicleToolsParamEntity({required this.vehicleId});

  final int vehicleId;

  Map<String, dynamic> toJson() => {'vehicleId': vehicleId};
}

class SubmitVehicleToolsParamEntity {
  const SubmitVehicleToolsParamEntity({
    required this.vehicleId,
    required this.emdadToolsIds,
  });

  final int vehicleId;
  final List<int> emdadToolsIds;

  Map<String, dynamic> toJson() => {
        'vehicleId': vehicleId,
        'emdadToolsIds': emdadToolsIds,
      };
}
