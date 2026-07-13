class UpdateEmdadUnitImageParamEntity {
  const UpdateEmdadUnitImageParamEntity({
    required this.emdadUnitId,
    required this.imageBase64,
    required this.isActive,
  });

  final int emdadUnitId;
  final String imageBase64;
  final bool isActive;

  Map<String, dynamic> toJson() {
    return {
      'emdadUnitId': emdadUnitId,
      'imageBase64': imageBase64,
      'isActive': isActive,
    };
  }
}
